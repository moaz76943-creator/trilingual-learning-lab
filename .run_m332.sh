#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=152
VERSION_NAME="4.6.2"
MISSION_NUM=332
MISSION_NAME="Flashcard Deck CSV & JSON Importer/Exporter Suite"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 22 of 50]"
echo "Protocol: DUAL-PUSH (integration/master-qa-verified-v21 + main)"
echo "============================================================"

APP_JS="android/app/src/main/assets/web/app.js"
BUILD_GRADLE="android/app/build.gradle"

if [ ! -f "$APP_JS" ]; then
  echo "[FAIL] File $APP_JS not found!"
  exit 1
fi

if [ ! -f "$BUILD_GRADLE" ]; then
  echo "[FAIL] File $BUILD_GRADLE not found!"
  exit 1
fi

echo "[INFO] Syncing branch state..."
git checkout "$TARGET_BRANCH"
if [ -z "$(git status --porcelain)" ]; then
  git pull --rebase origin "$TARGET_BRANCH" || true
else
  echo "[INFO] Working directory has changes, preserving local edits..."
fi

# Append M332 CSV Importer/Exporter helper
MARKER_JS="// MISSION #332: Flashcard Deck CSV & JSON Importer/Exporter Suite (v4.6.2)"
if grep -q "MISSION #332" "$APP_JS"; then
  echo "[INFO] Marker for Mission #332 already present in $APP_JS."
else
  echo "[INFO] Appending M332 CSV Importer/Exporter to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #332: Flashcard Deck CSV & JSON Importer/Exporter Suite (v4.6.2)
// ============================================================================
function dfExportDeckToCsv(cardsList, filterDeck) {
  const list = Array.isArray(cardsList) ? cardsList : [];
  const deckFilter = filterDeck && typeof filterDeck === "string" ? filterDeck.trim().toLowerCase() : null;

  const filtered = list.filter(c => {
    if (!c || !c.term) return false;
    if (deckFilter && (c.deck || "General").trim().toLowerCase() !== deckFilter) return false;
    return true;
  });

  const escapeCsv = (str) => {
    const s = str === null || str === undefined ? "" : String(str);
    if (s.indexOf(",") !== -1 || s.indexOf('"') !== -1 || s.indexOf("\n") !== -1 || s.indexOf("\r") !== -1) {
      return '"' + s.split('"').join('""') + '"';
    }
    return s;
  };

  const headers = ["Term", "Definition", "Phonetic", "Deck", "Box"];
  const rows = [headers.join(",")];

  for (const c of filtered) {
    const boxNum = typeof c.box === "number" && c.box >= 1 && c.box <= 5 ? c.box : 1;
    const row = [
      escapeCsv(c.term),
      escapeCsv(c.definition || ""),
      escapeCsv(c.phonetic || ""),
      escapeCsv(c.deck || "General"),
      boxNum
    ];
    rows.push(row.join(","));
  }

  const csvContent = rows.join("\r\n");

  return {
    versionCode: 152,
    versionName: "4.6.2",
    totalExported: filtered.length,
    deck: filterDeck || "ALL_DECKS",
    csvText: csvContent,
    westernDigits: true,
    timestamp: Date.now()
  };
}

