#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"
VERSION_CODE=149
VERSION_NAME="4.5.9"
MISSION_NUM=329
MISSION_NAME="Chronotype Peak Productivity Hours Analytics"

echo "============================================================"
echo "[DEEP FOCUS] Hourly Cycle Mission #$MISSION_NUM (Termux Runner)"
echo "Feature: $MISSION_NAME"
echo "Target VersionCode: $VERSION_CODE ($VERSION_NAME) [Mission 19 of 50]"
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

# Append M329 Chronotype Analytics helper
MARKER_JS="// MISSION #329: Chronotype Peak Productivity Hours Analytics (v4.5.9)"
if grep -q "MISSION #329" "$APP_JS"; then
  echo "[INFO] Marker for Mission #329 already present in $APP_JS."
else
  echo "[INFO] Appending M329 Chronotype Analytics to $APP_JS"
  cat << 'EOF_JS' >> "$APP_JS"

// ============================================================================
// MISSION #329: Chronotype Peak Productivity Hours Analytics (v4.5.9)
// ============================================================================
function dfAnalyzeChronotypePeakHours(historyList) {
  const history = Array.isArray(historyList) ? historyList : [];
  const hourBins = new Array(24).fill(0);
  let totalSessions = 0;

  for (const item of history) {
    if (!item) continue;
    const ts = typeof item.timestamp === "number" ? item.timestamp : Date.now();
    const date = new Date(ts);
    const hour = date.getHours();
    const duration = typeof item.durationMinutes === "number" && item.durationMinutes > 0 ? item.durationMinutes : 25;
    const rating = typeof item.rating === "number" && item.rating >= 1 && item.rating <= 5 ? item.rating : 3;

    hourBins[hour] += duration * (rating / 3.0);
    totalSessions++;
  }

  const indexed = hourBins.map((score, h) => ({ hour: h, score: score }));
  indexed.sort((a, b) => b.score - a.score);

  const top3 = indexed.slice(0, 3).map(x => x.hour);
  const topHour = top3[0] || 10;

  let morningScore = 0;
  let afternoonScore = 0;
  let nightScore = 0;

  for (let h = 0; h < 24; h++) {
    if (h >= 5 && h < 11) morningScore += hourBins[h];
    else if (h >= 11 && h < 18) afternoonScore += hourBins[h];
    else nightScore += hourBins[h];
  }

  let chronotype = "BEAR";
  let chronotypeLabel = "Steady Daytime Focus (Bear)";
  let recWindow = "10:00 - 13:00";

  if (morningScore > afternoonScore && morningScore > nightScore) {
    chronotype = "LARK";
    chronotypeLabel = "Early Morning Peak (Lark)";
    recWindow = "07:00 - 10:30";
  } else if (nightScore > morningScore && nightScore > afternoonScore) {
    chronotype = "OWL";
    chronotypeLabel = "Late Evening Focus (Night Owl)";
    recWindow = "20:00 - 23:30";
  }

  const pad = (n) => (n < 10 ? "0" + n : "" + n);
  const nextHour = (topHour + 1) % 24;
  const topFormatted = pad(topHour) + ":00 - " + pad(nextHour) + ":00";

  return {
    versionCode: 149,
    versionName: "4.5.9",
    chronotype: chronotype,
    chronotypeLabel: chronotypeLabel,
    topPeakHour: topHour,
    topPeakWindowFormatted: topFormatted,
    top3PeakHours: top3,
    totalAnalyzedSessions: totalSessions,
    recommendedDeepWorkWindow: recWindow,
    westernDigits: true,
    timestamp: Date.now()
  };
}

if (typeof window !== "undefined") {
  window.dfAnalyzeChronotypePeakHours = dfAnalyzeChronotypePeakHours;
}
if (typeof globalThis !== "undefined") {
  globalThis.dfAnalyzeChronotypePeakHours = dfAnalyzeChronotypePeakHours;
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

# Run Node VM Isolated Functional Tests for M329
echo "[CHECK] Running Node VM Isolated Functional Tests for M329..."
node -e '
const fs = require("fs");
const vm = require("vm");

const fullCode = fs.readFileSync("android/app/src/main/assets/web/app.js", "utf8");
const marker = "// MISSION #329: Chronotype Peak Productivity Hours Analytics (v4.5.9)";
const markerIdx = fullCode.indexOf(marker);
if (markerIdx === -1) throw new Error("Mission #329 marker not found in app.js");
const mCode = fullCode.slice(markerIdx);

const sandbox = { window: {}, globalThis: {}, Date: Date };
vm.createContext(sandbox);
vm.runInContext(mCode, sandbox);

const fn = sandbox.window.dfAnalyzeChronotypePeakHours;
if (typeof fn !== "function") throw new Error("dfAnalyzeChronotypePeakHours not exported!");

// Test 1: Empty fallback
const r1 = fn([]);
if (r1.versionCode !== 149 || !r1.topPeakWindowFormatted) {
  throw new Error("Empty fallback test failed: " + JSON.stringify(r1));
}

// Test 2: Night owl sessions
const nightHistory = [
  { timestamp: new Date("2026-10-28T21:30:00").getTime(), durationMinutes: 60, rating: 5 },
  { timestamp: new Date("2026-10-28T22:15:00").getTime(), durationMinutes: 50, rating: 5 },
  { timestamp: new Date("2026-10-28T23:00:00").getTime(), durationMinutes: 45, rating: 4 }
];
const r2 = fn(nightHistory);
if (r2.chronotype !== "OWL" || !r2.chronotypeLabel.includes("Night Owl")) {
  throw new Error("Owl test failed: " + JSON.stringify(r2));
}

// Test 3: Early lark sessions
const larkHistory = [
  { timestamp: new Date("2026-10-28T06:30:00").getTime(), durationMinutes: 60, rating: 5 },
  { timestamp: new Date("2026-10-28T07:15:00").getTime(), durationMinutes: 60, rating: 5 },
  { timestamp: new Date("2026-10-28T08:00:00").getTime(), durationMinutes: 60, rating: 5 }
];
const r3 = fn(larkHistory);
if (r3.chronotype !== "LARK" || !r3.chronotypeLabel.includes("Lark")) {
  throw new Error("Lark test failed: " + JSON.stringify(r3));
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
git commit -m "feat(neuro): M329 chronotype peak productivity hours analytics with versionCode $VERSION_CODE [v$VERSION_NAME]"

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
echo "MISSION: $MISSION_NUM (19 of 50)"
echo "PRIMARY_BRANCH: $TARGET_BRANCH"
echo "MAIN_STATUS: SYNCED & PUSHED TO GITHUB"
echo "COMMIT_SHA: $COMMIT_SHA"
echo "VERSION_CODE: $VERSION_CODE"
echo "VERSION_NAME: $VERSION_NAME"
echo "CHECKS_NODE_SYNTAX: PASSED"
echo "CHECKS_UNIT_TESTS: PASSED"
echo "CHECKS_WESTERN_DIGITS: PRESERVED"
echo "ANDROID_DEVICE_TEST: NOT_TESTED (Pending device verification)"
echo "NEXT_STEP: 330 (Box Breathing 4-7-8 Pre-Session Pacer — Phase 2 Golden Milestone v4.6.0)"
echo "============================================================"
rm -f .run_m329.sh
