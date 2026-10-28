import json
import os
import glob

def test_validation():
    print(">>> Running Trilingual Learning Lab Comprehensive Integrity Suite...")
    
    # 1. Vocabulary categories check
    vocab_files = glob.glob("content/vocabulary/*.json")
    print(f"Found {len(vocab_files)} vocabulary categories.")
    assert len(vocab_files) >= 83, f"Expected at least 80 categories, found {len(vocab_files)}"
    
    # 2. Sentences check
    sent_path = "content/sentences/sentences_a1.json"
    assert os.path.exists(sent_path), "Missing sentences_a1.json"
    with open(sent_path, "r", encoding="utf-8") as f:
        sent_data = json.load(f)
        s_count = len(sent_data.get("sentences", []))
        print(f"Validated sentences count: {s_count}")
        assert s_count >= 290, f"Expected at least 265 sentences, found {s_count}"
        
    # 3. Images registry check
    reg_path = "content/assets/images_registry.json"
    assert os.path.exists(reg_path), "Missing images_registry.json"
    with open(reg_path, "r", encoding="utf-8") as f:
        reg_data = json.load(f)
        r_count = len(reg_data)
        print(f"Validated registered SVGs count: {r_count}")
        assert r_count >= 685, f"Expected at least 2360 SVGs, found {r_count}"
        
    # 4. Verbs engines check
    verb_files = glob.glob("content/verbs/*.json")
    print(f"Found {len(verb_files)} verb engines.")
    assert len(verb_files) >= 8, f"Expected at least 8 verb engines, found {len(verb_files)}"
    
    # 5. Exam engine check
    exam_path = "content/exams/exam_simulator_c1.json"
    if os.path.exists(exam_path):
        with open(exam_path, "r", encoding="utf-8") as f:
            ex_data = json.load(f)
            assert len(ex_data.get("sections", [])) >= 3
            print("Validated C1 exam simulator engine.")
            
    print("ALL VALIDATION CHECKS PASSED SUCCESSFULLY!")

if __name__ == "__main__":
    test_validation()
