#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة فحص سلامة شجرة التبعيات tools/check_dependency_hygiene.py"""

import os
import sys

def check_dependencies():
    pubspec_path = "pubspec.yaml"
    if not os.path.exists(pubspec_path):
        print("❌ لم يتم العثور على pubspec.yaml")
        sys.exit(1)
        
    with open(pubspec_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    banned = ["firebase", "sqflite", "google_mobile_ads", "facebook"]
    found_banned = [p for p in banned if p in content]
    
    if found_banned:
        print(f"⚠️ تحذير: رصد حزم ثقيلة غير ضرورية: {found_banned}")
    else:
        print("✅ شجرة التبعيات في pubspec.yaml نظيفة تماماً ومتوافقة مع المعمارية الصافية.")

if __name__ == "__main__":
    check_dependencies()
