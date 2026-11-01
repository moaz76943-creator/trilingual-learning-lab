#!/bin/bash
# سكربت تنظيف وضغط المتجهات محلياً

echo "🧹 جاري فحص وتنظيف ملفات SVG..."

python3 - << 'PYOPT'
import glob
import re
import os

svg_files = glob.glob("content/assets/images/**/*.svg", recursive=True)
cleaned = 0

for path in svg_files:
    with open(path, "r", encoding="utf-8") as f:
        content = f.read()
    
    optimized = re.sub(r'<!--.*?-->', '', content, flags=re.DOTALL)
    optimized = re.sub(r'\s+', ' ', optimized).strip()
    
    if len(optimized) < len(content):
        with open(path, "w", encoding="utf-8") as f:
            f.write(optimized)
        cleaned += 1

print(f"✅ تم تنظيف وتحسين {cleaned} ملف متجهي بنجاح.")
PYOPT
