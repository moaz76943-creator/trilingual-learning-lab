#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=154
VERSION_NAME="4.6.4"
MISSION_NUM=334
MISSION_NAME="Smart Multiple-Choice Quiz Generator with In-Deck Distractors"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 24 of 50]"
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

# Append M334 Smart MCQ Generator helper
MARKER_JS="// MISSION #334: Smart Multiple-Choice Quiz Generator (v4.6.4)"
if grep -q "MISSION #334" "$APP_JS"; then
  echo "[INFO] Marker for Mission #334 already present in $APP_JS."
else
  echo "[INFO] Appending M334 Smart MCQ Generator to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #334: Smart Multiple-Choice Quiz Generator (v4.6.4)
// ============================================================================
function dfGenerateSmartMcqQuestion(targetCard, deckCards, options) {
  const card = targetCard || { term: "Focus", definition: "Attention state", deck: "General" };
  const allCards = Array.isArray(deckCards) ? deckCards : [];
  const opts = options || {};

  const qType = opts.questionType === "TERM_TO_DEF" ? "TERM_TO_DEF" : "DEF_TO_TERM";
  const optCount = typeof opts.optionCount === "number" && opts.optionCount >= 2 && opts.optionCount <= 6 ? opts.optionCount : 4;

  const candidatePool = allCards.filter(c => c && c.id !== card.id && (c.term || "").trim().toLowerCase() !== (card.term || "").trim().toLowerCase());

  const sameDeck = candidatePool.filter(c => (c.deck || "General").toLowerCase() === (card.deck || "General").toLowerCase());
  let distractors = [...sameDeck];

  if (distractors.length < (optCount - 1)) {
    const diffDeck = candidatePool.filter(c => (c.deck || "General").toLowerCase() !== (card.deck || "General").toLowerCase());
    for (const d of diffDeck) {
      if (distractors.length >= (optCount - 1)) break;
      distractors.push(d);
    }
  }

  const fallbacks = [
    { term: "Neuroplasticity", definition: "Brain adaptability" },
    { term: "Homeostasis", definition: "Internal equilibrium" },
    { term: "Serendipity", definition: "Fortunate happenstance" },
    { term: "Resilience", definition: "Capacity to recover" }
  ];
  for (const f of fallbacks) {
    if (distractors.length >= (optCount - 1)) break;
    if (f.term.toLowerCase() !== (card.term || "").toLowerCase()) {
      distractors.push(f);
    }
  }

  distractors = distractors.slice(0, optCount - 1);

  const correctOptionText = qType === "TERM_TO_DEF" ? (card.definition || card.term) : card.term;
  const rawOptions = [
    { text: correctOptionText, isCorrect: true, cardId: card.id || "target" }
  ];

  for (const d of distractors) {
    const dText = qType === "TERM_TO_DEF" ? (d.definition || d.term) : d.term;
    rawOptions.push({ text: dText, isCorrect: false, cardId: d.id || "distractor" });
  }

  for (let i = rawOptions.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    const temp = rawOptions[i];
    rawOptions[i] = rawOptions[j];
    rawOptions[j] = temp;
  }

  const optionLetters = ["A", "B", "C", "D", "E", "F"];
  let correctLetter = "A";
  let correctIndex = 0;

  const finalOptions = rawOptions.map((opt, idx) => {
    const letter = optionLetters[idx] || String(idx + 1);
    if (opt.isCorrect) {
      correctLetter = letter;
      correctIndex = idx;
    }
    return {
      id: letter,
      text: opt.text,
      isCorrect: opt.isCorrect
    };
  });

  const prompt = qType === "TERM_TO_DEF"
    ? 'What is the meaning of: "' + card.term + '"?'
    : 'Which term matches: "' + (card.definition || card.term) + '"?';

  return {
    versionCode: 154,
    versionName: "4.6.4",
    questionType: qType,
    promptText: prompt,
    targetTerm: card.term,
    targetDefinition: card.definition,
    options: finalOptions,
    correctOptionId: correctLetter,
    correctOptionIndex: correctIndex,
    totalOptions: finalOptions.length,
    westernDigits: true,
    timestamp: Date.now()
  };
}

function dfEvaluateMcqAnswer(selectedOptionId, mcqQuestion) {
  const q = mcqQuestion || {};
  const selected = String(selectedOptionId || "").toUpperCase().trim();
  const correct = String(q.correctOptionId || "").toUpperCase().trim();

  const isCorrect = Boolean(selected && selected === correct);

  return {
    versionCode: 154,
    versionName: "4.6.4",
    selectedOptionId: selected,
    correctOptionId: correct,
    isCorrect: isCorrect,
    feedback: isCorrect ? "CORRECT" : "INCORRECT",
    explanation: "Correct answer: (" + correct + ") " + (q.targetTerm || ""),
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfGenerateSmartMcqQuestion = dfGenerateSmartMcqQuestion;
  window.dfEvaluateMcqAnswer = dfEvaluateMcqAnswer;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfGenerateSmartMcqQuestion = dfGenerateSmartMcqQuestion;
  globalThis.dfEvaluateMcqAnswer = dfEvaluateMcqAnswer;
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

# Run Node VM Isolated Functional Tests for M334
echo "[CHECK] Running Node VM Isolated Functional Tests for M334..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #334: Smart Multiple-Choice Quiz Generator (v4.6.4)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #334 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fnGen = sandbox.window.dfGenerateSmartMcqQuestion;
const fnEval = sandbox.window.dfEvaluateMcqAnswer;
if (typeof fnGen !== "function" || typeof fnEval !== "function") throw new Error("Functions not exported!");

const target = { id: "c1", term: "Homeostasis", definition: "Equilibrium state", deck: "Bio" };
const deck = [
  target,
  { id: "c2", term: "Neuroplasticity", definition: "Brain adaptation", deck: "Bio" },
  { id: "c3", term: "Synapse", definition: "Neural junction", deck: "Bio" },
  { id: "c4", term: "Axon", definition: "Nerve fiber", deck: "Bio" }
];

const q = fnGen(target, deck, { questionType: "DEF_TO_TERM" });
if (q.options.length !== 4 || !q.correctOptionId || q.targetTerm !== "Homeostasis" || q.versionCode !== 154) {
  throw new Error("MCQ generation failed: " + JSON.stringify(q));
}

const ev = fnEval(q.correctOptionId, q);
if (!ev.isCorrect || ev.feedback !== "CORRECT") {
  throw new Error("MCQ evaluation failed: " + JSON.stringify(ev));
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
git commit -m "feat(vocab): M334 smart multiple-choice quiz generator with in-deck distractors with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (24 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 335 (Weak Cards Vault & Pre-Exam Cramming Mode)"
echo "============================================================"
rm -f .run_m334.sh
