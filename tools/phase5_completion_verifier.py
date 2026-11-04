#!/usr/bin/env python3
import glob
import sys

def verify_phase5_milestone():
    print("🔍 فحص بلوغ المعلم المئوي السادس (Task #450 - 90% Milestone)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 60, f"نقص في الأقسام اللغوية: {len(cats)} / 60"
    assert len(dialogues) >= 55, f"نقص في بنوك الحوارات: {len(dialogues)} / 55"
    assert len(verbs) >= 105, f"نقص في محركات الأفعال: {len(verbs)} / 105"
    
    print(f"🎉 تم تأكيد إنجاز المرحلة الخامسة وبلوغ 90% بنجاح ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً)!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_phase5_milestone())
