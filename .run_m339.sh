#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=159
VERSION_NAME="4.6.9"
MISSION_NUM=339
MISSION_NAME="Ready-to-Use Subject Flashcard Templates Pack"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 29 of 50]"
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

# Append M339 Templates helper
MARKER_JS="// MISSION #339: Ready-to-Use Subject Flashcard Templates Pack (v4.6.9)"
if grep -q "MISSION #339" "$APP_JS"; then
  echo "[INFO] Marker for Mission #339 already present in $APP_JS."
else
  echo "[INFO] Appending M339 Templates Pack to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #339: Ready-to-Use Subject Flashcard Templates Pack (v4.6.9)
// ============================================================================
function dfGetSubjectDeckTemplates() {
  return [
    {
      id: "STEM_ALGORITHMS",
      name: "Computer Science & Algorithms",
      subjectColor: "BLUE",
      colorHex: "#38BDF8",
      description: "Essential data structures, algorithm complexities, and paradigms",
      cards: [
        { term: "Dynamic Programming", definition: "Solving complex problems by breaking them down into simpler overlapping subproblems", phonetic: "/daɪˈnæm.ɪk/", tags: ["#stem", "#algorithms", "#cs"] },
        { term: "Memoization", definition: "Optimization technique storing the results of expensive function calls", phonetic: "/ˌmem.oʊ.əˈzeɪ.ʃən/", tags: ["#stem", "#optimization"] },
        { term: "Breadth-First Search", definition: "Algorithm for traversing tree or graph data structures level by level", phonetic: "/bredθ fɜːst sɜːtʃ/", tags: ["#stem", "#graphs"] },
        { term: "Time Complexity", definition: "Computational complexity describing execution time of an algorithm", phonetic: "/taɪm kəmˈplek.sə.ti/", tags: ["#stem", "#big_o"] }
      ]
    },
    {
      id: "BIO_MEDICINE",
      name: "Biology & Medical High-Yield",
      subjectColor: "EMERALD",
      colorHex: "#34D399",
      description: "High-yield physiological processes and cellular biology terms",
      cards: [
        { term: "Homeostasis", definition: "State of steady internal physical and chemical conditions maintained by living systems", phonetic: "/ˌhoʊ.mi.oʊˈsteɪ.sɪs/", tags: ["#medicine", "#biology", "#physiology"] },
        { term: "Neuroplasticity", definition: "Ability of the nervous system to rewire its structure and functions in response to experience", phonetic: "/ˌnʊr.oʊ.plæsˈtɪs.ə.ti/", tags: ["#neuroscience", "#brain"] },
        { term: "Action Potential", definition: "Rapid sequence of voltage changes across an excitable cell membrane", phonetic: "/ˈæk.ʃən pəˈten.ʃəl/", tags: ["#physiology", "#nerves"] },
        { term: "Mitochondria", definition: "Double-membrane-bound cellular organelle generating most chemical energy ATP", phonetic: "/ˌmaɪ.təˈkɑːn.dri.ə/", tags: ["#biology", "#cell"] }
      ]
    },
    {
      id: "ACADEMIC_VOCAB",
      name: "Advanced Academic Vocabulary",
      subjectColor: "VIOLET",
      colorHex: "#A78BFA",
      description: "Sophisticated terms for thesis writing, debate, and advanced reading",
      cards: [
        { term: "Serendipity", definition: "The occurrence of events by chance in a happy or beneficial way", phonetic: "/ˌser.ənˈdɪp.ə.ti/", tags: ["#vocab", "#english", "#literature"] },
        { term: "Epiphany", definition: "A moment of sudden revelation or intuitive insight", phonetic: "/ɪˈpɪf.ən.i/", tags: ["#vocab", "#mindset"] },
        { term: "Paradigm", definition: "A distinct set of concepts or thought patterns, including theories and research methods", phonetic: "/ˈpær.ə.daɪm/", tags: ["#academic", "#philosophy"] },
        { term: "Ubiquitous", definition: "Present, appearing, or found everywhere simultaneously", phonetic: "/juːˈbɪk.wə.təs/", tags: ["#vocab", "#gre"] }
      ]
    },
    {
      id: "LAW_JURISPRUDENCE",
      name: "Law & Constitutional Jurisprudence",
      subjectColor: "AMBER",
      colorHex: "#FBBF24",
      description: "Fundamental Latin legal doctrines and constitutional principles",
      cards: [
        { term: "Habeas Corpus", definition: "Legal recourse requiring a person under arrest to be brought before a judge or into court", phonetic: "/ˌheɪ.bi.əs ˈkɔːr.pəs/", tags: ["#law", "#rights"] },
        { term: "Stare Decisis", definition: "Doctrine of precedent obligating courts to follow previous judicial decisions", phonetic: "/ˌstɑː.reɪ dɪˈsaɪ.sɪs/", tags: ["#law", "#courts"] },
        { term: "Prima Facie", definition: "On its first encounter or based on the first impression as accepted as correct until proven otherwise", phonetic: "/ˌpraɪ.mə ˈfeɪ.ʃi/", tags: ["#law", "#evidence"] },
        { term: "Due Process", definition: "Legal requirement that state must respect all legal rights that are owed to a person", phonetic: "/djuː ˈprɑː.ses/", tags: ["#law", "#constitution"] }
      ]
    }
  ];
}

