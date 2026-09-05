import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class AiQuizScreen extends StatefulWidget {
  const AiQuizScreen({super.key});

  @override
  State<AiQuizScreen> createState() => _AiQuizScreenState();
}

class _AiQuizScreenState extends State<AiQuizScreen> {
  bool _isQuizActive = false;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  int _score = 0;
  int _secondsRemaining = 45;
  Timer? _timer;
  bool _showResult = false;
  String _selectedSubject = 'Science (Physics)';

  final List<Map<String, dynamic>> _quizQuestions = [
    {
      'question': 'Which of the following mirrors is used by dentists to see an enlarged image of teeth?',
      'options': ['Convex Mirror', 'Concave Mirror', 'Plane Mirror', 'Cylindrical Mirror'],
      'correct': 1,
      'explanation': 'Concave mirrors produce a magnified, erect virtual image when the object is placed between the pole and focus.',
      'unit': 'Unit 10: Light - Reflection and Refraction',
    },
    {
      'question': 'What is the SI unit of Electric Potential Difference (Voltage)?',
      'options': ['Ampere (A)', 'Ohm (Ω)', 'Volt (V)', 'Watt (W)'],
      'correct': 2,
      'explanation': 'Volt (V) is the SI unit of electric potential difference, named in honour of Alessandro Volta.',
      'unit': 'Unit 12: Electricity',
    },
    {
      'question': 'The process of splitting of white light into its seven constituent colors is called:',
      'options': ['Dispersion', 'Refraction', 'Total Internal Reflection', 'Scattering'],
      'correct': 0,
      'explanation': 'Dispersion occurs because different wavelengths of light bend by different angles when passing through a prism.',
      'unit': 'Unit 11: Human Eye and Colourful World',
    },
    {
      'question': 'Commercial unit of electrical energy (1 kWh) is equal to how many Joules?',
      'options': ['3.6 × 10⁵ J', '3.6 × 10⁶ J', '3600 J', '3.6 × 10⁴ J'],
      'correct': 1,
      'explanation': '1 kWh = 1000 W × 3600 s = 3.6 × 10⁶ Joules (3.6 MegaJoules).',
      'unit': 'Unit 12: Electricity',
    },
    {
      'question': 'According to Fleming’s Left-Hand Rule, the thumb points in the direction of:',
      'options': ['Magnetic Field', 'Electric Current', 'Force / Motion of Conductor', 'Induced Current'],
      'correct': 2,
      'explanation': 'In Fleming’s Left-Hand Rule: Forefinger = Field, Middle finger = Current, Thumb = Force/Motion.',
      'unit': 'Unit 13: Magnetic Effects of Electric Current',
    },
  ];

