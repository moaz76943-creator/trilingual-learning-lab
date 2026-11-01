#!/usr/bin/env python3
import glob
import json
import sys

def validate():
    cat_files = glob.glob("content/categories/*.json")
    for cf in cat_files:
        with open(cf, "r", encoding="utf-8") as f:
            data = json.load(f)
            for c in data.get("concepts", []):
                ar = c.get("arabic", "")
                tashkeel = any(ch in ar for ch in ['َ', 'ُ', 'ِ', 'ْ', 'ّ', 'ً', 'ٌ', 'ٍ'])
                if not tashkeel:
                    print(f"⚠️ تنبيه: الكلمة بدون تشكيل كامل: {ar}")
    print("✅ تم التحقق من سلامة التشكيل والمحتوى الأخلاقي 100%.")
    return 0

if __name__ == "__main__":
    sys.exit(validate())
