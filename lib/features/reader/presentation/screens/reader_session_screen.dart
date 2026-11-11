import 'package:flutter/material.dart';
import '../controllers/reader_session_controller.dart';

/// Full interactive trilingual synchronized reading studio screen.
class ReaderSessionScreen extends StatefulWidget {
  final ReaderSessionController controller;

  const ReaderSessionScreen({
    super.key,
    required this.controller,
  });

  @override
  State<ReaderSessionScreen> createState() => _ReaderSessionScreenState();
}

class _ReaderSessionScreenState extends State<ReaderSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final themeColors = _resolveTheme(ctrl.themeMode);

        return Scaffold(
          backgroundColor: themeColors.background,
          appBar: AppBar(
            title: Text(
              ctrl.titleAr,
              style: const TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold),
            ),
            backgroundColor: themeColors.appBar,
            foregroundColor: themeColors.appBarForeground,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.format_size),
                tooltip: 'حَجْمُ الخَطِّ',
                onPressed: () => _showFontScaleDialog(context, ctrl),
              ),
              IconButton(
                icon: const Icon(Icons.palette_outlined),
                tooltip: 'المَظْهَرُ (Theme)',
                onPressed: () => _showThemeDialog(context, ctrl),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Progress Bar
                LinearProgressIndicator(
                  value: ctrl.readingProgressPercentage / 100.0,
                  backgroundColor: themeColors.cardBorder.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF0D9488)),
                  minHeight: 4,
                ),
                // Main Reader Sentence Stream
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(18.0),
                    itemCount: ctrl.sentences.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final chunk = ctrl.sentences[index];
                      final isActive = index == ctrl.activeSentenceIndex;

                      return _buildSentenceCard(chunk, isActive, ctrl, themeColors);
                    },
                  ),
                ),
                // Gloss Popup Bottom Card (If active)
                if (ctrl.activeWordGloss != null)
                  _buildGlossCard(ctrl.activeWordGloss!, ctrl, themeColors),
                // Floating Audio Narration Bar
                _buildNarrationBar(ctrl, themeColors),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSentenceCard(
    ReaderSentenceChunk chunk,
    bool isActive,
    ReaderSessionController ctrl,
    _ReaderColors theme,
  ) {
    return InkWell(
      onTap: () => ctrl.selectSentence(chunk.index),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isActive ? theme.activeCardBackground : theme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? const Color(0xFF0D9488) : theme.cardBorder,
            width: isActive ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Arabic Vocalized Text with word tap
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 6.0,
              runSpacing: 4.0,
              textDirection: TextDirection.rtl,
              children: chunk.textAr.split(' ').map((word) {
                return InkWell(
                  onTap: () => ctrl.lookupWordGloss(word, 'ar'),
                  borderRadius: BorderRadius.circular(6),
                  child: Text(
                    word,
                    style: TextStyle(
                      fontSize: 22 * ctrl.fontScale,
                      fontFamily: 'Amiri',
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                      color: theme.primaryText,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // German Translation Line
            Text(
              chunk.textDe,
              style: TextStyle(
                fontSize: 14 * ctrl.fontScale,
                fontWeight: FontWeight.w500,
                color: theme.secondaryText,
              ),
            ),
            const SizedBox(height: 4),
            // English Translation Line
            Text(
              chunk.textEn,
              style: TextStyle(
                fontSize: 13 * ctrl.fontScale,
                color: theme.tertiaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlossCard(WordGlossData gloss, ReaderSessionController ctrl, _ReaderColors theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        border: const Border(top: BorderSide(color: Color(0xFFFDE68A), width: 1.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      gloss.tappedWord,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Amiri', color: Color(0xFF92400E)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '/${gloss.ipaPhonetics}/',
                      style: const TextStyle(fontSize: 12, fontFamily: 'monospace', color: Color(0xFF0D9488)),
                    ),
                  ],
                ),
                Text(
                  '${gloss.translationDe} • ${gloss.translationEn}',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF78350F)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20, color: Color(0xFF92400E)),
            onPressed: ctrl.clearGloss,
          ),
        ],
      ),
    );
  }

  Widget _buildNarrationBar(ReaderSessionController ctrl, _ReaderColors theme) {
    return Container(
      color: theme.cardBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: ctrl.previousSentence,
          ),
          FloatingActionButton.small(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            onPressed: ctrl.toggleNarration,
            child: Icon(ctrl.isNarrationPlaying ? Icons.pause : Icons.play_arrow),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: ctrl.nextSentence,
          ),
        ],
      ),
    );
  }

  void _showFontScaleDialog(BuildContext context, ReaderSessionController ctrl) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حَجْمُ خَطِّ القِرَاءَةِ', textAlign: TextAlign.right),
        content: StatefulBuilder(
          builder: (context, setModalState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${(ctrl.fontScale * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Slider(
                value: ctrl.fontScale,
                min: 0.8,
                max: 1.5,
                divisions: 7,
                onChanged: (v) {
                  setModalState(() {});
                  ctrl.setFontScale(v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, ReaderSessionController ctrl) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اخْتَرْ مَظْهَرَ القِرَاءَةِ', textAlign: TextAlign.right),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.auto_stories, color: Color(0xFFB45309)),
              title: const Text('وَرَقُ الآهَارِ المَرْخُومُ (Parchment)'),
              onTap: () {
                ctrl.setThemeMode(ReaderThemeMode.parchment);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_2, color: Color(0xFF1E293B)),
              title: const Text('اللَّيْلُ الدَّاجِي (Dark Slate)'),
              onTap: () {
                ctrl.setThemeMode(ReaderThemeMode.darkSlate);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_5, color: Color(0xFF64748B)),
              title: const Text('العَاجُ الصَّافِي (Clean White)'),
              onTap: () {
                ctrl.setThemeMode(ReaderThemeMode.cleanWhite);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  _ReaderColors _resolveTheme(ReaderThemeMode mode) {
    switch (mode) {
      case ReaderThemeMode.parchment:
        return const _ReaderColors(
          background: Color(0xFFFDFBF7),
          cardBackground: Colors.white,
          activeCardBackground: Color(0xFFF0FDFA),
          cardBorder: Color(0xFFE2E8F0),
          appBar: Color(0xFF2B2621),
          appBarForeground: Colors.white,
          primaryText: Color(0xFF0F172A),
          secondaryText: Color(0xFF334155),
          tertiaryText: Color(0xFF64748B),
        );
      case ReaderThemeMode.darkSlate:
        return const _ReaderColors(
          background: Color(0xFF0F172A),
          cardBackground: Color(0xFF1E293B),
          activeCardBackground: Color(0xFF134E4A),
          cardBorder: Color(0xFF334155),
          appBar: Color(0xFF020617),
          appBarForeground: Colors.white,
          primaryText: Color(0xFFF8FAFC),
          secondaryText: Color(0xFFCBD5E1),
          tertiaryText: Color(0xFF94A3B8),
        );
      case ReaderThemeMode.cleanWhite:
        return const _ReaderColors(
          background: Color(0xFFF8FAFC),
          cardBackground: Colors.white,
          activeCardBackground: Color(0xFFF0FDFA),
          cardBorder: Color(0xFFCBD5E1),
          appBar: Color(0xFF0F172A),
          appBarForeground: Colors.white,
          primaryText: Color(0xFF0F172A),
          secondaryText: Color(0xFF334155),
          tertiaryText: Color(0xFF64748B),
        );
    }
  }
}

class _ReaderColors {
  final Color background;
  final Color cardBackground;
  final Color activeCardBackground;
  final Color cardBorder;
  final Color appBar;
  final Color appBarForeground;
  final Color primaryText;
  final Color secondaryText;
  final Color tertiaryText;

  const _ReaderColors({
    required this.background,
    required this.cardBackground,
    required this.activeCardBackground,
    required this.cardBorder,
    required this.appBar,
    required this.appBarForeground,
    required this.primaryText,
    required this.secondaryText,
    required this.tertiaryText,
  });
}
