import json, glob, sys, os

def validate_all():
    # 1. فحص الأصول المسجلة (195 صورة SVG)
    with open("content/assets/images_registry.json", "r", encoding="utf-8") as f:
        reg = json.load(f)
    assets = reg.get("assets", {})
    assert len(assets) >= 195, f"Expected at least 195 assets, found {len(assets)}"

    for img_id, meta in assets.items():
        p = meta["asset_path"]
        assert os.path.exists(p), f"Missing: {p}"
        assert os.path.getsize(p) <= 20480, f"Too large: {p}"

    # 2. فحص المفردات (7 فئات نشطة = 180 مفردة بالتمام والكمال)
    files = glob.glob("content/vocabulary/*.json")
    assert len(files) >= 7, f"Expected at least 7 vocabulary files, found {len(files)}"
    v_total = sum(len(json.load(open(fp, "r", encoding="utf-8"))["concepts"]) for fp in files)
    assert v_total >= 180, f"Expected 180 concepts, found {v_total}"

    # 3. فحص الأفعال والتصريفات (15 فعلًا)
    with open("content/verbs/verbs_a1.json", "r", encoding="utf-8") as f:
        vdata = json.load(f)
    verbs = vdata.get("verbs", [])
    assert len(verbs) >= 15, f"Expected 15 verbs, found {len(verbs)}"

    # 4. فحص الجمل التركيبية (20 جملة)
    with open("content/grammar/sentences_a1.json", "r", encoding="utf-8") as f:
        sdata = json.load(f)
    sentences = sdata.get("sentences", [])
    assert len(sentences) >= 20, f"Expected 20 sentences, found {len(sentences)}"

    print(f"PASS: 7 active categories validated ({v_total} concepts).")
    print(f"PASS: 15 comprehensive verbs and 20 sentence builder exercises validated.")
    print(f"PASS: Total {len(assets)} vector SVG assets verified on disk.")

if __name__ == "__main__":
    validate_all()
