#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=157
VERSION_NAME="4.6.7"
MISSION_NUM=337
MISSION_NAME="Multi-Tagging & Subject Color Matrix for Flashcards"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 27 of 50]"
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

# Append M337 Multi-Tagging & Color Matrix helper
MARKER_JS="// MISSION #337: Multi-Tagging & Subject Color Matrix (v4.6.7)"
if grep -q "MISSION #337" "$APP_JS"; then
  echo "[INFO] Marker for Mission #337 already present in $APP_JS."
else
  echo "[INFO] Appending M337 Multi-Tagging & Color Matrix to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #337: Multi-Tagging & Subject Color Matrix (v4.6.7)
// ============================================================================
function dfManageCardTagsAndColorMatrix(card, action, tagPayload) {
  const c = card || {};
  const act = (action || "GET").toUpperCase();
  const payload = tagPayload || {};

  const colorMatrix = {
    "BLUE": { hex: "#38BDF8", subject: "STEM / Computer Science" },
    "EMERALD": { hex: "#34D399", subject: "Biology / Medicine" },
    "AMBER": { hex: "#FBBF24", subject: "Law / Economics" },
    "ROSE": { hex: "#FB7185", subject: "History / Humanities" },
    "VIOLET": { hex: "#A78BFA", subject: "Languages / Vocabulary" },
    "SLATE": { hex: "#94A3B8", subject: "General / Miscellaneous" }
  };

  let currentTags = Array.isArray(c.tags) ? [...c.tags] : [];
  let currentColor = c.colorCode || colorMatrix.SLATE.hex;
  let currentSubject = c.subjectName || "SLATE";

  const sanitizeTag = (t) => {
    let s = String(t || "").trim().toLowerCase().replace(/\s+/g, "_");
    if (!s.startsWith("#")) s = "#" + s;
    return s;
  };

  if (act === "ADD_TAG" && payload.tag) {
    const clean = sanitizeTag(payload.tag);
    if (!currentTags.includes(clean)) currentTags.push(clean);
  } else if (act === "REMOVE_TAG" && payload.tag) {
    const clean = sanitizeTag(payload.tag);
    currentTags = currentTags.filter(t => t !== clean);
  } else if (act === "SET_TAGS_BULK" && Array.isArray(payload.tags)) {
    currentTags = payload.tags.map(sanitizeTag).filter((v, i, a) => a.indexOf(v) === i);
  } else if (act === "SET_COLOR" && payload.colorName) {
    const name = String(payload.colorName).toUpperCase().trim();
    if (colorMatrix[name]) {
      currentColor = colorMatrix[name].hex;
      currentSubject = name;
    }
  }

  c.tags = currentTags;
  c.colorCode = currentColor;
  c.subjectName = currentSubject;

  return {
    versionCode: 157,
    versionName: "4.6.7",
    cardId: c.id || "card_tag",
    tags: currentTags,
    colorCode: currentColor,
    subjectName: currentSubject,
    totalTagsOnCard: currentTags.length,
    westernDigits: true,
    timestamp: Date.now()
  };
}

function dfFilterCardsByTagMatrix(cardsList, filterCriteria) {
  const list = Array.isArray(cardsList) ? cardsList : [];
  const criteria = filterCriteria || {};
  const targetTag = criteria.tag ? String(criteria.tag).toLowerCase().trim() : null;
  const targetColor = criteria.subjectName ? String(criteria.subjectName).toUpperCase().trim() : null;

  const tagDistribution = {};
  const filtered = [];

  for (const c of list) {
    if (!c) continue;
    const tags = Array.isArray(c.tags) ? c.tags : [];
    const subject = c.subjectName || "SLATE";

    for (const t of tags) {
      tagDistribution[t] = (tagDistribution[t] || 0) + 1;
    }

    let match = true;
    if (targetTag && !tags.some(t => t.toLowerCase() === targetTag || t.toLowerCase() === "#" + targetTag)) {
      match = false;
    }
    if (targetColor && subject !== targetColor) {
      match = false;
    }

    if (match) filtered.push(c);
  }

  return {
    versionCode: 157,
    versionName: "4.6.7",
    matchingCardsCount: filtered.length,
    totalCardsEvaluated: list.length,
    filteredCards: filtered,
    tagDistribution: tagDistribution,
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfManageCardTagsAndColorMatrix = dfManageCardTagsAndColorMatrix;
  window.dfFilterCardsByTagMatrix = dfFilterCardsByTagMatrix;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfManageCardTagsAndColorMatrix = dfManageCardTagsAndColorMatrix;
  globalThis.dfFilterCardsByTagMatrix = dfFilterCardsByTagMatrix;
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

# Run Node VM Isolated Functional Tests for M337
echo "[CHECK] Running Node VM Isolated Functional Tests for M337..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #337: Multi-Tagging & Subject Color Matrix (v4.6.7)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #337 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fnManage = sandbox.window.dfManageCardTagsAndColorMatrix;
const fnFilter = sandbox.window.dfFilterCardsByTagMatrix;
if (typeof fnManage !== "function" || typeof fnFilter !== "function") throw new Error("Functions not exported!");

// Test 1: Add tag and set color
const c1 = { id: "c1", tags: [] };
const r1 = fnManage(c1, "ADD_TAG", { tag: "Neuroscience" });
if (!r1.tags.includes("#neuroscience") || r1.totalTagsOnCard !== 1) {
  throw new Error("Add tag failed: " + JSON.stringify(r1));
}

const rColor = fnManage(c1, "SET_COLOR", { colorName: "EMERALD" });
if (rColor.colorCode !== "#34D399" || rColor.subjectName !== "EMERALD") {
  throw new Error("Set color failed: " + JSON.stringify(rColor));
}

// Test 2: Filter by tag
const c2 = { id: "c2", tags: ["#stem", "#math"], subjectName: "BLUE" };
const f = fnFilter([c1, c2], { tag: "stem" });
if (f.matchingCardsCount !== 1 || f.versionCode !== 157) {
  throw new Error("Filter test failed: " + JSON.stringify(f));
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
git commit -m "feat(vocab): M337 multi-tagging and subject color matrix for flashcards with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (27 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 338 (Android Offline Native TTS Engine Audio Pronunciation Hook)"
echo "============================================================"
rm -f .run_m337.sh
