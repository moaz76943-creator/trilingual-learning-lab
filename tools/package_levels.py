#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة تجميع وحزم مستويات التعلم tools/package_levels.py"""

import os
import glob
import json

def package_levels():
    vocab_files = glob.glob("content/vocabulary/*.json")
    levels_manifest = {"A1": [], "A2": [], "B1": []}
    
    for vf in vocab_files:
        with open(vf, "r", encoding="utf-8") as f:
            data = json.load(f)
            
        lvl = data.get("level", "A1")
        primary_lvl = "A1" if "A1" in lvl else ("A2" if "A2" in lvl else "B1")
        levels_manifest[primary_lvl].append(os.path.basename(vf))
        
    os.makedirs("content/levels", exist_ok=True)
    with open("content/levels/level_packs.json", "w", encoding="utf-8") as f:
        json.dump(levels_manifest, f, indent=2, ensure_ascii=False)
        
    print(f"✅ تم تجميع حزم المستويات بنجاح: A1={len(levels_manifest['A1'])}, A2={len(levels_manifest['A2'])}, B1={len(levels_manifest['B1'])} فئة.")

if __name__ == "__main__":
    package_levels()
