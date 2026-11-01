#!/usr/bin/env python3
"""
tools/index_svg_assets.py
فهرسة وتدقيق الأصول المتجهة SVG وتوليد بيان الأصول content/assets/svg_manifest.json
"""
import os
import json
import hashlib
import re

def index_svg_assets():
    base_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    assets_dir = os.path.join(base_dir, "content", "assets")
    svg_dir = os.path.join(assets_dir, "svg")
    registry_path = os.path.join(assets_dir, "images_registry.json")
    manifest_path = os.path.join(assets_dir, "svg_manifest.json")

    os.makedirs(svg_dir, exist_ok=True)
    os.makedirs(assets_dir, exist_ok=True)

    # 1. قراءة سجل الصور الموحد
    registry = {}
    if os.path.exists(registry_path):
        with open(registry_path, "r", encoding="utf-8") as f:
            try:
                registry = json.load(f)
            except Exception:
                registry = {}
    else:
        with open(registry_path, "w", encoding="utf-8") as f:
            json.dump(registry, f, ensure_ascii=False, indent=2)

    print(f"📦 تم فحص سجل الأصول: {len(registry)} إدخال مسجل.")

    # 2. حصر ملفات المتجهات وتوليد بيانات القياس والبصمة
    indexed_files = {}
    for root, _, files in os.walk(assets_dir):
        for f in files:
            if f.endswith(".svg"):
                full_path = os.path.join(root, f)
                rel_path = os.path.relpath(full_path, base_dir)
                size = os.path.getsize(full_path)
                with open(full_path, "rb") as svg_file:
                    content = svg_file.read()
                    file_hash = hashlib.sha256(content).hexdigest()
                    content_str = content.decode("utf-8", errors="ignore")
                    viewbox_match = re.search(r'viewBox=["\']([^"\']+)["\']', content_str)
                    viewbox = viewbox_match.group(1) if viewbox_match else "0 0 100 100"

                key = os.path.splitext(f)[0]
                indexed_files[key] = {
                    "path": rel_path,
                    "size_bytes": size,
                    "sha256": file_hash,
                    "viewBox": viewbox
                }

    # 3. حفظ بيان الأصول الرسمي svg_manifest.json
    manifest = {
        "version": "1.0.0",
        "total_indexed_svgs": len(indexed_files),
        "total_registry_entries": len(registry),
        "assets": indexed_files
    }
    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(manifest, f, ensure_ascii=False, indent=2)

    print(f"✅ تم تحديث بيان الأصول بنجاح: {manifest_path}")
    print(f" + عدد ملفات SVG المفهرسة: {len(indexed_files)}")
    print(f" + عدد ارتباطات السجل: {len(registry)}")
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(index_svg_assets())
