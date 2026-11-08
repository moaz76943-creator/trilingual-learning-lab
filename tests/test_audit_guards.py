#!/usr/bin/env python3
"""Regression guards for the audited Dart entrypoint and content validator."""
from __future__ import annotations

import re
import sys
import tempfile
import unittest
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / 'tests'))


class DartSourceGuards(unittest.TestCase):
    def test_main_uses_defined_di_initializer(self):
        main = (REPO / 'lib/main.dart').read_text(encoding='utf-8')
        di = (REPO / 'lib/core/di/injection_container.dart').read_text(encoding='utf-8')
        self.assertIn('Future<void> initDependencies()', di)
        self.assertIn('await initDependencies();', main)
        self.assertNotIn('AppDI.initialize()', main)

    def test_no_malformed_result_generic_arguments(self):
        invalid = re.compile(r'\bResult(?:\?)?\s*,\s*Failure>')
        bad = [
            str(path.relative_to(REPO))
            for path in (REPO / 'lib').rglob('*.dart')
            if invalid.search(path.read_text(encoding='utf-8'))
        ]
        self.assertEqual([], bad)


class ValidatorGuards(unittest.TestCase):
    def test_invalid_json_produces_error(self):
        from validate_content import audit
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / 'content/categories').mkdir(parents=True)
            (root / 'content/categories/broken.json').write_text('{"bad":,}', encoding='utf-8')
            errors, _warnings, counts = audit(root)
            self.assertGreaterEqual(counts['json_files'], 1)
            self.assertTrue(any('broken.json' in e for e in errors))

    def test_valid_mixed_registry_shapes(self):
        import json
        from validate_content import audit
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / 'assets/svg').mkdir(parents=True)
            (root / 'assets/svg/a.svg').write_text('<svg xmlns="http://www.w3.org/2000/svg"/>', encoding='utf-8')
            (root / 'assets/images_registry.json').write_text(
                json.dumps({'first': 'assets/svg/a.svg', 'second': {'path': 'assets/svg/a.svg'}}), encoding='utf-8')
            errors, _warnings, counts = audit(root)
            self.assertEqual([], errors)
            self.assertEqual(2, counts['registry_entries'])

    def test_missing_registered_asset_produces_error(self):
        import json
        from validate_content import audit
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / 'assets').mkdir()
            (root / 'assets/images_registry.json').write_text(
                json.dumps({'missing': {'path': 'assets/svg/not-found.svg'}}), encoding='utf-8')
            errors, _warnings, _counts = audit(root)
            self.assertTrue(any('not-found.svg' in e for e in errors))


if __name__ == '__main__':
    unittest.main()
