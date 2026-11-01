# Test Gaps Analysis & Priorities for Google Play Quality

## Current Coverage
- Python content validation (schema, assets)
- Simulated atomic write and corruption recovery
- Basic SRS edge cases

## Gaps Identified
1. **No Flutter/Dart unit tests** (test/ directory missing). Critical for ProgressRepository, SRSRepository, SecureStorageService.
2. **No widget/UI tests** for critical flows: category load, favorite/learned toggle, SRS review, search.
3. **No integration tests** (integration_test package) for end-to-end offline flows.
4. **Security**:
   - SecureStorageService is in-memory mock only; no real encryption (e.g. flutter_secure_storage).
   - Progress/SRS files are plain JSON on disk (readable by other apps if storage not app-private).
   - No tests for permission denial (RECORD_AUDIO if used).
   - Atomic write uses delete+rename (not fully atomic; race window).
   - No concurrent access protection.
5. **Data handling**: No migration tests for schema version changes; no large dataset performance tests in Dart.
6. **Google Play**:
   - Privacy policy URL must be live (GitHub Pages not enabled — rejection risk).
   - Data Safety form alignment (currently claims none; verify no analytics/crashlytics).
   - Target SDK, signing, Play Integrity (mentioned in privacy README).
   - Accessibility, stability, content rating.

## New Tests Added (this review)
- tests/test_advanced_data_security.py : crash recovery, input sanitization, empty/null, version handling.

## Next Priority Test Cases
1. Implement and CI-run Flutter unit tests for ProgressRepository (init, toggle, corruption, atomicity).
2. Widget tests for CategoriesScreen and progress toggles.
3. Integration test for full offline learning flow (load → favorite → restart → verify).
4. Replace in-memory SecureStorage with flutter_secure_storage + tests.
5. Add file encryption or ensure app-private storage + tests for leakage.
6. Concurrency/locking tests for repositories.
7. Permission and Play Integrity related tests if features added.
8. Enable GitHub Pages for privacy policy and verify link in app.

## Coverage Improvements
- Added advanced Python security/data tests (all passing).
- Documented Dart test stubs.
- Existing tests remain green.
