#!/usr/bin/env python3
import glob
import sys

def verify_milestone_300():
    print("🔍 فحص بلوغ المعلم المئوي الثالث (Task #300 - 60% Milestone)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 35, f"نقص في الأقسام اللغوية: {len(cats)} / 35"
    assert len(dialogues) >= 25, f"نقص في بنوك الحوارات: {len(dialogues)} / 25"
    assert len(verbs) >= 50, f"نقص في محركات الأفعال: {len(verbs)} / 50"
    
    print(f"🎉 تم تأكيد إنجاز المعلم المئوي الثالث بنجاح ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً)!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_milestone_300())
