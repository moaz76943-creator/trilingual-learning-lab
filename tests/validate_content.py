import json, os, glob

def validate():
    print("[TEST] Validating content integrity, assets, and syntax...")
    
    # 1. Vocabulary Categories
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary category files.")
    assert len(vocab_files) >= 86, f"Expected at least 86 vocab files, got {len(vocab_files)}"
    
    # 2. Verbs Categories
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} specialized verb files.")
    assert len(verb_files) >= 20, f"Expected at least 20 verb files, got {len(verb_files)}"
    
    target_verb_file = "content/verbs/sensorimotor_embodied_verbs_b2_c1.json"
    assert os.path.exists(target_verb_file), f"Missing {target_verb_file}"
    with open(target_verb_file, "r", encoding="utf-8") as f:
        v_data = json.load(f)
        assert len(v_data.get("items", [])) == 20, "Sensorimotor verbs items count must be 20"
        for item in v_data["items"]:
            assert "german" in item and "arabic" in item and "english" in item, "Missing trilingual fields"
            assert "conjugation" in item, "Missing conjugation"
            assert "image" in item, "Missing image asset reference"
            assert os.path.exists(f"content/{item['image']}"), f"Missing SVG on disk: {item['image']}"
            
    # 3. Sentences Builder
    sent_file = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_file), f"Missing {sent_file}"
    with open(sent_file, "r", encoding="utf-8") as f:
        s_data = json.load(f)
        total_sents = len(s_data.get("sentences", []))
        print(f"Total sentences: {total_sents}")
        assert total_sents >= 325, f"Expected at least 325 sentences, got {total_sents}"
        
    # 4. SVG Images & Registry
    reg_file = "content/assets/images_registry.json"
    assert os.path.exists(reg_file), f"Missing {reg_file}"
    with open(reg_file, "r", encoding="utf-8") as f:
        reg = json.load(f)
        print(f"Total registered SVGs: {len(reg)}")
        assert len(reg) >= 841, f"Expected at least 841 registered SVGs, got {len(reg)}"
        
    print("✅ All validation tests passed successfully!")

if __name__ == "__main__":
    validate()
