import json
import glob
import sys
import os

def validate_category_file(file_path):
    print(f"Checking: {file_path}")
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    required_top = ["category_id", "category_name", "level", "version", "concepts"]
    for field in required_top:
        assert field in data, f"Missing top-level field: {field}"

    concepts = data["concepts"]
    assert len(concepts) >= 25, f"Expected at least 25 concepts, found {len(concepts)}"

    seen_ids = set()
    valid_articles = {"der", "die", "das"}
    valid_genders = {"m", "f", "n"}

    for idx, c in enumerate(concepts):
        cid = c.get("concept_id")
        assert cid, f"Missing concept_id at index {idx}"
        assert cid not in seen_ids, f"Duplicate concept_id detected: {cid}"
        seen_ids.add(cid)

        # Arabic check
        ar = c.get("ar", {})
        assert ar.get("word") and ar.get("vocalized") and ar.get("example"), f"Incomplete AR data in {cid}"
        assert ar.get("gender") in valid_genders, f"Invalid AR gender in {cid}"

        # German check
        de = c.get("de", {})
        assert de.get("word") and de.get("article") and de.get("example"), f"Incomplete DE data in {cid}"
        assert de["article"].lower() in valid_articles, f"Invalid German article '{de['article']}' in {cid}"

        # English check
        en = c.get("en", {})
        assert en.get("word") and en.get("example"), f"Incomplete EN data in {cid}"

        # Visual Link Check
        assert c.get("image_id"), f"Missing image_id in {cid}"

    print(f"PASS: {len(concepts)} concepts verified successfully in {os.path.basename(file_path)}.")
    return len(concepts)

def main():
    files = glob.glob("content/vocabulary/*.json")
    if not files:
        print("ERROR: No vocabulary files found!")
        sys.exit(1)

    total = 0
    for file_path in files:
        total += validate_category_file(file_path)

    print(f"\nALL CHECKS PASSED: Total {total} concepts validated.")

if __name__ == "__main__":
    main()
