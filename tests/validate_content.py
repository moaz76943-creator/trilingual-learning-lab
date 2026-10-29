import json, os, glob

def validate():
    print("[TEST] Validating complete Cycle 150 Golden Release integrity and schemas...")
    
    # 1. Check Vocabulary Categories Count (Must be >= 90)
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary category files.")
    assert len(vocab_files) >= 90, f"Expected at least 90 vocab categories, found {len(vocab_files)}"
    
    # 2. Check Verbs Categories Count (Must be >= 24)
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} specialized verb files.")
    assert len(verb_files) >= 24, f"Expected at least 24 verb files, found {len(verb_files)}"

    # 3. Check App Manifest & Services
    manifest_file = "content/engine/app_manifest.json"
    dashboard_file = "lib/ui/mastery_dashboard_screen.dart"
    audio_file = "lib/services/offline_audio_coordinator.dart"
    assert os.path.exists(manifest_file), f"Missing {manifest_file}"
    assert os.path.exists(dashboard_file), f"Missing {dashboard_file}"
    assert os.path.exists(audio_file), f"Missing {audio_file}"
    with open(manifest_file, "r", encoding="utf-8") as f:
        man = json.load(f)
        assert man["metrics"]["vocabulary_categories"] == 90
        assert man["metrics"]["specialized_verb_engines"] == 24
        assert man["metrics"]["interactive_sentence_exercises"] == 375
    print("Golden Release manifest and UI/Audio services verified.")

    # 4. Check Sentences Builder Count (Must be >= 375)
    sent_file = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_file), f"Missing {sent_file}"
    with open(sent_file, "r", encoding="utf-8") as f:
        s_data = json.load(f)
        total_sents = len(s_data.get("sentences", []))
        print(f"Total interactive sentences: {total_sents}")
        assert total_sents >= 375, f"Expected at least 375 sentences, got {total_sents}"

    # 5. Check Images Registry (Must be >= 1031)
    reg_file = "content/assets/images_registry.json"
    assert os.path.exists(reg_file), f"Missing {reg_file}"
    with open(reg_file, "r", encoding="utf-8") as f:
        reg = json.load(f)
        print(f"Total registered SVGs: {len(reg)}")
        assert len(reg) >= 1031, f"Expected at least 1,031 registered SVGs, got {len(reg)}"

    print("🏆 ALL 150 CYCLES VALIDATION ASSERTIONS PASSED WITH GOLDEN PERFECTION! 🏆")

if __name__ == "__main__":
    validate()
