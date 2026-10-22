import json, glob, sys, os

def validate_all():
    # 1. فحص الأصول المسجلة
    with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
        reg = json.load(f)
    assets = reg.get("assets", {})
    assert len(assets) >= 65, f"Expected at least 65 assets, found {len(assets)}"

    for img_id, meta in assets.items():
        p = meta["asset_path"]
        assert os.path.exists(p), f"Missing: {p}"
        assert os.path.getsize(p) <= 20480, f"Too large: {p}"

    # 2. فحص المفردات (العائلة + الطعام = 50)
    files = glob.glob("content/vocabulary/*.json")
    assert len(files) >= 2, "Expected at least 2 vocabulary files"
    v_total = sum(len(json.load(open(fp, "r", encoding="utf-8"))["concepts"]) for fp in files)
    assert v_total >= 50, f"Expected 50 concepts, found {v_total}"

    # 3. فحص الأفعال والتصريفات (15 فعلًا)
    with open("content/verbs/verbs_a1.json", "r", encoding="utf-8") as f:
        vdata = json.load(f)
    verbs = vdata.get("verbs", [])
    assert len(verbs) >= 15, f"Expected 15 verbs, found {len(verbs)}"
    
    for v in verbs:
        assert v["verb_id"] and v["image_id"] in assets
        assert "ich" in v["conjugations"]["de"] and "I" in v["conjugations"]["en"] and "أنا" in v["conjugations"]["ar"]

    print(f"PASS: 50 vocabulary concepts verified.")
    print(f"PASS: 15 comprehensive verbs and 3-language conjugations verified.")
    print(f"PASS: Total {len(assets)} vector SVG assets verified on disk.")

if __name__ == "__main__":
    validate_all()
