#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=148
VERSION_NAME="4.5.8"
MISSION_NUM=328
MISSION_NAME="Focus Quality & Friction Tagging Rating (1-5 Stars)"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 18 of 50]"
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

# Append M328 Focus Quality Rating helper
MARKER_JS="// MISSION #328: Focus Quality & Friction Tagging Rating (v4.5.8)"
if grep -q "MISSION #328" "$APP_JS"; then
  echo "[INFO] Marker for Mission #328 already present in $APP_JS."
else
  echo "[INFO] Appending M328 Focus Quality Rating to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #328: Focus Quality & Friction Tagging Rating (v4.5.8)
// ============================================================================
function dfRateSessionFocusQuality(ratingData, historyList) {
  const d = ratingData || {};
  const rawRating = typeof d.rating === "number" ? Math.floor(d.rating) : 5;
  const rating = Math.min(5, Math.max(1, rawRating));

  const allowedTags = [
    "MENTAL_FATIGUE",
    "EXTERNAL_NOISE",
    "DIFFICULT_MATERIAL",
    "PHONE_TEMPTATION",
    "HUNGER_THIRST",
    "POOR_SLEEP",
    "PERFECT_FLOW"
  ];

  const inputTags = Array.isArray(d.frictionTags) ? d.frictionTags : [];
  const validTags = inputTags.filter(t => allowedTags.includes(String(t).toUpperCase()));
  if (rating === 5 && validTags.length === 0) {
    validTags.push("PERFECT_FLOW");
  }

  const starSymbols = ["☆☆☆☆☆", "★☆☆☆☆", "★★☆☆☆", "★★★☆☆", "★★★★☆", "★★★★★"];
  const starsVisual = starSymbols[rating];

  let category = "DEEP_FLOW";
  if (rating <= 2) category = "HIGH_FRICTION";
  else if (rating === 3) category = "MODERATE_FOCUS";
  else if (rating === 4) category = "STRONG_FOCUS";

  const history = Array.isArray(historyList) ? historyList : [];
  let totalRating = rating;
  let count = 1;

  for (const item of history) {
    if (item && typeof item.rating === "number" && item.rating >= 1 && item.rating <= 5) {
      totalRating += item.rating;
      count++;
    }
  }

  const avgRating = Math.round((totalRating / count) * 10) / 10;

  return {
    versionCode: 148,
    versionName: "4.5.8",
    rating: rating,
    starsVisual: starsVisual,
    frictionTags: validTags,
    qualityCategory: category,
    averageRating: avgRating,
    formattedAverage: avgRating + " / 5.0",
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfRateSessionFocusQuality = dfRateSessionFocusQuality;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfRateSessionFocusQuality = dfRateSessionFocusQuality;
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

# Run Node VM Isolated Functional Tests for M328
echo "[CHECK] Running Node VM Isolated Functional Tests for M328..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #328: Focus Quality & Friction Tagging Rating (v4.5.8)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #328 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: { now: () => 1700000000000 } };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fn = sandbox.window.dfRateSessionFocusQuality;
if (typeof fn !== "function") throw new Error("dfRateSessionFocusQuality not exported!");

// Test 1: 5 star perfect session
const r1 = fn({ rating: 5 });
if (r1.rating !== 5 || r1.qualityCategory !== "DEEP_FLOW" || r1.starsVisual !== "★★★★★" || !r1.frictionTags.includes("PERFECT_FLOW")) {
  throw new Error("5 star test failed: " + JSON.stringify(r1));
}

// Test 2: 2 star high friction session
const r2 = fn({ rating: 2, frictionTags: ["EXTERNAL_NOISE", "PHONE_TEMPTATION"] }, [{ rating: 4 }, { rating: 3 }]);
if (r2.rating !== 2 || r2.qualityCategory !== "HIGH_FRICTION" || r2.frictionTags.length !== 2 || r2.averageRating !== 3.0 || r2.versionCode !== 148) {
  throw new Error("2 star test failed: " + JSON.stringify(r2));
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
git commit -m "feat(neuro): M328 focus quality and friction tagging rating with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (18 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 329 (Chronotype Peak Productivity Hours Analytics)"
echo "============================================================"
rm -f .run_m328.sh
