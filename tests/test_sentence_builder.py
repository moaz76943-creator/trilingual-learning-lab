import json

def test_sentences_structure():
    with open("content/grammar/sentences_a1.json", "r", encoding="utf-8") as f:
        data = json.load(f)
    sentences = data.get("sentences", [])
    assert len(sentences) >= 20, f"Expected 20 sentences, found {len(sentences)}"

    for s in sentences:
        assert s["ar"]["full"] and s["de"]["full"] and s["en"]["full"]
        # التحقق من أن الكلمات المقطعة تطابق الجملة الأصلية
        de_reconstructed = " ".join(s["de"]["tokens"]).strip()
        assert de_reconstructed == s["de"]["full"].strip(), f"Mismatch in DE tokens for {s['id']}"

    print(f"PASS: {len(sentences)} sentence builder exercises verified with exact syntactic token fidelity.")

if __name__ == "__main__":
    test_sentences_structure()
