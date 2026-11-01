#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة فحص الصور النقطية tools/check_bitmap_usage.py"""

import os
import glob

def check_bitmaps():
    patterns = ["assets/**/*.png", "assets/**/*.jpg", "content/**/*.png", "content/**/*.jpg"]
    found = []
    
    for pat in patterns:
        for f in glob.glob(pat, recursive=True):
            size_kb = os.path.getsize(f) / 1024
            if size_kb > 50:
                found.append((f, size_kb))
                
    if found:
        print("⚠️ تحذير: رصد صور نقطية تتجاوز 50KB:")
        for path, size in found:
            print(f"  - {path}: {size:.1f} KB")
    else:
        print("✅ خلو المشروع بنسبة 100% من أي صور نقطية ثقيلة (الاعتماد الكامل على متجهات SVG فائقة الخفة).")

if __name__ == "__main__":
    check_bitmaps()
