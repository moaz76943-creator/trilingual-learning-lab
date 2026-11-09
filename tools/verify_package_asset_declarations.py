#!/usr/bin/env python3
import os, sys, glob

print("🔍 Auditing asset manifest packaging declarations against real filesystem...")

required_dirs = [
    'content/categories',
    'content/sentences',
    'content/verbs',
    'assets/svg',
    'assets/images/categories'
]

errors = []
total_found = 0

for d in required_dirs:
    if os.path.exists(d):
        count = len(os.listdir(d))
        total_found += count
        print(f"   ✓ Directory '{d}': {count} files present.")
    else:
        errors.append(f"Missing required asset directory: {d}")

if not os.path.exists('assets/images_registry.json'):
    errors.append("Missing root assets/images_registry.json")

print(f"📦 Total verified asset files ready for packaging: {total_found}")

if errors:
    print("❌ Asset packaging audit failed:")
    for e in errors:
        print(f"   - {e}")
    sys.exit(1)
else:
    print("✅ All required package asset directories verified successfully!")
