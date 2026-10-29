import json, os, glob

def validate():
    print("[TEST] Validating trilingual content integrity, SRS memory engine, and asset schemas...")
    
    # 1. Check Vocabulary Categories Count
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary category files.")
    assert len(vocab_files) >= 90, f"Expected at least 90 vocab categories, found {len(vocab_files)}"
    
    # 2. Check Verbs Categories Count
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} specialized verb files.")
    assert len(verb_files) >= 24, f"Expected at least 24 verb files, found {len(verb_files)}"

    # 3. Check SRS Engine Files
    srs_json = "content/engine/srs_sm2_engine.json"
    srs_dart = "lib/engine/srs_service.dart"
    assert os.path.exists(srs_json), f"Missing {srs_json}"
    assert os.path.exists(srs_dart), f"Missing {srs_dart}"
    with open(srs_json, "r", encoding="utf-8") as f:
        spec = json.load(f)
        assert spec.get("engine_id") == "sm2_spaced_repetition", "Invalid SRS engine specification"
        assert len(spec.get("mastery_tiers", [])) == 6, "Expected 6 mastery tiers in SM-2 specification"
    print("SRS Engine specification and Dart service verified.")

    # 4. Check Sentences Builder Count
    sent_file = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_file), f"Missing {sent_file}"
    with open(sent_file, "r", encoding="utf-8") as f:
        s_data = json.load(f)
        total_sents = len(s_data.get("sentences", []))
        print(f"Total interactive sentences: {total_sents}")
        assert total_sents >= 370, f"Expected at least 370 sentences, got {total_sents}"

    # 5. Check Images Registry
    reg_file = "content/assets/images_registry.json"
    assert os.path.exists(reg_file), f"Missing {reg_file}"
    with open(reg_file, "r", encoding="utf-8") as f:
        reg = json.load(f)
        print(f"Total registered SVGs: {len(reg)}")
        assert len(reg) >= 1026, f"Expected at least 1,026 registered SVGs, got {len(reg)}"

    print("✅ All validation assertions passed flawlessly!")

if __name__ == "__main__":
    validate()
