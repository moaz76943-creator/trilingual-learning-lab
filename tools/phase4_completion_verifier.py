#!/usr/bin/env python3
import glob
import sys

def verify_phase4_milestone():
    print("🔍 فحص بلوغ المعلم المئوي الرابع (Task #350 - 70% Milestone)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 45, f"نقص في الأقسام اللغوية: {len(cats)} / 45"
    assert len(dialogues) >= 30, f"نقص في بنوك الحوارات: {len(dialogues)} / 30"
    assert len(verbs) >= 65, f"نقص في محركات الأفعال: {len(verbs)} / 65"
    
    print(f"🎉 تم تأكيد إنجاز المرحلة الرابعة بنجاح ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً)!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_phase4_milestone())
