import json, glob, sys, os

def validate_assets():
    with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
        reg = json.load(f)
    assets = reg.get("assets", {})
    assert len(assets) >= 25, f"Expected 25 assets, found {len(assets)}"
    for img_id, meta in assets.items():
        path = meta.get("asset_path")
        assert os.path.exists(path), f"Missing file: {path}"
        assert os.path.getsize(path) <= 20480, f"File too large: {path}"
    print(f"PASS: {len(assets)} visual assets verified on disk.")
    return assets

def validate_vocabulary(assets):
    with open("content/vocabulary/family_a1.json", "r", encoding="utf-8") as f:
        data = json.load(f)
    concepts = data["concepts"]
    assert len(concepts) >= 25
    seen = set()
    for c in concepts:
        cid = c["concept_id"]
        assert cid not in seen
        seen.add(cid)
        assert c["image_id"] in assets, f"Unregistered image {c['image_id']} in {cid}"
    print(f"PASS: {len(concepts)} concepts verified and linked to assets.")
    return len(concepts)

def main():
    assets = validate_assets()
    total = validate_vocabulary(assets)
    print(f"\nALL CHECKS PASSED: Total {total} concepts and {len(assets)} assets verified.")

if __name__ == "__main__":
    main()
