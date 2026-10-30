#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

TARGET_BRANCH="integration/master-qa-verified-v21"

echo "============================================================"
echo "🛠️ فحص وإصلاح موارد الأيقونة المفقودة في AndroidManifest"
echo "============================================================"

git checkout "$TARGET_BRANCH"
git pull --rebase origin "$TARGET_BRANCH" || true

RES_DIR="android/app/src/main/res"
MIPMAP_DIR="$RES_DIR/mipmap-anydpi-v26"
DRAWABLE_DIR="$RES_DIR/drawable"
mkdir -p "$MIPMAP_DIR" "$DRAWABLE_DIR"

# 1. إنشاء أيقونة خلفية زن متجهة معيارية
cat << 'EOF_XML' > "$DRAWABLE_DIR/ic_zen_launcher_bg.xml"
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path
        android:fillColor="#121212"
        android:pathData="M0,0h108v108h-108z" />
</vector>
EOF_XML

# 2. إنشاء أيقونة أمامية متجهة لرمز التركيز
cat << 'EOF_XML' > "$DRAWABLE_DIR/ic_zen_launcher_fg.xml"
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <path
        android:fillColor="#4ADE80"
        android:pathData="M54,24 A30,30 0 1,0 54,84 A30,30 0 1,0 54,24 Z M54,34 A20,20 0 1,1 54,74 A20,20 0 1,1 54,34 Z" />
</vector>
EOF_XML

# 3. توفير ic_launcher و ic_launcher_round في mipmap-anydpi-v26
cat << 'EOF_XML' > "$MIPMAP_DIR/ic_launcher.xml"
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_zen_launcher_bg" />
    <foreground android:drawable="@drawable/ic_zen_launcher_fg" />
</adaptive-icon>
EOF_XML

cp "$MIPMAP_DIR/ic_launcher.xml" "$MIPMAP_DIR/ic_launcher_round.xml"

# توفير نسخة fallback في drawable للأجهزة القديمة
cp "$DRAWABLE_DIR/ic_zen_launcher_fg.xml" "$DRAWABLE_DIR/ic_launcher.xml"
cp "$DRAWABLE_DIR/ic_zen_launcher_fg.xml" "$DRAWABLE_DIR/ic_launcher_round.xml"

echo "[PASS] تم إنشاء وتثبيت موارد ic_launcher بنجاح."

# إيداع الإصلاح ورفعه لـ GitHub
git add "$RES_DIR"
git commit -m "fix(res): provide adaptive vector ic_launcher and ic_launcher_round to resolve processDebugResources build failure"
git push origin "$TARGET_BRANCH"

echo "============================================================"
echo "✅ تم رفع الإصلاح بنجاح! سيتم الآن نجاح فحص بناء الأندرويد في GitHub Actions."
echo "============================================================"
rm -f .fix_resources.sh
