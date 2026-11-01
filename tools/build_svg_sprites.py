#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""أداة بناء أطلس المتجهات tools/build_svg_sprites.py"""

import os
import glob
import re

def build_sprites():
    categories = glob.glob("content/assets/images/category_*")
    sprites_dir = "content/assets/sprites"
    os.makedirs(sprites_dir, exist_ok=True)
    
    count = 0
    for cat in categories:
        cat_name = os.path.basename(cat)
        svgs = glob.glob(f"{cat}/*.svg")
        if not svgs:
            continue
            
        sprite_path = f"{sprites_dir}/{cat_name}_sprite.svg"
        symbols = []
        for svg_file in svgs:
            cid = os.path.splitext(os.path.basename(svg_file))[0]
            with open(svg_file, "r", encoding="utf-8") as f:
                content = f.read()
            inner_match = re.search(r'<svg[^>]*>(.*?)</svg>', content, re.DOTALL)
            inner = inner_match.group(1).strip() if inner_match else ""
            symbols.append(f'<g id="{cid}">{inner}</g>')
            
        sprite_content = f'''<svg xmlns="http://www.w3.org/2000/svg" style="display:none;">
  <defs>
    {''.join(symbols)}
  </defs>
</svg>'''
        with open(sprite_path, "w", encoding="utf-8") as f:
            f.write(sprite_content)
        count += 1
        
    print(f"✅ تم بناء {count} ملف أطلس Sprite بنجاح في {sprites_dir}.")

if __name__ == "__main__":
    build_sprites()
