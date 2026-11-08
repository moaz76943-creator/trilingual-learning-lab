#!/usr/bin/env python3
"""Full JSON parsing and asset registry checks. Never claims linguistic certification."""
from __future__ import annotations

import json
import sys
from collections import Counter
from pathlib import Path, PurePosixPath
from typing import Any

ARABIC_DIACRITICS = set('ًٌٍَُِّْٰ')
ARABIC_LETTERS = set(chr(i) for i in range(0x0621, 0x064B))
IMAGE_TYPES = {'.svg', '.png', '.jpg', '.jpeg', '.webp', '.gif', '.avif'}


def audit(root: Path) -> tuple[list[str], list[str], dict[str, int]]:
    root = root.resolve()
    errors: list[str] = []
    warnings: list[str] = []
    counts: Counter[str] = Counter()

    json_paths = sorted((root / 'content').rglob('*.json'))
    for registry in ('assets/images_registry.json',):
        p = root / registry
        if p.is_file():
            json_paths.append(p)
    documents: dict[Path, Any] = {}

    for path in json_paths:
        counts['json_files'] += 1
        rel = path.relative_to(root)
        try:
            with path.open('r', encoding='utf-8') as stream:
                documents[path] = json.load(stream)
        except (UnicodeError, OSError, json.JSONDecodeError) as exc:
            errors.append(f'{rel}: invalid JSON / UTF-8: {exc}')

    for path, data in documents.items():
        rel = path.relative_to(root)
        rel_posix = rel.as_posix()
        if rel_posix.startswith('content/categories/'):
            counts['category_files'] += 1
            if not isinstance(data, dict):
                errors.append(f'{rel}: expected category object')
                continue
            concepts = data.get('concepts')
            if concepts is None:
                warnings.append(f'{rel}: concepts field not present; schema review required')
            elif not isinstance(concepts, list):
                errors.append(f'{rel}: concepts must be a list')
            else:
                counts['concepts'] += len(concepts)
                for index, concept in enumerate(concepts):
                    if not isinstance(concept, dict):
                        errors.append(f'{rel}: concepts[{index}] must be an object')
                        continue
                    triad = ('arabic', 'german', 'english')
                    if any(k in concept for k in triad):
                        absent = [k for k in triad if not isinstance(concept.get(k), str) or not concept[k].strip()]
                        if absent:
                            errors.append(f'{rel}: concepts[{index}] missing {absent}')
                    ar = concept.get('arabic')
                    if isinstance(ar, str) and any(ch in ARABIC_LETTERS for ch in ar):
                        if not any(ch in ARABIC_DIACRITICS for ch in ar):
                            warnings.append(f'{rel}: concepts[{index}] Arabic text has no diacritics')
        elif rel_posix.startswith('content/sentences/'):
            counts['dialogue_files'] += 1
            if not isinstance(data, dict):
                warnings.append(f'{rel}: non-object sentence format; needs schema review')
                continue
            turns = data.get('turns')
            if isinstance(turns, list):
                counts['dialogue_turns'] += len(turns)
                for index, turn in enumerate(turns):
                    if not isinstance(turn, dict):
                        errors.append(f'{rel}: turns[{index}] must be an object')
                    elif any(k in turn for k in ('ar', 'de', 'en')):
                        missing = [k for k in ('ar', 'de', 'en') if not isinstance(turn.get(k), str) or not turn[k].strip()]
                        if missing:
                            errors.append(f'{rel}: turns[{index}] missing {missing}')
            else:
                warnings.append(f'{rel}: turns not found; verify alternate sentence schema')
        elif rel_posix.startswith('content/verbs/'):
            counts['verb_files'] += 1
            if isinstance(data, list):
                counts['verb_records'] += len(data)
            elif isinstance(data, dict) and isinstance(data.get('verbs'), list):
                counts['verb_records'] += len(data['verbs'])
            else:
                warnings.append(f'{rel}: unrecognized verb schema')

    registries = ('assets/images_registry.json', 'content/assets/images_registry.json')
    for name in registries:
        path = root / name
        if not path.exists():
            warnings.append(f'{name}: registry absent')
            continue
        registry = documents.get(path)
        if registry is None:
            continue  # already reported invalid JSON
        if not isinstance(registry, dict):
            errors.append(f'{name}: registry must be a JSON object')
            continue
        for key, record in registry.items():
            counts['registry_entries'] += 1
            candidate = record if isinstance(record, str) else record.get('path') if isinstance(record, dict) else None
            if not isinstance(candidate, str):
                warnings.append(f'{name}: {key!r} has no recognized path')
                continue
            if PurePosixPath(candidate).suffix.lower() not in IMAGE_TYPES:
                warnings.append(f'{name}: {key!r} has a non-image path; manual schema review')
                continue
            normalized = candidate.replace('\\', '/')
            posix = PurePosixPath(normalized)
            if posix.is_absolute() or '..' in posix.parts or normalized.startswith('~'):
                errors.append(f'{name}: unsafe asset path for {key!r}: {candidate}')
            elif not (root / Path(*posix.parts)).is_file():
                errors.append(f'{name}: missing asset for {key!r}: {candidate}')
    return errors, warnings, dict(counts)


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    errors, warnings, counts = audit(root)
    print('JSON / ASSET AUDIT:', json.dumps(counts, ensure_ascii=False, sort_keys=True))
    for entry in errors[:80]:
        print('ERROR:', entry)
    for entry in warnings[:30]:
        print('WARNING:', entry)
    if len(errors) > 80:
        print(f'... {len(errors) - 80} additional errors (output capped)')
    if len(warnings) > 30:
        print(f'... {len(warnings) - 30} additional warnings (output capped)')
    print(f'RESULT: {len(errors)} errors, {len(warnings)} warnings')
    if errors:
        return 1
    print('Structural validation passed; linguistic correctness is not certified.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
