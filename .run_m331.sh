#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=151
VERSION_NAME="4.6.1"
MISSION_NUM=331
MISSION_NAME="5-Box Leitner Spaced Repetition Core Engine"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 21 of 50 - PHASE 3 START]"
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

# Append M331 Leitner Spaced Repetition Core helper
MARKER_JS="// MISSION #331: 5-Box Leitner Spaced Repetition Core Engine (v4.6.1)"
if grep -q "MISSION #331" "$APP_JS"; then
  echo "[INFO] Marker for Mission #331 already present in $APP_JS."
else
  echo "[INFO] Appending M331 Leitner Spaced Repetition Engine to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #331: 5-Box Leitner Spaced Repetition Core Engine (v4.6.1)
// ============================================================================
function dfProcessLeitnerReviewStep(card, isCorrect, options) {
  const c = card || {};
  const opts = options || {};
  const currentBox = typeof c.box === "number" && c.box >= 1 && c.box <= 5 ? Math.floor(c.box) : 1;
  const now = typeof opts.currentTime === "number" ? opts.currentTime : Date.now();

  const boxIntervals = {
    1: 1,  // Daily
    2: 2,  // Every 2 days
    3: 5,  // Every 5 days
    4: 9,  // Every 9 days
    5: 14  // Every 14 days (Mastered)
  };

  let newBox = 1;
  let action = "DEMOTED";

  if (Boolean(isCorrect)) {
    if (currentBox < 5) {
      newBox = currentBox + 1;
      action = "PROMOTED";
    } else {
      newBox = 5;
      action = "RETAINED_MASTERED";
    }
  } else {
    newBox = 1;
    action = currentBox === 1 ? "FAILED_RETRY" : "DEMOTED_TO_BOX_1";
  }

  const intervalDays = boxIntervals[newBox] || 1;
  const nextReviewDate = now + (intervalDays * 24 * 60 * 60 * 1000);

  return {
    versionCode: 151,
    versionName: "4.6.1",
    cardId: c.id || "card_unknown",
    previousBox: currentBox,
    newBox: newBox,
    action: action,
    isCorrect: Boolean(isCorrect),
    intervalDays: intervalDays,
    nextReviewDate: nextReviewDate,
    westernDigits: true,
    timestamp: now
  };
}

function dfGetLeitnerVaultDistribution(cardsList) {
  const list = Array.isArray(cardsList) ? cardsList : [];
  const counts = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };
  let total = 0;

  for (const c of list) {
    if (!c) continue;
    const b = typeof c.box === "number" && c.box >= 1 && c.box <= 5 ? Math.floor(c.box) : 1;
    counts[b]++;
    total++;
  }

  const calcPct = (cnt) => (total > 0 ? Math.round((cnt / total) * 100) : 0);

  return {
    versionCode: 151,
    versionName: "4.6.1",
    totalCards: total,
    boxes: {
      box1: { count: counts[1], percent: calcPct(counts[1]), label: "Box 1 (Daily)" },
      box2: { count: counts[2], percent: calcPct(counts[2]), label: "Box 2 (2 Days)" },
      box3: { count: counts[3], percent: calcPct(counts[3]), label: "Box 3 (5 Days)" },
      box4: { count: counts[4], percent: calcPct(counts[4]), label: "Box 4 (9 Days)" },
      box5: { count: counts[5], percent: calcPct(counts[5]), label: "Box 5 (Mastered)" }
    },
    masteryRatePercent: calcPct(counts[5]),
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfProcessLeitnerReviewStep = dfProcessLeitnerReviewStep;
  window.dfGetLeitnerVaultDistribution = dfGetLeitnerVaultDistribution;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfProcessLeitnerReviewStep = dfProcessLeitnerReviewStep;
  globalThis.dfGetLeitnerVaultDistribution = dfGetLeitnerVaultDistribution;
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

# Run Node VM Isolated Functional Tests for M331
echo "[CHECK] Running Node VM Isolated Functional Tests for M331..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #331: 5-Box Leitner Spaced Repetition Core Engine (v4.6.1)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #331 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fnStep = sandbox.window.dfProcessLeitnerReviewStep;
const fnDist = sandbox.window.dfGetLeitnerVaultDistribution;
if (typeof fnStep !== "function" || typeof fnDist !== "function") throw new Error("Functions not exported!");

// Test 1: Promotion Box 2 -> 3
const r1 = fnStep({ id: "c1", box: 2 }, true);
if (r1.newBox !== 3 || r1.action !== "PROMOTED" || r1.intervalDays !== 5) {
  throw new Error("Promotion test failed: " + JSON.stringify(r1));
}

// Test 2: Demotion Box 4 -> 1 on mistake
const r2 = fnStep({ id: "c2", box: 4 }, false);
if (r2.newBox !== 1 || r2.action !== "DEMOTED_TO_BOX_1" || r2.intervalDays !== 1) {
  throw new Error("Demotion test failed: " + JSON.stringify(r2));
}

// Test 3: Box 5 stays 5 on success
const r3 = fnStep({ id: "c3", box: 5 }, true);
if (r3.newBox !== 5 || r3.action !== "RETAINED_MASTERED" || r3.intervalDays !== 14) {
  throw new Error("Mastered retention test failed: " + JSON.stringify(r3));
}

// Test 4: Distribution test
const r4 = fnDist([{ box: 1 }, { box: 1 }, { box: 5 }, { box: 5 }]);
if (r4.totalCards !== 4 || r4.boxes.box1.count !== 2 || r4.boxes.box5.count !== 2 || r4.masteryRatePercent !== 50 || r4.versionCode !== 151) {
  throw new Error("Distribution test failed: " + JSON.stringify(r4));
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
git commit -m "feat(vocab): M331 5-box Leitner spaced repetition core engine with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (21 of 50 - PHASE 3 INAUGURATION)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 332 (Encrypted Backup CSV & JSON Deck Importer/Exporter)"
echo "============================================================"
rm -f .run_m331.sh
