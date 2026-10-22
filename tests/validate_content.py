import json, glob, sys, os

def validate_all():
    with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
        reg = json.load(f)
    assets = reg.get("assets", {})
    assert len(assets) >= 50, f"Expected at least 50 registered assets, found {len(assets)}"

    for img_id, meta in assets.items():
        path = meta["asset_path"]
        assert os.path.exists(path), f"Missing file: {path}"
        assert os.path.getsize(path) <= 20480, f"File too large: {path}"

    files = glob.glob("content/vocabulary/*.json")
    assert len(files) >= 2, "Expected at least 2 vocabulary files"

    total = 0
    seen_ids = set()
    for fp in files:
        with open(fp, "r", encoding="utf-8") as f:
            data = json.load(f)
        for c in data["concepts"]:
            cid = c["concept_id"]
            assert cid not in seen_ids, f"Duplicate ID: {cid}"
            seen_ids.add(cid)
            assert c["image_id"] in assets, f"Unregistered image {c['image_id']} in {cid}"
            assert c["ar"]["vocalized"] and c["de"]["article"] and c["en"]["word"]
            total += 1

    print(f"PASS: {len(files)} categories validated.")
    print(f"PASS: Total {total} concepts verified and linked to {len(assets)} vector assets.")

if __name__ == "__main__":
    validate_all()
