#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة اكتشاف المتجهات المكررة عبر البصمة الرقمية tools/deduplicate_assets.py"""

import os
import glob
import hashlib
import json

def deduplicate():
    svg_files = glob.glob("content/assets/images/**/*.svg", recursive=True)
    registry_file = "content/assets/images_registry.json"
    
    hash_map = {}
    duplicates = []
    
    for path in svg_files:
        with open(path, "rb") as f:
            digest = hashlib.sha256(f.read()).hexdigest()
        
        if digest in hash_map:
            duplicates.append((path, hash_map[digest]))
        else:
            hash_map[digest] = path
            
    print(f"🔍 فحص {len(svg_files)} ملفاً: وجد {len(duplicates)} ملفات متطابقة البصمة.")
    
    if os.path.exists(registry_file) and duplicates:
        with open(registry_file, "r", encoding="utf-8") as f:
            registry = json.load(f)
            
        updated = 0
        for dup_path, canonical_path in duplicates:
            dup_id = os.path.splitext(os.path.basename(dup_path))[0]
            if dup_id in registry:
                registry[dup_id] = canonical_path
                updated += 1
                
        with open(registry_file, "w", encoding="utf-8") as f:
            json.dump(registry, f, ensure_ascii=False, indent=2)
            
        print(f"✅ تم تحديث {updated} مساراً في {registry_file} لتشير للمسارات المرجعية.")

if __name__ == "__main__":
    deduplicate()