  void _startQuiz() {
    setState(() {
      _isQuizActive = true;
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null;
      _score = 0;
      _showResult = false;
      _secondsRemaining = 45;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _nextQuestion();
      }
    });
  }

  void _selectOption(int index) {
    if (_selectedOptionIndex != null) return;
    setState(() {
      _selectedOptionIndex = index;
      if (index == _quizQuestions[_currentQuestionIndex]['correct']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _secondsRemaining = 45;
      });
    } else {
      _timer?.cancel();
      setState(() {
        _isQuizActive = false;
        _showResult = true;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    if (_showResult) {
      return _buildResultSummary(context, primaryColor);
    }

    if (_isQuizActive) {
      return _buildActiveQuizView(context, primaryColor);
    }

    return _buildQuizLobby(context, primaryColor);
  }

  // 1. Quiz Lobby & Subject Selection
  Widget _buildQuizLobby(BuildContext context, Color primaryColor) {
    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 780,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFF0984E3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.bolt, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text('AI ADAPTIVE ARENA', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.stars, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text('Earn +50 XP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Daily AI Knowledge Quiz',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Test your concepts with AI-curated chapter MCQs. Instant solution explanations after each question.',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, height: 1.4),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton.icon(
                    onPressed: _startQuiz,
                    icon: const Icon(Icons.play_arrow, size: 20),
                    label: const Text('Start 5-Minute Quiz Now', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6C5CE7),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Subject Selection
            const Text('Select Quiz Subject', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Science (Physics)',
                  'Mathematics',
                  'Chemistry',
                  'Biology',
                  'Computer Science',
                  'Social Science',
                ].map((subj) {
                  final isSelected = _selectedSubject == subj;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: isSelected,
                      label: Text(subj),
                      onSelected: (val) => setState(() => _selectedSubject = subj),
                      selectedColor: primaryColor.withValues(alpha: 0.15),
                      labelStyle: TextStyle(
                        color: isSelected ? primaryColor : const Color(0xFF64748B),
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Past Quiz Badges & Leaderboard preview
            const Text('Your Quiz Performance & Streaks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildLobbyBadgeCard(
                    '🔥 4 Day Streak',
                    'Daily Practice Active',
                    const Color(0xFFE17055),
                    Icons.local_fire_department,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildLobbyBadgeCard(
                    '⭐ 88% Accuracy',
                    'Top 5% in Class 10',
                    const Color(0xFF00B894),
                    Icons.military_tech,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLobbyBadgeCard(String title, String subtitle, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: color)),
                Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Active Quiz Player
  Widget _buildActiveQuizView(BuildContext context, Color primaryColor) {
    final currentQ = _quizQuestions[_currentQuestionIndex];
    final options = currentQ['options'] as List<String>;
    final correctIdx = currentQ['correct'] as int;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 720,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar: Progress & Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _secondsRemaining <= 10 ? const Color(0xFFFEE2E8) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 14, color: _secondsRemaining <= 10 ? Colors.red : Colors.grey[700]),
                      const SizedBox(width: 4),
                      Text(
                        '${_secondsRemaining}s',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: _secondsRemaining <= 10 ? Colors.red : Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Linear Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _quizQuestions.length,
                minHeight: 6,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00CEC9)),
              ),
            ),
            const SizedBox(height: 16),

            // Unit Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentQ['unit'],
                style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11),
              ),
            ),
            const SizedBox(height: 12),

            // Question Text
            Text(
              currentQ['question'],
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, height: 1.35, letterSpacing: -0.3),
            ),
            const SizedBox(height: 20),

            // Option Tiles
            ...List.generate(options.length, (idx) {
              final isSelected = _selectedOptionIndex == idx;
              final isAnswered = _selectedOptionIndex != null;
              final isCorrect = idx == correctIdx;

              Color borderColor = const Color(0xFFE2E8F0);
              Color bgColor = Colors.white;
              Color textColor = const Color(0xFF2D3436);

              if (isAnswered) {
                if (isCorrect) {
                  borderColor = const Color(0xFF00B894);
                  bgColor = const Color(0xFFDCFCE7);
                  textColor = const Color(0xFF15803D);
                } else if (isSelected && !isCorrect) {
                  borderColor = const Color(0xFFD63031);
                  bgColor = const Color(0xFFFEE2E2);
                  textColor = const Color(0xFFB91C1C);
                }
              } else if (isSelected) {
                borderColor = primaryColor;
                bgColor = primaryColor.withValues(alpha: 0.08);
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _selectOption(idx),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isAnswered && isCorrect
                                ? const Color(0xFF00B894)
                                : isAnswered && isSelected && !isCorrect
                                    ? const Color(0xFFD63031)
                                    : const Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              String.fromCharCode(65 + idx),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: isAnswered && (isCorrect || isSelected) ? Colors.white : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            options[idx],
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: textColor),
                          ),
                        ),
                        if (isAnswered && isCorrect) const Icon(Icons.check_circle, color: Color(0xFF00B894), size: 22),
                        if (isAnswered && isSelected && !isCorrect) const Icon(Icons.cancel, color: Color(0xFFD63031), size: 22),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // AI Explanation Card if Answered
            if (_selectedOptionIndex != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb, color: Color(0xFFF39C12), size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AI Concept Explanation', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(currentQ['explanation'], style: TextStyle(color: Colors.grey[700], fontSize: 12, height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    _currentQuestionIndex == _quizQuestions.length - 1 ? 'Finish & View Score' : 'Next Question →',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 3. Result Summary Card
  Widget _buildResultSummary(BuildContext context, Color primaryColor) {
    final percentage = ((_score / _quizQuestions.length) * 100).toInt();

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 600,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF00B894).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.emoji_events, color: Color(0xFF00B894), size: 50),
            ),
            const SizedBox(height: 16),
            const Text('Quiz Completed! 🎉', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
            const SizedBox(height: 4),
            Text('Great effort! You scored $_score out of ${_quizQuestions.length}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const SizedBox(height: 20),

            // Score Breakdown Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryStat('Score', '$_score / ${_quizQuestions.length}', const Color(0xFF0984E3)),
                  _buildSummaryStat('Accuracy', '$percentage%', const Color(0xFF00B894)),
                  _buildSummaryStat('XP Gained', '+50 XP', const Color(0xFFF39C12)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _showResult = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Take Another Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(String label, String val, Color color) {
    return Column(
      children: [
        Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
      ],
    );
  }
}