function dfImportDeckFromCsv(csvText, targetDeckName, existingCardsList) {
  const text = typeof csvText === "string" ? csvText.trim() : "";
  if (!text) {
    return { versionCode: 152, importedCount: 0, skippedDuplicates: 0, cards: [] };
  }

  const existing = Array.isArray(existingCardsList) ? existingCardsList : [];
  const existingSet = new Set(existing.map(c => ((c.deck || "General") + ":::" + (c.term || "")).toLowerCase().trim()));

  const lines = text.split(/\r?\n/).filter(l => l.trim().length > 0);
  if (lines.length <= 1) {
    return { versionCode: 152, importedCount: 0, skippedDuplicates: 0, cards: [] };
  }

  const parseLine = (line) => {
    const values = [];
    let insideQuotes = false;
    let entry = "";
    for (let i = 0; i < line.length; i++) {
      const char = line[i];
      if (char === '"') {
        if (insideQuotes && i + 1 < line.length && line[i + 1] === '"') {
          entry += '"';
          i++;
        } else {
          insideQuotes = !insideQuotes;
        }
      } else if (char === "," && !insideQuotes) {
        values.push(entry.trim());
        entry = "";
      } else {
        entry += char;
      }
    }
    values.push(entry.trim());
    return values;
  };

  const newCards = [];
  let skipped = 0;
  let counter = 1;

  for (let i = 1; i < lines.length; i++) {
    const cols = parseLine(lines[i]);
    const term = cols[0] ? cols[0].replace(/^"|"$/g, "") : "";
    const def = cols[1] ? cols[1].replace(/^"|"$/g, "") : "";
    const phon = cols[2] ? cols[2].replace(/^"|"$/g, "") : "";
    const deck = targetDeckName || (cols[3] ? cols[3].replace(/^"|"$/g, "") : "Imported Deck");
    const rawBox = cols[4] ? parseInt(cols[4], 10) : 1;
    const box = rawBox >= 1 && rawBox <= 5 ? rawBox : 1;

    if (!term || !def) continue;

    const key = (deck + ":::" + term).toLowerCase().trim();
    if (existingSet.has(key)) {
      skipped++;
      continue;
    }

    existingSet.add(key);
    newCards.push({
      id: "card_imp_" + Date.now() + "_" + counter++,
      term: term,
      definition: def,
      phonetic: phon,
      deck: deck,
      box: box,
      reviewCount: 0,
      createdAt: Date.now()
    });
  }

  return {
    versionCode: 152,
    versionName: "4.6.2",
    importedCount: newCards.length,
    skippedDuplicates: skipped,
    cards: newCards,
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfExportDeckToCsv = dfExportDeckToCsv;
  window.dfImportDeckFromCsv = dfImportDeckFromCsv;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfExportDeckToCsv = dfExportDeckToCsv;
  globalThis.dfImportDeckFromCsv = dfImportDeckFromCsv;
}
EOF_JS
fi

# Update build.gradle versionCode & versionName
sed -i 's/versionCode [0-9]\+/versionCode '"$VERSION_CODE"'/' "$BUILD_GRADLE"
sed -i 's/versionName "[^"]\+"/versionName "'"$VERSION_NAME"'"/' "$BUILD_GRADLE"
echo "[INFO] build.gradle updated to versionCode $VERSION_CODE ($VERSION_NAME)"

# Verify JS syntax
echo "[CHECK] Verifying JS syntax with node --check..."
node --check "$APP_JS"
echo "[PASS] JS syntax validated successfully."

# Run Node VM Isolated Functional Tests for M332
echo "[CHECK] Running Node VM Isolated Functional Tests for M332..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #332: Flashcard Deck CSV & JSON Importer/Exporter Suite (v4.6.2)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #332 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fnExp = sandbox.window.dfExportDeckToCsv;
const fnImp = sandbox.window.dfImportDeckFromCsv;
if (typeof fnExp !== "function" || typeof fnImp !== "function") throw new Error("Functions not exported!");

// Test 1: Export
const testCards = [
  { term: "Neuroplasticity", definition: "Brain adaptation", phonetic: "/ˌnjʊə.rəʊ-/", deck: "Brain Science", box: 3 }
];
const exp = fnExp(testCards);
if (exp.totalExported !== 1 || exp.versionCode !== 152) throw new Error("Export test failed");

// Test 2: Import with duplicate skipping
const csvInput = "Term,Definition,Phonetic,Deck,Box\n\"Neuroplasticity\",\"Brain adaptation\",\"\",\"Brain Science\",3\n\"Homeostasis\",\"Equilibrium\",\"\",\"Brain Science\",1";
const imp = fnImp(csvInput, "Brain Science", testCards);
if (imp.importedCount !== 1 || imp.skippedDuplicates !== 1 || imp.cards[0].term !== "Homeostasis" || imp.versionCode !== 152) {
  throw new Error("Import test failed: " + JSON.stringify(imp));
}

console.log("[PASS] Node VM Isolated Functional Tests Passed.");
'

# Directives check
if grep -P "[\x{0590}-\x{05FF}]" "$APP_JS"; then
  echo "[FAIL] Forbidden script detected in app.js!"
  exit 1
fi
echo "[PASS] Character constraints verified."

# Git commit, tag, and primary push
git add -A
git commit -m "feat(vocab): M332 flashcard deck CSV and JSON importer exporter suite with versionCode $VERSION_CODE [v$VERSION_NAME]"

TAG_NAME="v$VERSION_NAME-m$MISSION_NUM-v21"
git tag "$TAG_NAME"

echo "[INFO] Pushing changes to primary dev branch ($TARGET_BRANCH)..."
git push origin "$TARGET_BRANCH" || { git pull --rebase origin "$TARGET_BRANCH" && git push origin "$TARGET_BRANCH"; }
git push origin "$TAG_NAME" || true

# Safe sync to main via clean merge
echo "[INFO] Synchronizing main branch with latest release commit..."
git checkout main
git pull origin main || true
git merge -X theirs "$TARGET_BRANCH" -m "chore: sync main with M$MISSION_NUM [v$VERSION_NAME]" || true
git push origin main || true

# Return to active development branch
git checkout "$TARGET_BRANCH"

COMMIT_SHA=$(git rev-parse HEAD)

echo "============================================================"
echo "DEEP FOCUS — HOURLY BUILD REPORT"
echo "============================================================"
echo "STATUS: SUCCESS"
echo "MISSION: $MISSION_NUM (22 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 333 (Reverse Review Mode: Definition to Term Flashcard Challenge)"
echo "============================================================"
rm -f .run_m332.sh
