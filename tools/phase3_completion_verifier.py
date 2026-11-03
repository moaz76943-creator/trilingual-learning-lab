#!/usr/bin/env python3
import glob
import sys

def verify_halfway_milestone():
    print("🔍 فحص بلوغ المعلم المئوي الاستراتيجي (Task #250 - 50% Milestone)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 28, f"نقص في الأقسام اللغوية: {len(cats)} / 28"
    assert len(dialogues) >= 20, f"نقص في بنوك الحوارات: {len(dialogues)} / 20"
    assert len(verbs) >= 40, f"نقص في محركات الأفعال: {len(verbs)} / 40"
    
    print(f"🎉 تم تأكيد إنجاز نصف خارطة الطريق بالكامل ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً)!")
    return 0

if __name__ == "__main__":
    sys.exit(verify_halfway_milestone())
