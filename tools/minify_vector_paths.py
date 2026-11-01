#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة تقليص دقة إحداثيات المتجهات tools/minify_vector_paths.py"""

import os
import glob
import re

def minify_paths():
    svg_files = glob.glob("content/assets/images/**/*.svg", recursive=True)
    minified_count = 0
    total_saved = 0
    
    def round_coords(match):
        val = float(match.group(0))
        return f"{val:.1f}".rstrip('0').rstrip('.')
        
    for path in svg_files:
        with open(path, "r", encoding="utf-8") as f:
            content = f.read()
            
        orig_len = len(content)
        simplified = re.sub(r'(\d+\.\d{3,})', round_coords, content)
        
        if len(simplified) < orig_len:
            with open(path, "w", encoding="utf-8") as f:
                f.write(simplified)
            minified_count += 1
            total_saved += (orig_len - len(simplified))
            
    print(f"✅ تم تقليص إحداثيات {minified_count} ملف متجهي وتوفير {total_saved / 1024:.1f} KB بنجاح.")

if __name__ == "__main__":
    minify_paths()
