#!/usr/bin/env python3
import glob
import sys

def verify_milestone_400():
    print("🔍 فحص بلوغ المعلم المئوي الخامس (Task #400 - 80% Milestone)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 55, f"نقص في الأقسام اللغوية: {len(cats)} / 55"
    assert len(dialogues) >= 45, f"نقص في بنوك الحوارات: {len(dialogues)} / 45"
    assert len(verbs) >= 90, f"نقص في محركات الأفعال: {len(verbs)} / 90"
    
    print(f"🎉 تم تأكيد إنجاز 80% من الخارطة الهندسية بنجاح ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً)!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_milestone_400())
