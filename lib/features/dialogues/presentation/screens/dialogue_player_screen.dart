import 'package:flutter/material.dart';
import '../../../../data/adapters/content_schema_adapter.dart';
import '../../domain/services/dialogue_turn_orchestrator.dart';
import '../controllers/dialogue_player_controller.dart';

/// Full interactive dialogue player screen for trilingual historical conversations.
class DialoguePlayerScreen extends StatefulWidget {
  final DialoguePlayerController controller;

  const DialoguePlayerScreen({
    super.key,
    required this.controller,
  });

  @override
  State<DialoguePlayerScreen> createState() => _DialoguePlayerScreenState();
}

class _DialoguePlayerScreenState extends State<DialoguePlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final ctrl = widget.controller;
        final dialogue = ctrl.dialogue;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: Text(
              dialogue.title.ar,
              style: const TextStyle(fontFamily: 'Amiri', fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFF0F172A),
            foregroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'إِعَادَةُ البَدْءِ / Neustart',
                onPressed: ctrl.stop,
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Mode Selector Bar
                _buildModeSelector(ctrl),
                // Progress Bar
                LinearProgressIndicator(
                  value: ctrl.progressFraction,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF0D9488)),
                  minHeight: 4,
                ),
                // Conversation Turns List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    itemCount: dialogue.turns.length,
                    itemBuilder: (context, index) {
                      final turn = dialogue.turns[index];
                      final isCurrent = index == ctrl.currentTurnIndex;
                      final isUserRole = ctrl.mode == DialogueMode.rolePlay &&
                          (turn.speaker.ar == ctrl.userRoleSpeaker ||
                           turn.speaker.de == ctrl.userRoleSpeaker);

                      return _buildTurnBubble(
                        turn: turn,
                        index: index,
                        isCurrent: isCurrent,
                        isUserRole: isUserRole,
                        ctrl: ctrl,
                      );
                    },
                  ),
                ),
                // Bottom Playback Controls
                _buildControlBar(ctrl),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModeSelector(DialoguePlayerController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChoiceChip(
            label: const Text('دِرَاسَةٌ (Study)'),
            selected: ctrl.mode == DialogueMode.study,
            onSelected: (_) => ctrl.setMode(DialogueMode.study),
          ),
          ChoiceChip(
            label: const Text('تِلْقَائِيٌّ (Auto)'),
            selected: ctrl.mode == DialogueMode.autoPlay,
            onSelected: (_) => ctrl.setMode(DialogueMode.autoPlay),
          ),
          ChoiceChip(
            label: const Text('تَبَادُلُ الأَدْوَارِ (Role)'),
            selected: ctrl.mode == DialogueMode.rolePlay,
            onSelected: (_) => _showRoleDialog(ctrl),
          ),
        ],
      ),
    );
  }

  void _showRoleDialog(DialoguePlayerController ctrl) {
    final speakers = ctrl.dialogue.turns.map((t) => t.speaker.ar).toSet().toList();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('اخْتَرْ دَوْرَكَ فِي الحِوَارِ', textAlign: TextAlign.right),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: speakers.map((speaker) {
            return ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF0D9488)),
              title: Text(speaker, textAlign: TextAlign.right),
              onTap: () {
                Navigator.pop(ctx);
                ctrl.setMode(DialogueMode.rolePlay, userRoleSpeaker: speaker);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTurnBubble({
    required CanonicalDialogueTurn turn,
    required int index,
    required bool isCurrent,
    required bool isUserRole,
    required DialoguePlayerController ctrl,
  }) {
    final isRevealed = !isUserRole || (index != ctrl.currentTurnIndex || (ctrl.currentTurnState?.isRevealed ?? true));

    return GestureDetector(
      onTap: () => ctrl.jumpToTurn(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFFF0FDFA) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCurrent ? const Color(0xFF0D9488) : const Color(0xFFE2E8F0),
            width: isCurrent ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Speaker Header
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: const Color(0xFF0D9488),
                  child: Text(
                    turn.speaker.ar.isNotEmpty ? turn.speaker.ar[0] : '?',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  turn.speaker.ar,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                if (isUserRole) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('دَوْرُكَ (You)', style: TextStyle(fontSize: 10, color: Color(0xFF92400E))),
                  ),
                ],
                const Spacer(),
                Text(
                  '${index + 1}/${ctrl.totalTurns}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Speech Text
            if (!isRevealed) ...[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD97706),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.visibility),
                label: const Text('اكْشِفْ عِبَارَتَكَ / Zeile aufdecken'),
                onPressed: ctrl.toggleReveal,
              ),
            ] else ...[
              // Arabic Line
              Text(
                turn.speech.ar,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Amiri',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 6),
              // German Line
              Text(
                turn.speech.de,
                style: const TextStyle(fontSize: 14, color: Color(0xFF334155)),
              ),
              const SizedBox(height: 4),
              // English Line
              Text(
                turn.speech.en,
                style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildControlBar(DialoguePlayerController ctrl) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous, size: 28),
            onPressed: ctrl.currentTurnIndex > 0 ? ctrl.previousTurn : null,
          ),
          FloatingActionButton.small(
            backgroundColor: const Color(0xFF0D9488),
            foregroundColor: Colors.white,
            onPressed: ctrl.togglePlayPause,
            child: Icon(
              ctrl.playbackState == DialoguePlaybackState.playing
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.skip_next, size: 28),
            onPressed: ctrl.currentTurnIndex < ctrl.totalTurns - 1 ? ctrl.nextTurn : null,
          ),
        ],
      ),
    );
  }
}
