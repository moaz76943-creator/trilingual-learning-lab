#!/usr/bin/env python3
import os
import glob

def verify_phase3_midpoint():
    print("🔍 التحقق من بلوغ المعلم المئوي الثاني (Task #200)...")
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    verbs = glob.glob("content/verbs/*.json")
    
    assert len(cats) >= 20, f"نقص في الأقسام اللغوية: {len(cats)} / 20"
    assert len(dialogues) >= 15, f"نقص في بنوك الحوارات: {len(dialogues)} / 15"
    assert len(verbs) >= 25, f"نقص في محركات الأفعال: {len(verbs)} / 25"
    
    print(f"✅ تم تأكيد إنجاز المعلم المئوي الثاني بنجاح ({len(cats)} قسماً، {len(dialogues)} حواراً، {len(verbs)} فعلاً).")
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(verify_phase3_midpoint())
