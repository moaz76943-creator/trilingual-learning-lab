import json
import os
import tempfile

def test_atomic_persistence():
    with tempfile.TemporaryDirectory() as tmpdir:
        target = os.path.join(tmpdir, "user_progress.json")
        temp = os.path.join(tmpdir, "user_progress.tmp")

        # محاكاة الكتابة الذرية
        data = {
            "version": 1,
            "favorites": ["fam_001_family", "fam_002_father"],
            "learned": ["fam_001_family"]
        }

        with open(temp, "w", encoding="utf-8") as f:
            json.dump(data, f)
        
        os.replace(temp, target)

        assert os.path.exists(target), "Target file missing after atomic replace!"
        assert not os.path.exists(temp), "Temp file should not remain after replace!"

        with open(target, "r", encoding="utf-8") as f:
            loaded = json.load(f)

        assert len(loaded["favorites"]) == 2
        assert len(loaded["learned"]) == 1
        print("PASS: Atomic storage simulation verified successfully.")

if __name__ == "__main__":
    test_atomic_persistence()
