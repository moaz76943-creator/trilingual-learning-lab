#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""مدقق سلامة كود XML للمتجهات tests/validate_svg_syntax.py"""

import os
import glob
import xml.etree.ElementTree as ET
import sys

def validate_svgs():
    svg_files = glob.glob("content/assets/images/**/*.svg", recursive=True)
    if not svg_files:
        print("⚠️ لم يتم العثور على ملفات SVG لفحصها.")
        return
        
    errors = []
    for path in svg_files:
        try:
            ET.parse(path)
        except ET.ParseError as e:
            errors.append(f"{path}: {e}")
            
    if errors:
        print(f"❌ تم العثور على {len(errors)} ملفات SVG تالفة:")
        for err in errors[:5]:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print(f"✅ تم فحص {len(svg_files)} ملف SVG بنجاح، وجميعها متوافقة 100% مع معايير XML.")

if __name__ == "__main__":
    validate_svgs()
