#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""اختبار نسبة تغطية الأصول الرسومية tests/test_concept_asset_coverage.py"""

import os
import glob
import json
import sys

def test_coverage():
    registry_file = "content/assets/images_registry.json"
    if not os.path.exists(registry_file):
        print("❌ سجل الأصول غير موجود")
        sys.exit(1)
        
    with open(registry_file, "r", encoding="utf-8") as f:
        registry = json.load(f)
        
    vocab_files = glob.glob("content/vocabulary/*.json")
    total_concepts = 0
    covered_concepts = 0
    
    for vf in vocab_files:
        with open(vf, "r", encoding="utf-8") as f:
            data = json.load(f)
        concepts = data.get("concepts", [])
        total_concepts += len(concepts)
        for c in concepts:
            cid = c.get("id")
            if cid in registry:
                covered_concepts += 1
                
    coverage_ratio = (covered_concepts / total_concepts * 100) if total_concepts > 0 else 0
    print(f"📊 إجمالي المفاهيم: {total_concepts} | المغطى برسم مسجل: {covered_concepts} ({coverage_ratio:.1f}%)")
    
    if coverage_ratio >= 90.0:
        print(f"✅ نسبة تغطية الأصول تتجاوز المعيار المطلوب بنجاح ({coverage_ratio:.1f}% >= 90.0%)!")
    else:
        print(f"⚠️ تنبيه: نسبة التغطية أقل من المعيار المطلوب ({coverage_ratio:.1f}% < 90.0%)")

if __name__ == "__main__":
    test_coverage()
