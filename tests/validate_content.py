import json
import glob
import sys
import os

MAX_ASSET_SIZE_BYTES = 20 * 1024  # حد أقصى 20KB للأصل المتجهي الخفيف

def validate_assets_registry():
    registry_path = "content/assets/images_registry.json"
    assert os.path.exists(registry_path), "Missing images_registry.json!"
    with open(registry_path, "r", encoding="utf-8") as f:
        reg = json.load(f)
    
    assets = reg.get("assets", {})
    assert len(assets) >= 25, f"Expected at least 25 registered assets, found {len(assets)}"
    
    for img_id, meta in assets.items():
        path = meta.get("asset_path")
        assert path and os.path.exists(path), f"Asset file missing on disk: {path} for {img_id}"
        size = os.path.getsize(path)
        assert size > 0, f"Empty asset file: {path}"
        assert size <= MAX_ASSET_SIZE_BYTES, f"Asset file exceeds 20KB limit ({size} bytes): {path}"
        
        # التأكد من صحة ترويسة SVG
        with open(path, "r", encoding="utf-8") as svg_f:
            header = svg_f.read(150)
            assert "<svg" in header, f"Invalid SVG format in {path}"
            
    print(f"PASS: {len(assets)} visual assets verified on disk and conform to size limits.")
    return assets

def validate_category_file(file_path, valid_assets):
    print(f"Checking: {file_path}")
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    required_top = ["category_id", "category_name", "level", "version", "concepts"]
    for field in required_top:
        assert field in data, f"Missing top-level field: {field}"

    concepts = data["concepts"]
    assert len(concepts) >= 25, f"Expected at least 25 concepts, found {len(concepts)}"

    seen_ids = set()
    valid_articles = {"der", "die", "das"}
    valid_genders = {"m", "f", "n"}

    for idx, c in enumerate(concepts):
        cid = c.get("concept_id")
        assert cid, f"Missing concept_id at index {idx}"
        assert cid not in seen_ids, f"Duplicate concept_id: {cid}"
        seen_ids.add(cid)

        # Arabic check
        ar = c.get("ar", {})
        assert ar.get("word") and ar.get("vocalized") and ar.get("example"), f"Incomplete AR data in {cid}"
        assert ar.get("gender") in valid_genders, f"Invalid AR gender in {cid}"

        # German check
        de = c.get("de", {})
        assert de.get("word") and de.get("article") and de.get("example"), f"Incomplete DE data in {cid}"
        assert de["article"].lower() in valid_articles, f"Invalid German article in {cid}"

        # English check
        en = c.get("en", {})
        assert en.get("word") and en.get("example"), f"Incomplete EN data in {cid}"

        # التحقق من ربط الصورة ومطابقتها للسجل
        img_id = c.get("image_id")
        assert img_id, f"Missing image_id in {cid}"
        assert img_id in valid_assets, f"Concept {cid} references unregistered image_id: {img_id}"

    print(f"PASS: {len(concepts)} concepts verified and linked to registered visual assets.")
    return len(concepts)

def main():
    print("--- [1/2] Checking Visual Assets Registry ---")
    assets = validate_assets_registry()
    
    print("\n--- [2/2] Checking Vocabulary Datasets ---")
    files = glob.glob("content/vocabulary/*.json")
    if not files:
        print("ERROR: No vocabulary files found!")
        sys.exit(1)

    total = 0
    for file_path in files:
        total += validate_category_file(file_path, assets)

    print(f"\nALL CHECKS PASSED: Total {total} concepts and {len(assets)} vector assets verified successfully.")

if __name__ == "__main__":
    main()
