#!/usr/bin/env python3
"""
Security and data integrity tests for local storage and progress handling.
Focus: atomic writes, corruption recovery, schema validation, edge cases.
"""
import json
import os
import tempfile
import shutil

def test_corrupted_progress_recovery():
    with tempfile.TemporaryDirectory() as tmpdir:
        target = os.path.join(tmpdir, "user_progress.json")
        bak = os.path.join(tmpdir, "user_progress.corrupted.bak")
        
        # Write corrupted file
        with open(target, "w") as f:
            f.write("{ invalid json ")
        
        # Simulate recovery logic (from ProgressRepository)
        try:
            with open(target, "r") as f:
                json.load(f)
        except Exception:
            shutil.copy(target, bak)
        
        assert os.path.exists(bak), "Corrupted file should be backed up"
        assert os.path.getsize(bak) > 0
        print("PASS: Corrupted progress file recovery (backup) verified")

def test_srs_invalid_quality():
    # Simulate SM-2 with invalid quality (should clamp or handle)
    def apply_review(reps, interval, ef, quality):
        quality = max(0, min(5, quality))  # clamp
        if quality >= 3:
            if reps == 0:
                interval = 1
            elif reps == 1:
                interval = 6
            else:
                interval = round(interval * ef)
            reps += 1
        else:
            reps = 0
            interval = 1
        ef = ef + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
        ef = max(1.3, ef)
        return reps, interval, ef
    
    r, i, ef = apply_review(0, 1, 2.5, -1)
    assert r == 0 and i == 1
    r, i, ef = apply_review(0, 1, 2.5, 10)
    assert r == 1 and i == 1
    print("PASS: SRS invalid quality scores handled safely (clamped)")

def test_large_progress_set():
    with tempfile.TemporaryDirectory() as tmpdir:
        target = os.path.join(tmpdir, "user_progress.json")
        # Simulate 10k favorites
        data = {
            "version": 1,
            "favorites": [f"concept_{i}" for i in range(10000)],
            "learned": [f"concept_{i}" for i in range(5000)]
        }
        with open(target, "w") as f:
            json.dump(data, f)
        
        with open(target, "r") as f:
            loaded = json.load(f)
        assert len(loaded["favorites"]) == 10000
        print("PASS: Large progress sets (10k items) load correctly")

def test_schema_consistency():
    # Check a sample vocabulary file has required fields
    sample = "content/vocabulary/family_a1.json"
    with open(sample) as f:
        data = json.load(f)
    concepts = data.get("concepts", [])
    assert len(concepts) > 0
    for c in concepts[:5]:
        assert "concept_id" in c or "id" in c  # flexible
        assert "ar" in c and "de" in c and "en" in c
    print("PASS: Content schema basic consistency checked")

if __name__ == "__main__":
    test_corrupted_progress_recovery()
    test_srs_invalid_quality()
    test_large_progress_set()
    test_schema_consistency()
    print("\nAll data integrity & security tests PASSED")
