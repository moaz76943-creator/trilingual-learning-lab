#!/usr/bin/env python3
import os
import glob
import json

def verify_phase2():
    print("🔍 التحقق من بلوغ المعلم المئوي للمشروع (Task #100)...")
    
    # التحقق من الخدمات المعمارية الأساسية
    core_files = [
        "lib/core/privacy/privacy_protection_guard.dart",
        "lib/core/audio/trilingual_audio_player_service.dart",
        "lib/features/vocabulary/domain/services/srs_scheduler_service.dart",
        "lib/features/vocabulary/domain/services/phonetic_comparison_service.dart"
    ]
    for cf in core_files:
        assert os.path.exists(cf), f"نقص في ملف الخدمة: {cf}"
        
    # التحقق من وجود الحوارات والأقسام اللغوية
    cats = glob.glob("content/categories/*.json")
    dialogues = glob.glob("content/sentences/*.json")
    assert len(cats) >= 5, f"عدد الأقسام اللغوية غير كاف: {len(cats)}"
    assert len(dialogues) >= 2, f"عدد الحوارات وبنوك الجمل غير كاف: {len(dialogues)}"
    
    print(f"✅ تم تأكيد إنجاز المعلم المئوي الأول بنجاح ({len(cats)} أقسام و {len(dialogues)} بنوك جمل).")
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(verify_phase2())
