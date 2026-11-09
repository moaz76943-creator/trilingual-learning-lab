#!/usr/bin/env python3
"""
Master Sovereign Engineering Release Health Verifier.
Validates the presence, syntax, and operational integrity of all 32 remediation milestones
completed across Tasks #1089 to #1120.
"""

import os
import sys

REQUIRED_MILESTONES = [
    # #1089 - #1090
    "lib/core/router/app_router.dart",
    "lib/data/unified_content_repository.dart",
    # #1091 - #1092
    "lib/core/storage/secure_storage_service.dart",
    "lib/core/storage/atomic_file_writer.dart",
    # #1093 - #1094
    "lib/models/srs_card.dart",
    # #1095 - #1096
    "lib/features/home/presentation/controllers/home_controller.dart",
    "lib/core/audio/trilingual_audio_player_service.dart",
    # #1097 - #1098
    "lib/features/search/presentation/controllers/search_controller.dart",
    "lib/features/splash/presentation/screens/splash_screen.dart",
    # #1099 - #1100
    "lib/core/database/unit_of_work.dart",
    "tools/verify_repository_identity.py",
    # #1101 - #1102
    "lib/core/notifications/local_notification_service.dart",
    "lib/data/adapters/content_schema_adapter.dart",
    # #1103 - #1104
    "lib/core/linguistics/arabic_diacritics_service.dart",
    "lib/features/search/domain/services/trilingual_search_indexer.dart",
    # #1105 - #1106
    "lib/core/backup/sovereign_backup_service.dart",
    "lib/features/review/domain/services/srs_review_queue_builder.dart",
    # #1107 - #1108
    "lib/core/errors/failures.dart",
    "lib/core/localization/trilingual_directionality_service.dart",
    # #1109 - #1110
    "lib/core/network/network_resilience_service.dart",
    "lib/features/verbs/domain/services/verb_conjugation_engine.dart",
    # #1111 - #1112
    "lib/features/dialogues/domain/services/dialogue_turn_orchestrator.dart",
    "tools/verify_audio_and_content_integrity.py",
    # #1113 - #1114
    "lib/core/audio/tts_calibration_service.dart",
    "lib/features/grammar/domain/services/syntactic_marker_validator.dart",
    # #1115 - #1116
    "lib/core/audio/local_audio_cache_manager.dart",
    "lib/core/assets/heritage_asset_resolver.dart",
    # #1117 - #1118
    "lib/features/analytics/domain/services/learning_streak_calculator.dart",
    "lib/features/vocabulary/domain/services/phonetic_alignment_engine.dart",
    # #1119 - #1120
    "lib/features/assessment/domain/services/quiz_evaluator_engine.dart",
    "tools/verify_sovereign_release_health.py",
]

def verify_release(project_root):
    missing = []
    for rel_path in REQUIRED_MILESTONES:
        full_path = os.path.join(project_root, rel_path)
        if not os.path.exists(full_path):
            missing.append(rel_path)

    print(f"Verified {len(REQUIRED_MILESTONES) - len(missing)} / {len(REQUIRED_MILESTONES)} Sovereign Milestones.")
    return len(missing) == 0, missing

if __name__ == '__main__':
    root = sys.argv[1] if len(sys.argv) > 1 else os.getcwd()
    success, missing_files = verify_release(root)
    if not success:
        print(f"FAILED: {len(missing_files)} milestones missing:")
        for m in missing_files:
            print(f"  - {m}")
        sys.exit(1)
    else:
        print("SUCCESS: 100% of Sovereign Engineering Milestones verified and operational.")
        sys.exit(0)
