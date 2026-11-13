import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../controllers/pragmatic_roleplay_controller.dart';

/// Screen presenting the Interactive Trilingual Pragmatic Dialogue Simulator
class PragmaticRoleplayScreen extends StatefulWidget {
  final PragmaticRoleplayController? controller;

  const PragmaticRoleplayScreen({super.key, this.controller});

  @override
  State<PragmaticRoleplayScreen> createState() => _PragmaticRoleplayScreenState();
}

class _PragmaticRoleplayScreenState extends State<PragmaticRoleplayScreen> {
  late final PragmaticRoleplayController _controller;
  final TextEditingController _textControllerAr = TextEditingController();
  final TextEditingController _textControllerDe = TextEditingController();
  final TextEditingController _textControllerEn = TextEditingController();

  SpeechActType _selectedSpeechAct = SpeechActType.assertion;
  PragmaticRegister _selectedRegister = PragmaticRegister.formalAcademic;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? PragmaticRoleplayController();
    _loadSampleTurn();
  }

  void _loadSampleTurn() {
    _textControllerAr.text = 'اسْتَعْمَلَ ابْنُ الهَيْثَمِ أُسْطُوَانَةً زُجَاجِيَّةً مَمْلُوءَةً بِالمَاءِ لِتَحْدِيدِ مَسَارِ الشُّعَاعِ المُنْكَسِرِ.';
    _textControllerDe.text = 'Alhazen verwendete einen wassergefüllten Glaszylinder, um den Pfad des gebrochenen Strahls exakt zu messen.';
    _textControllerEn.text = 'Ibn al-Haytham utilized a water-filled glass cylinder to determine the path of the refracted ray with empirical precision.';
  }

  @override
  void dispose() {
    _textControllerAr.dispose();
    _textControllerDe.dispose();
    _textControllerEn.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مُحَاكِي المُحَادَثَاتِ التَّدَاوُلِيَّةِ التَّفَاعُلِيِّ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Trilingual Pragmatic Roleplay & Speech Act Simulator',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'إِعَادَةُ الضَّبْطِ',
            onPressed: _controller.reset,
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final state = _controller.state;
          final scenario = state.activeScenario;
          final overall = state.overallCompetencyIndex;

          return Column(
            children: [
              _buildScenarioSelector(state),

              // Visual Dialogue Stage Canvas (Avatars & Speech Act Badges)
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A), // Dark stage slate
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade700, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CustomPaint(
                      painter: DialogueStagePainter(state: state),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ),

              // KPI / Pragmatic Competency Readout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.amber.withOpacity(0.4)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMetric(
                          labelAr: 'المُلاءَمَةُ التَّدَاوُلِيَّةُ',
                          labelEn: 'Pragmatic Fit',
                          value: '${state.userPragmaticFitScore.toStringAsFixed(1)}%',
                          color: state.userPragmaticFitScore > 85 ? Colors.greenAccent : Colors.orangeAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الطَّلاقَةُ اللُّغَوِيَّةُ',
                          labelEn: 'Fluency',
                          value: '${state.userFluencyScore.toStringAsFixed(0)}%',
                          color: Colors.cyanAccent,
                        ),
                        _buildMetric(
                          labelAr: 'الثَّرَاءُ المُعْجَمِيُّ',
                          labelEn: 'Lexical Richness',
                          value: '${state.lexicalRichnessScore.toStringAsFixed(0)}%',
                          color: Colors.amberAccent,
                        ),
                        _buildMetric(
                          labelAr: 'مُؤَشِّرُ الكَفَايَةِ العَامُّ',
                          labelEn: 'Overall Index',
                          value: '${overall.toStringAsFixed(1)}%',
                          color: Colors.lightGreenAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Interactive Speech Turn Entry & Chat History
              Expanded(
                flex: 5,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  children: [
                    // Dialogue Turns History List
                    ...state.conversationHistory.map((turn) {
                      return Align(
                        alignment: turn.isUser ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
                          decoration: BoxDecoration(
                            color: turn.isUser
                                ? const Color(0xFF065F46).withOpacity(0.4)
                                : const Color(0xFF1E3A8A).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: turn.isUser ? Colors.greenAccent.shade400 : Colors.lightBlueAccent,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    turn.speakerNameAr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: turn.isUser ? Colors.greenAccent : Colors.lightBlueAccent,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      turn.speechAct.nameAr.split(' ').first,
                                      style: const TextStyle(fontSize: 9, color: Colors.amberAccent),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(turn.textAr, style: const TextStyle(fontSize: 13, height: 1.3)),
                              const SizedBox(height: 2),
                              Text(turn.textDe, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                              Text(turn.textEn, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    const Divider(height: 16),

                    // Controls for Speech Act & Formality Register
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<SpeechActType>(
                            decoration: const InputDecoration(
                              labelText: 'فِعْلُ الكَلامِ (Speech Act)',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            value: _selectedSpeechAct,
                            items: SpeechActType.values.map((act) {
                              return DropdownMenuItem(
                                value: act,
                                child: Text(act.nameAr, style: const TextStyle(fontSize: 11)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedSpeechAct = val);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<PragmaticRegister>(
                            decoration: const InputDecoration(
                              labelText: 'حَالَةُ الخِطَابِ (Register)',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            value: _selectedRegister,
                            items: PragmaticRegister.values.map((reg) {
                              return DropdownMenuItem(
                                value: reg,
                                child: Text(reg.nameAr, style: const TextStyle(fontSize: 11)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedRegister = val);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // User Text Input
                    TextField(
                      controller: _textControllerAr,
                      decoration: InputDecoration(
                        labelText: 'رَدُّ المُتَعَلِّمِ (بِالفُصْحَى المُشَكَّلَةِ)',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send, color: Colors.greenAccent),
                          tooltip: 'إِرْسَالُ الرَّدِّ التَّدَاوُلِيِّ',
                          onPressed: () {
                            if (_textControllerAr.text.trim().isNotEmpty) {
                              _controller.submitUserTurn(
                                textAr: _textControllerAr.text.trim(),
                                textDe: _textControllerDe.text.trim(),
                                textEn: _textControllerEn.text.trim(),
                                speechAct: _selectedSpeechAct,
                                register: _selectedRegister,
                              );
                              _textControllerAr.clear();
                              _textControllerDe.clear();
                              _textControllerEn.clear();
                            }
                          },
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScenarioSelector(PragmaticRoleplayState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: DropdownButtonFormField<RoleplayScenario>(
        decoration: const InputDecoration(
          labelText: 'المَوْقِفُ الحِوَارِيُّ التَّفَاعُلِيُّ (Pragmatic Scenario)',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        ),
        value: state.activeScenario,
        items: RoleplayScenario.scenarios.map((scen) {
          return DropdownMenuItem(
            value: scen,
            child: Text(scen.titleAr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) _controller.selectScenario(val);
        },
      ),
    );
  }

  Widget _buildMetric({
    required String labelAr,
    required String labelEn,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(labelAr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        Text(labelEn, style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
        const SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
      ],
    );
  }
}

/// Custom painter rendering the visual dialogue stage with avatars and exchange arrows
class DialogueStagePainter extends CustomPainter {
  final PragmaticRoleplayState state;

  DialogueStagePainter({required this.state});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Background architectural gradient
    final bgRect = Rect.fromLTWH(0, 0, width, height);
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bgRect);
    canvas.drawRect(bgRect, bgPaint);

    // 1. Interlocutor Avatar on Right (Dean / Bookseller)
    final rightAvatarCenter = Offset(width - 55, height * 0.45);
    final rightPaint = Paint()..color = const Color(0xFF1E40AF)..style = PaintingStyle.fill;
    canvas.drawCircle(rightAvatarCenter, 28.0, rightPaint);

    final rightOutline = Paint()
      ..color = Colors.lightBlueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(rightAvatarCenter, 28.0, rightOutline);

    _drawText(canvas, 'المُحَاوِرُ', Offset(rightAvatarCenter.dx - 18, rightAvatarCenter.dy + 34), Colors.lightBlueAccent, 10.0);

    // 2. Learner Avatar on Left (Scholar)
    final leftAvatarCenter = Offset(55, height * 0.45);
    final leftPaint = Paint()..color = const Color(0xFF065F46)..style = PaintingStyle.fill;
    canvas.drawCircle(leftAvatarCenter, 28.0, leftPaint);

    final leftOutline = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(leftAvatarCenter, 28.0, leftOutline);

    _drawText(canvas, 'المُتَعَلِّمُ', Offset(leftAvatarCenter.dx - 18, leftAvatarCenter.dy + 34), Colors.greenAccent, 10.0);

    // 3. Central Speech Exchange Waveform
    final midX = width * 0.5;
    final wavePaint = Paint()
      ..color = Colors.amber.withOpacity(0.7)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final wavePath = Path();
    wavePath.moveTo(leftAvatarCenter.dx + 35, height * 0.45);
    for (double x = leftAvatarCenter.dx + 35; x <= rightAvatarCenter.dx - 35; x += 10) {
      final y = (height * 0.45) + math.sin((x - leftAvatarCenter.dx) * 0.08) * 12;
      wavePath.lineTo(x, y);
    }
    canvas.drawPath(wavePath, wavePaint);

    // Scenario Title Tag at top
    _drawText(canvas, state.activeScenario.titleAr, const Offset(16, 16), Colors.amberAccent, 11.0);
    _drawText(canvas, 'حَالَةُ الخِطَابِ المَطْلُوبَةُ: ${state.activeScenario.expectedRegister.nameAr}', const Offset(16, 32), Colors.white70, 9.0);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Color color, double fontSize) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.rtl,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant DialogueStagePainter oldDelegate) {
    return oldDelegate.state != state;
  }
}
