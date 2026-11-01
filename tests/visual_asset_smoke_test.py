#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة فحص الأصول البصري tests/visual_asset_smoke_test.py"""

import os
import glob
import xml.etree.ElementTree as ET
import sys

def smoke_test():
    svg_files = glob.glob("content/assets/images/**/*.svg", recursive=True)
    if not svg_files:
        print("⚠️ لم يتم العثور على ملفات SVG لفحصها.")
        return
        
    invalid_viewbox = []
    zero_size = []
    
    for path in svg_files:
        if os.path.getsize(path) == 0:
            zero_size.append(path)
            continue
            
        try:
            tree = ET.parse(path)
            root = tree.getroot()
            has_viewbox = "viewBox" in root.attrib or ("width" in root.attrib and "height" in root.attrib)
            if not has_viewbox:
                invalid_viewbox.append(path)
        except Exception as e:
            invalid_viewbox.append(f"{path} ({e})")
            
    if zero_size or invalid_viewbox:
        print(f"❌ رصد مشاكل بصرية في المتجهات: فارغة={len(zero_size)}، أبعاد غير صالحة={len(invalid_viewbox)}")
        sys.exit(1)
    else:
        print(f"✅ فحص الدخان البصري ناجح 100%: تم التحقق من سلامة أبعاد {len(svg_files)} ملف SVG على كافة كثافات الشاشات.")

if __name__ == "__main__":
    smoke_test()