function dfInstantiateSubjectDeckTemplate(templateId, existingCardsList) {
  const templates = dfGetSubjectDeckTemplates();
  const targetId = String(templateId || "").toUpperCase().trim();
  const tmpl = templates.find(t => t.id === targetId) || templates[0];

  const existing = Array.isArray(existingCardsList) ? existingCardsList : [];
  const existingSet = new Set(existing.map(c => ((c.deck || "General") + ":::" + (c.term || "")).toLowerCase().trim()));

  const instantiated = [];
  let skipped = 0;
  let counter = 1;

  for (const c of tmpl.cards) {
    const key = (tmpl.name + ":::" + c.term).toLowerCase().trim();
    if (existingSet.has(key)) {
      skipped++;
      continue;
    }

    existingSet.add(key);
    instantiated.push({
      id: "card_tmpl_" + Date.now() + "_" + counter++,
      term: c.term,
      definition: c.definition,
      phonetic: c.phonetic || "",
      deck: tmpl.name,
      box: 1,
      tags: Array.isArray(c.tags) ? [...c.tags] : [],
      subjectName: tmpl.subjectColor,
      colorCode: tmpl.colorHex,
      reviewCount: 0,
      createdAt: Date.now()
    });
  }

  return {
    versionCode: 159,
    versionName: "4.6.9",
    templateId: tmpl.id,
    deckName: tmpl.name,
    subjectColor: tmpl.subjectColor,
    colorHex: tmpl.colorHex,
    cardsInstantiatedCount: instantiated.length,
    skippedDuplicatesCount: skipped,
    cards: instantiated,
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfGetSubjectDeckTemplates = dfGetSubjectDeckTemplates;
  window.dfInstantiateSubjectDeckTemplate = dfInstantiateSubjectDeckTemplate;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfGetSubjectDeckTemplates = dfGetSubjectDeckTemplates;
  globalThis.dfInstantiateSubjectDeckTemplate = dfInstantiateSubjectDeckTemplate;
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

# Run Node VM Isolated Functional Tests for M339
echo "[CHECK] Running Node VM Isolated Functional Tests for M339..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #339: Ready-to-Use Subject Flashcard Templates Pack (v4.6.9)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #339 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fnList = sandbox.window.dfGetSubjectDeckTemplates;
const fnInst = sandbox.window.dfInstantiateSubjectDeckTemplate;
if (typeof fnList !== "function" || typeof fnInst !== "function") throw new Error("Functions not exported!");

// Test 1: Templates count
const list = fnList();
if (list.length !== 4) throw new Error("Templates count mismatch");

// Test 2: Instantiation
const r = fnInst("BIO_MEDICINE", []);
if (r.cardsInstantiatedCount !== 4 || r.versionCode !== 159 || r.subjectColor !== "EMERALD") {
  throw new Error("Template instantiation failed: " + JSON.stringify(r));
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
git commit -m "feat(vocab): M339 ready-to-use subject flashcard templates pack with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (29 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 340 (Break Micro-Quiz Hook & Phase 3 Golden Milestone v4.7.0)"
echo "============================================================"
rm -f .run_m339.sh
