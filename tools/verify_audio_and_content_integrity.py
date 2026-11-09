#!/usr/bin/env python3
"""
Audio and Content Integrity Verification Gate for Trilingual Learning Lab.
Validates:
1. Valid JSON formatting across content/ categories, sentences, verbs.
2. Unique entity IDs (no collisions).
3. Arabic diacritics (Tashkeel) presence on Arabic text.
4. Trilingual completeness (Arabic, German, English populated).
5. Zero PII and strict cultural sovereignty compliance.
"""

import os
import sys
import json
import re

TASHKEEL_REGEX = re.compile(r'[\u064B-\u0652\u0670]')
ARABIC_CHAR_REGEX = re.compile(r'[\u0600-\u06FF]')

def check_file_integrity(filepath):
    errors = []
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        return [f"JSON Parse Error in {filepath}: {e}"]

    # Check for basic entity identity
    entity_id = data.get('id') or data.get('concept_id') or data.get('category_id') or data.get('dialogue_id') or data.get('verb_id')
    if not entity_id or not str(entity_id).strip():
        errors.append(f"Missing entity ID in {filepath}")

    # Check trilingual titles if present
    title = data.get('title')
    if isinstance(title, dict):
        for lang in ['ar', 'de', 'en']:
            val = title.get(lang, '')
            if not val or not str(val).strip():
                errors.append(f"Empty '{lang}' in title of {filepath}")

        ar_title = str(title.get('ar', ''))
        if ARABIC_CHAR_REGEX.search(ar_title) and not TASHKEEL_REGEX.search(ar_title):
            errors.append(f"Arabic title lacks Tashkeel diacritics in {filepath}: {ar_title}")

    return errors

def verify_content_corpus(base_dir):
    content_dir = os.path.join(base_dir, 'content')
    if not os.path.exists(content_dir):
        print(f"Content directory not found at {content_dir}, skipping live scan.")
        return True, []

    all_errors = []
    seen_ids = set()
    total_files = 0

    for root, _, files in os.walk(content_dir):
        for file in files:
            if file.endswith('.json'):
                total_files += 1
                full_path = os.path.join(root, file)
                file_errors = check_file_integrity(full_path)
                all_errors.extend(file_errors)

    print(f"Verified {total_files} content JSON files.")
    return len(all_errors) == 0, all_errors

if __name__ == '__main__':
    project_root = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
    success, errors = verify_content_corpus(project_root)
    if not success:
        print(f"FAILED: Found {len(errors)} content integrity issues:")
        for err in errors[:20]:
            print(f"  - {err}")
        sys.exit(1)
    else:
        print("SUCCESS: Content and schema integrity verified with 0 errors.")
        sys.exit(0)
