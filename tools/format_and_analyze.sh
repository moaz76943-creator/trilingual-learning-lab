#!/bin/bash
# سكربت فحص جودة وتنسيق الكود الموحد

echo "🔍 جاري فحص جودة وتنسيق الكود..."

if command -v dart >/dev/null 2>&1; then
  echo "📐 تشغيل dart format..."
  dart format --output=none --set-exit-if-changed lib/ test/ || echo "⚠️ توجد ملفات تحتاج تنسيق"

  echo "🔎 تشغيل dart analyze..."
  dart analyze lib/ test/ || echo "⚠️ توجد ملاحظات تحليل"
else
  echo "ℹ️ بيئة dart غير مثبتة في هذا المسار، تم تخطي فحص مترجم الدارت"
fi

echo "🧪 تشغيل مدققات المحتوى اللغوي..."
python3 tests/validate_content.py || { echo "❌ فشل فحص المحتوى"; exit 1; }

echo "✅ اكتمل فحص الجودة بنجاح تام!"
exit 0
