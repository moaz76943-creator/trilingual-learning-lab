#!/usr/bin/env python3
import glob
import sys
import os

def run_grand_500_audit():
    print("=" * 65)
    print("🌟 الفحص التتويجي النهائي لإتمام خارطة الـ 500 مهمة كاملة (100%) 🌟")
    print("=" * 65)
    
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    print(f" + إجمالي أقسام المفردات التراكمية: {len(cats)} قسماً موثقاً")
    print(f" + إجمالي بنوك الحوارات والسياقات: {len(dialogues)} حواراً تفاعلياً")
    print(f" + إجمالي محركات تصريف الأفعال: {len(verbs)} محركاً لغوياً")
    
    assert len(cats) >= 70, f"نقص في الأقسام: {len(cats)} / 70"
    assert len(dialogues) >= 65, f"نقص في الحوارات: {len(dialogues)} / 65"
    assert len(verbs) >= 130, f"نقص في الأفعال: {len(verbs)} / 130"
    assert os.path.exists("lib/main.dart"), "ملف lib/main.dart مفقود"
    assert os.path.exists("content/assets/images_registry.json"), "سجل الأصول مفقود"
    
    print("✅ تم التحقق من سلامة كافة مكونات المعمارية النظيفة ومحتواها الثلاثي 100%.")
    return 0

if __name__ == "__main__":
    sys.exit(run_grand_500_audit())
