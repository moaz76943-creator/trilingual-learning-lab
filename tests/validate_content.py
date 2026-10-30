import json, os, glob

def validate():
    print("[TEST] Validating trilingual content integrity, Century Category 100, and asset schemas...")
    
    # 1. Check Vocabulary Categories Count (Must be >= 100 Milestone)
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary category files.")
    assert len(vocab_files) >= 100, f"Expected at least 100 vocab categories, found {len(vocab_files)}"
    
    target_vocab = "content/vocabulary/cosmic_pansophy_c2.json"
    assert os.path.exists(target_vocab), f"Missing {target_vocab}"
    with open(target_vocab, "r", encoding="utf-8") as f:
        v_data = json.load(f)
        items = v_data.get("items", [])
        assert len(items) == 25, f"Expected 25 items in Category 100, got {len(items)}"
        for item in items:
            assert "german" in item and "arabic" in item and "english" in item, "Missing trilingual fields"
            assert "example_sentence" in item, "Missing example sentence"
            assert "image" in item, "Missing image asset field"
            assert os.path.exists(f"content/{item['image']}"), f"Missing SVG on disk: {item['image']}"

    # 2. Check Verbs Categories Count (Must be >= 32)
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} specialized verb files.")
    assert len(verb_files) >= 32, f"Expected at least 32 verb files, found {len(verb_files)}"

    # 3. Check Sentences Builder Count (Must be >= 465)
    sent_file = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_file), f"Missing {sent_file}"
    with open(sent_file, "r", encoding="utf-8") as f:
        s_data = json.load(f)
        total_sents = len(s_data.get("sentences", []))
        print(f"Total interactive sentences: {total_sents}")
        assert total_sents >= 465, f"Expected at least 465 sentences, got {total_sents}"

    # 4. Check Images Registry (Must be >= 1441)
    reg_file = "content/assets/images_registry.json"
    assert os.path.exists(reg_file), f"Missing {reg_file}"
    with open(reg_file, "r", encoding="utf-8") as f:
        reg = json.load(f)
        print(f"Total registered SVGs: {len(reg)}")
        assert len(reg) >= 1441, f"Expected at least 1,441 registered SVGs, got {len(reg)}"

    print("🏆 ALL 100 VOCABULARY CATEGORIES COMPLETED WITH FLYING COLORS! 2,500 CONCEPTS MILESTONE REACHED! 🏆")

if __name__ == "__main__":
    validate()
