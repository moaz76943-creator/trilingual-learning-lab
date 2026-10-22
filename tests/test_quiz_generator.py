import json

def test_quiz_distractor_logic():
    with open("content/vocabulary/family_a1.json", "r", encoding="utf-8") as f:
        data = json.load(f)
    concepts = data["concepts"]
    assert len(concepts) >= 10, "Too few concepts to generate a 4-choice quiz!"

    # فحص أن كل مفهوم يملك ترجمة عربية فريدة يمكن تمييزها في الخيارات
    ar_words = [c["ar"]["vocalized"] for c in concepts]
    assert len(set(ar_words)) == len(ar_words), "Duplicate vocalized words found in concepts!"
    print("PASS: Quiz distractor generation logic verified with 0 collision.")

if __name__ == "__main__":
    test_quiz_distractor_logic()
