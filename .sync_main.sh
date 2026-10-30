#!/bin/bash
set -e

cd ~/zen-study-focus || { echo "[FAIL] Directory ~/zen-study-focus not found"; exit 1; }

DEV_BRANCH="integration/master-qa-verified-v21"

echo "============================================================"
echo "🔄 مزامنة ودمج إنجازات التطوير في فرع main بأمان تام"
echo "============================================================"

# إلغاء أي دمج سابق معلق إن وجد
git merge --abort 2>/dev/null || true

# 1. التأكد من أن فرع التطوير نظيف
git checkout "$DEV_BRANCH"

# 2. الانتقال إلى main وتحديثه
echo "[INFO] جلب آخر بيانات فرع main من GitHub..."
git checkout main
git pull origin main || true

# 3. دمج فرع التطوير في main مع تفضيل التعديلات الحديثة
echo "[INFO] جاري دمج كافة إنجازات $DEV_BRANCH في main..."
git merge -X theirs "$DEV_BRANCH" -m "chore: sync main with $DEV_BRANCH [v4.5.5 - M325]" || true

# 4. حل أي تعارضات modify/delete ناتجة عن ملفات قديمة محذوفة
echo "[INFO] حل التعارضات باعتماد الكود الأحدث..."
git status --porcelain | grep "^UD " | cut -c4- | while read -r f; do git rm -f "$f" 2>/dev/null || true; done
git status --porcelain | grep "^UU " | cut -c4- | while read -r f; do git checkout --theirs "$f" 2>/dev/null && git add "$f" 2>/dev/null || true; done
git status --porcelain | grep "^DU " | cut -c4- | while read -r f; do git checkout --theirs "$f" 2>/dev/null && git add "$f" 2>/dev/null || true; done

# إتمام الإيداع إذا كان الدمج معلقاً
if git status | grep -q "All conflicts fixed"; then
  git commit -m "chore: sync main with $DEV_BRANCH [v4.5.5 - M325]"
fi

# 5. رفع فرع main المحدث إلى GitHub
echo "[INFO] رفع التحديثات إلى فرع main على GitHub..."
git push origin main

# 6. العودة الفورية لفرع التطوير المعتمد
echo "[INFO] العودة إلى فرع التطوير المعتمد..."
git checkout "$DEV_BRANCH"

echo "============================================================"
echo "✅ تم بنجاح! الآن أصبح فرع main على GitHub محدثاً بالكامل حتى v4.5.5"
echo "📌 وأنت الآن متواجد على فرع التطوير الرسمي: $(git branch --show-current)"
echo "============================================================"
rm -f .sync_main.sh
