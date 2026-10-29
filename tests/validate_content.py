import json, os, glob

def validate():
    print("[TEST] Validating trilingual content integrity, category 26 structuralism verbs, and asset schemas...")
    
    # 1. Check Vocabulary Categories Count (Must be >= 92)
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary category files.")
    assert len(vocab_files) >= 92, f"Expected at least 92 vocab categories, found {len(vocab_files)}"
    
    # 2. Check Verbs Categories Count (Must be >= 26)
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} specialized verb files.")
    assert len(verb_files) >= 26, f"Expected at least 26 verb files, found {len(verb_files)}"

    target_verb = "content/verbs/c2_narrative_structuralism_verbs_c2.json"
    assert os.path.exists(target_verb), f"Missing {target_verb}"
    with open(target_verb, "r", encoding="utf-8") as f:
        v_data = json.load(f)
        items = v_data.get("items", [])
        assert len(items) == 20, f"Expected 20 items in C2 structuralism verbs, got {len(items)}"
        for item in items:
            assert "german" in item and "arabic" in item and "english" in item, "Missing trilingual fields"
            assert "conjugation" in item, "Missing conjugation table"
            assert "collocations" in item, "Missing collocations list"
            assert "example_sentence" in item, "Missing example sentence"
            assert "image" in item, "Missing image asset field"
            assert os.path.exists(f"content/{item['image']}"), f"Missing SVG on disk: {item['image']}"

    # 3. Check Sentences Builder Count (Must be >= 395)
    sent_file = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_file), f"Missing {sent_file}"
    with open(sent_file, "r", encoding="utf-8") as f:
        s_data = json.load(f)
        total_sents = len(s_data.get("sentences", []))
        print(f"Total interactive sentences: {total_sents}")
        assert total_sents >= 395, f"Expected at least 395 sentences, got {total_sents}"

    # 4. Check Images Registry (Must be >= 1121)
    reg_file = "content/assets/images_registry.json"
    assert os.path.exists(reg_file), f"Missing {reg_file}"
    with open(reg_file, "r", encoding="utf-8") as f:
        reg = json.load(f)
        print(f"Total registered SVGs: {len(reg)}")
        assert len(reg) >= 1121, f"Expected at least 1,121 registered SVGs, got {len(reg)}"

    print("✅ All validation assertions passed flawlessly! C2 Narrative Structuralism Verbs Verified!")

if __name__ == "__main__":
    validate()
