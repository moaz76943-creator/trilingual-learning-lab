#!/bin/bash
# أداة تحليل الحجم الإجمالي وميزانية الأصول

echo "📊 جاري تحليل الحجم الإجمالي لمكونات التطبيق والأصول..."

python3 - << 'PYSIZE'
import os
import glob

def analyze():
    categories = {
        "Dart Code (lib)": glob.glob("lib/**/*.dart", recursive=True),
        "JSON Content": glob.glob("content/**/*.json", recursive=True),
        "SVG Assets": glob.glob("content/assets/**/*.svg", recursive=True),
        "Tests & Tools": glob.glob("tests/**/*.py", recursive=True) + glob.glob("tools/**/*", recursive=True)
    }
    
    total_bytes = 0
    stats = {}
    
    for cat, files in categories.items():
        cat_size = sum(os.path.getsize(f) for f in files if os.path.isfile(f))
        stats[cat] = (len(files), cat_size)
        total_bytes += cat_size
        
    print(f"\n==================== ميزانية أصول التطبيق ====================")
    for cat, (count, size) in stats.items():
        mb = size / (1024 * 1024)
        pct = (size / total_bytes * 100) if total_bytes > 0 else 0
        print(f" • {cat:20}: {count:5} ملف | {mb:6.2f} MB ({pct:5.1f}%)")
    
    total_mb = total_bytes / (1024 * 1024)
    print(f"-------------------------------------------------------------")
    print(f" إجمالي حجم الأصول: {total_mb:.2f} MB (سقف الميزانية: 35.00 MB)")
    
    if total_mb <= 35.0:
        print("✅ الحجم منضبط تماماً وتحت سقف الميزانية المحدد (<35MB) بنجاح!")
    else:
        print("⚠️ تنبيه: تجاوز حجم الأصول سقف الميزانية.")

if __name__ == "__main__":
    analyze()
PYSIZE
