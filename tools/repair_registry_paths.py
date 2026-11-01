#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة فحص وتصليح مسارات سجل الأصول tools/repair_registry_paths.py"""

import os
import json

def repair_registry():
    registry_file = "content/assets/images_registry.json"
    if not os.path.exists(registry_file):
        print("⚠️ لم يتم العثور على سجل الأصول.")
        return
        
    with open(registry_file, "r", encoding="utf-8") as f:
        registry = json.load(f)
        
    initial_count = len(registry)
    orphans = []
    
    for key, path in list(registry.items()):
        if not os.path.exists(path):
            orphans.append((key, path))
            
    if orphans:
        print(f"⚠️ رصد {len(orphans)} مساراً يتيماً في السجل، جاري الفحص والإصلاح...")
        for key, bad_path in orphans:
            cat = key.split('_')[0]
            candidate = f"content/assets/images/category_{cat[1:]}/{key}.svg"
            if os.path.exists(candidate):
                registry[key] = candidate
            else:
                del registry[key]
                
        with open(registry_file, "w", encoding="utf-8") as f:
            json.dump(registry, f, indent=2, ensure_ascii=False)
        print(f"✅ تم تصليح السجل وتحديث مساراته بنجاح.")
    else:
        print(f"✅ فحص السجل سليم 100%: جميع المسارات الـ {initial_count} تشير لملفات حقيقية وموجودة.")

if __name__ == "__main__":
    repair_registry()
