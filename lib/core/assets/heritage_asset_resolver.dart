import 'package:flutter/foundation.dart';

/// Service resolving and validating vector SVG assets for historical and scientific themes.
class HeritageAssetResolver {
  static const String baseCategoryAssetPath = 'assets/images/categories';
  static const String defaultHeritageSealAsset = '$baseCategoryAssetPath/default_heritage_seal.svg';

  // Curated registry of known scientific instrument SVG mappings
  static final Map<String, String> _knownInstrumentAssets = {
    'astrolabe': '$baseCategoryAssetPath/astrolabe_brass_gear.svg',
    'clepsydra': '$baseCategoryAssetPath/water_clepsydra_cylinder.svg',
    'sundial': '$baseCategoryAssetPath/scaphe_hemispherical_dial.svg',
    'compass': '$baseCategoryAssetPath/mariners_dry_compass.svg',
    'papermill': '$baseCategoryAssetPath/samarkand_trip_hammer.svg',
    'quadrant': '$baseCategoryAssetPath/sine_quadrant_brass.svg',
    'bookbinding': '$baseCategoryAssetPath/morocco_leather_binding.svg',
    'calligraphy': '$baseCategoryAssetPath/qalamdan_silver_inlaid.svg',
    'waterwheel': '$baseCategoryAssetPath/geared_saqiya_wheel.svg',
  };

  /// Resolves the vector asset path for a category ID or concept slug.
  /// If no direct mapping exists, returns a categorized fallback or the sovereign heritage seal.
  static String resolveCategoryIcon(String categoryIdOrConcept) {
    final clean = categoryIdOrConcept.toLowerCase().trim();

    for (final entry in _knownInstrumentAssets.entries) {
      if (clean.contains(entry.key)) {
        return entry.value;
      }
    }

    // Direct path formatting if category matches standard convention
    if (clean.startsWith('category_') || clean.startsWith('cat_')) {
      final slug = clean.replaceAll('category_', '').replaceAll('cat_', '');
      return '$baseCategoryAssetPath/$slug.svg';
    }

    return defaultHeritageSealAsset;
  }

  /// Verifies that an asset path adheres to SVG vector standards and sovereign directory structure.
  static bool isValidSvgAssetPath(String path) {
    final trimmed = path.trim();
    if (!trimmed.endsWith('.svg')) return false;
    if (!trimmed.startsWith('assets/')) return false;
    return true;
  }

  /// Enforces cultural compliance: checks asset slugs against forbidden categories.
  static bool compliesWithCulturalSovereignty(String assetSlug) {
    final lower = assetSlug.toLowerCase();
    const forbiddenKeywords = ['hebrew', 'israel', 'idol', 'gambling', 'interest_rate'];
    return !forbiddenKeywords.any((kw) => lower.contains(kw));
  }
}
