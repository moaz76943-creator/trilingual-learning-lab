#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة استخلاص وتلخيص الخطوط assets/fonts/subset_fonts.py"""

import os
import json

def get_required_unicodes():
    ranges = [
        "U+0020-007E", # اللاتينية الأساسية والأرقام
        "U+00C4,U+00D6,U+00DC,U+00E4,U+00F6,U+00FC,U+00DF", # الحروف الألمانية الخاصة
        "U+0600-06FF", # الحروف والتشكيل العربي بالكامل
        "U+200C-200F", # محارف الوصل وعلامات اتجاه النصوص
    ]
    return ",".join(ranges)

def generate_subset_config():
    config = {
        "description": "Unicode ranges for trilingual Arabic-German-English subsetting",
        "unicodes": get_required_unicodes(),
        "target_fonts": ["Cairo", "Amiri", "Inter"]
    }
    with open("assets/fonts/subset_config.json", "w", encoding="utf-8") as f:
        json.dump(config, f, indent=2)
    print("✅ تم إنشاء إعدادات استخلاص الخطوط بنجاح في assets/fonts/subset_config.json")

if __name__ == "__main__":
    generate_subset_config()
