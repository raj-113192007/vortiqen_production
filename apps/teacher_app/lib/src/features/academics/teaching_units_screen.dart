import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class TeachingUnitModel {
  final String id;
  final String title;
  final String chapterNumber;
  final String term;
  final int plannedPeriods;
  final int completedPeriods;
  final String targetDate;
  final List<SubTopicModel> subTopics;

  const TeachingUnitModel({
    required this.id,
    required this.title,
    required this.chapterNumber,
    required this.term,
    required this.plannedPeriods,
    required this.completedPeriods,
    required this.targetDate,
    required this.subTopics,
  });

  TeachingUnitModel copyWith({
    String? id,
    String? title,
    String? chapterNumber,
    String? term,
    int? plannedPeriods,
    int? completedPeriods,
    String? targetDate,
    List<SubTopicModel>? subTopics,
  }) {
    return TeachingUnitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      term: term ?? this.term,
      plannedPeriods: plannedPeriods ?? this.plannedPeriods,
      completedPeriods: completedPeriods ?? this.completedPeriods,
      targetDate: targetDate ?? this.targetDate,
      subTopics: subTopics ?? this.subTopics,
    );
  }

  double get progress {
    if (subTopics.isEmpty) return 0.0;
    final done = subTopics.where((t) => t.isCompleted).length;
    return done / subTopics.length;
  }

  String get status {
    final p = progress;
    if (p >= 1.0) return 'Completed';
    if (p > 0.0) return 'In Progress';
    return 'Upcoming';
  }
}

class SubTopicModel {
  final String id;
  final String title;
  final int periods;
  final bool isCompleted;

  const SubTopicModel({
    required this.id,
    required this.title,
    required this.periods,
    required this.isCompleted,
  });

  SubTopicModel copyWith({
    String? id,
    String? title,
    int? periods,
    bool? isCompleted,
  }) {
    return SubTopicModel(
      id: id ?? this.id,
      title: title ?? this.title,
      periods: periods ?? this.periods,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TeachingUnitsScreen extends StatefulWidget {
  const TeachingUnitsScreen({super.key});

  @override
  State<TeachingUnitsScreen> createState() => _TeachingUnitsScreenState();
}

class _TeachingUnitsScreenState extends State<TeachingUnitsScreen> {
  String _selectedSubject = 'Class 10-A • Physics';

  final List<String> _subjects = [
    'Class 10-A • Physics',
    'Class 10-A • Mathematics',
    'Class 9-B • Physics',
    'Class 9-B • General Science',
    'Class 11-A • Mechanics',
  ];

  late Map<String, List<TeachingUnitModel>> _curriculumData;

  @override
  void initState() {
    super.initState();
    _curriculumData = {
      'Class 10-A • Physics': [
        TeachingUnitModel(
          id: 'u1',
          chapterNumber: 'Unit 01',
          title: 'Light: Reflection & Refraction',
          term: 'Term 1 / Midterm',
          plannedPeriods: 14,
          completedPeriods: 14,
          targetDate: '15 Aug 2026',
          subTopics: [
            SubTopicModel(id: 't1', title: 'Spherical Mirrors & Ray Diagrams', periods: 3, isCompleted: true),
            SubTopicModel(id: 't2', title: 'Mirror Formula & Magnification Numericals', periods: 4, isCompleted: true),
            SubTopicModel(id: 't3', title: 'Refraction of Light & Snell\'s Law', periods: 3, isCompleted: true),
            SubTopicModel(id: 't4', title: 'Lens Formula & Power of Lens', periods: 4, isCompleted: true),
          ],
        ),
        TeachingUnitModel(
          id: 'u2',
          chapterNumber: 'Unit 02',
          title: 'The Human Eye and Colourful World',
          term: 'Term 1 / Midterm',
          plannedPeriods: 10,
          completedPeriods: 8,
          targetDate: '05 Sep 2026',
          subTopics: [
            SubTopicModel(id: 't5', title: 'Structure & Defects of Vision (Myopia/Hypermetropia)', periods: 3, isCompleted: true),
            SubTopicModel(id: 't6', title: 'Refraction through a Glass Prism', periods: 2, isCompleted: true),
            SubTopicModel(id: 't7', title: 'Dispersion of White Light & Rainbow Formation', periods: 2, isCompleted: true),
            SubTopicModel(id: 't8', title: 'Atmospheric Refraction & Scattering of Light (Tyndall Effect)', periods: 3, isCompleted: false),
          ],
        ),
        TeachingUnitModel(
          id: 'u3',
          chapterNumber: 'Unit 03',
          title: 'Electricity & Electric Circuits',
          term: 'Term 2 / Pre-Boards',
          plannedPeriods: 16,
          completedPeriods: 4,
          targetDate: '10 Oct 2026',
          subTopics: [
            SubTopicModel(id: 't9', title: 'Electric Current, Potential Difference & Ohm\'s Law', periods: 4, isCompleted: true),
            SubTopicModel(id: 't10', title: 'Factors on which Resistance Depends (Resistivity)', periods: 3, isCompleted: false),
            SubTopicModel(id: 't11', title: 'Series and Parallel Resistor Combinations', periods: 4, isCompleted: false),
            SubTopicModel(id: 't12', title: 'Heating Effect of Electric Current & Joule\'s Law', periods: 3, isCompleted: false),
            SubTopicModel(id: 't13', title: 'Electric Power & Commercial Unit of Energy', periods: 2, isCompleted: false),
          ],
        ),
        TeachingUnitModel(
          id: 'u4',
          chapterNumber: 'Unit 04',
          title: 'Magnetic Effects of Electric Current',
          term: 'Term 2 / Pre-Boards',
          plannedPeriods: 12,
          completedPeriods: 0,
          targetDate: '15 Nov 2026',
          subTopics: [
            SubTopicModel(id: 't14', title: 'Magnetic Field & Field Lines around Straight Conductor', periods: 3, isCompleted: false),
            SubTopicModel(id: 't15', title: 'Right-Hand Thumb Rule & Circular Loop Field', periods: 3, isCompleted: false),
            SubTopicModel(id: 't16', title: 'Fleming\'s Left-Hand Rule & Electric Motor Principle', periods: 3, isCompleted: false),
            SubTopicModel(id: 't17', title: 'Electromagnetic Induction & Domestic Electric Circuits', periods: 3, isCompleted: false),
          ],
        ),
      ],
      'Class 10-A • Mathematics': [
        TeachingUnitModel(
          id: 'm1',
          chapterNumber: 'Unit 01',
          title: 'Real Numbers & Fundamental Theorem',
          term: 'Term 1',
          plannedPeriods: 8,
          completedPeriods: 8,
          targetDate: '10 Jul 2026',
          subTopics: [
            SubTopicModel(id: 'mt1', title: 'Fundamental Theorem of Arithmetic', periods: 4, isCompleted: true),
            SubTopicModel(id: 'mt2', title: 'Revisiting Irrational Numbers (√2, √3 proofs)', periods: 4, isCompleted: true),
          ],
        ),
        TeachingUnitModel(
          id: 'm2',
          chapterNumber: 'Unit 02',
          title: 'Polynomials & Quadratic Equations',
          term: 'Term 1',
          plannedPeriods: 14,
          completedPeriods: 11,
          targetDate: '10 Sep 2026',
          subTopics: [
            SubTopicModel(id: 'mt3', title: 'Geometrical Meaning of Zeroes', periods: 3, isCompleted: true),
            SubTopicModel(id: 'mt4', title: 'Relationship between Zeroes & Coefficients', periods: 4, isCompleted: true),
            SubTopicModel(id: 'mt5', title: 'Quadratic Formula & Nature of Roots', periods: 4, isCompleted: true),
            SubTopicModel(id: 'mt6', title: 'Word Problems on Speed, Time & Work', periods: 3, isCompleted: false),
          ],
        ),
      ],
    };
  }

  List<TeachingUnitModel> get _currentUnits => _curriculumData[_selectedSubject] ?? [];

  void _toggleSubTopic(String unitId, String subTopicId) {
    setState(() {
      final list = _curriculumData[_selectedSubject] ?? [];
      final unitIdx = list.indexWhere((u) => u.id == unitId);
      if (unitIdx != -1) {
        final unit = list[unitIdx];
        final updatedTopics = unit.subTopics.map((t) {
          if (t.id == subTopicId) {
            return t.copyWith(isCompleted: !t.isCompleted);
          }
          return t;
        }).toList();

        final doneTopicsCount = updatedTopics.where((t) => t.isCompleted).length;
        final completedPeriodsEstimate = ((doneTopicsCount / (updatedTopics.isEmpty ? 1 : updatedTopics.length)) * unit.plannedPeriods).round();

        list[unitIdx] = unit.copyWith(
          subTopics: updatedTopics,
          completedPeriods: completedPeriodsEstimate,
        );
        _curriculumData[_selectedSubject] = list;
      }
    });
  }

  void _showAddUnitDialog() {
    final titleController = TextEditingController();
    final chapterController = TextEditingController(text: 'Unit 0${_currentUnits.length + 1}');
    final periodsController = TextEditingController(text: '12');
    final termController = TextEditingController(text: 'Term 2 / Pre-Boards');
    final targetDateController = TextEditingController(text: '15 Dec 2026');
    final topicsController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.library_books_rounded, color: Color(0xFF6C5CE7), size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Add New Teaching Unit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: chapterController,
                        decoration: InputDecoration(
                          labelText: 'Unit Code',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Unit Title / Chapter Name',
                          hintText: 'e.g. Sources of Energy',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: periodsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Planned Periods',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: targetDateController,
                        decoration: InputDecoration(
                          labelText: 'Target Completion Date',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: termController,
                  decoration: InputDecoration(
                    labelText: 'Exam Term / Milestone',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: topicsController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Sub-topics (Enter each topic on a new line)',
                    hintText: 'Conventional Sources of Energy\nSolar Energy & Photovoltaic Cells\nNuclear Energy & Safety Hazards',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;

              final topicLines = topicsController.text
                  .split('\n')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .toList();

              final newSubTopics = topicLines.asMap().entries.map((e) {
                return SubTopicModel(
                  id: 't_custom_${DateTime.now().millisecondsSinceEpoch}_${e.key}',
                  title: e.value,
                  periods: 3,
                  isCompleted: false,
                );
              }).toList();

              final newUnit = TeachingUnitModel(
                id: 'u_${DateTime.now().millisecondsSinceEpoch}',
                title: titleController.text.trim(),
                chapterNumber: chapterController.text.trim(),
                term: termController.text.trim(),
                plannedPeriods: int.tryParse(periodsController.text) ?? 10,
                completedPeriods: 0,
                targetDate: targetDateController.text.trim(),
                subTopics: newSubTopics.isNotEmpty
                    ? newSubTopics
                    : [SubTopicModel(id: 't1', title: 'Introduction & Core Concepts', periods: 4, isCompleted: false)],
              );

              setState(() {
                final list = _curriculumData[_selectedSubject] ?? [];
                list.add(newUnit);
                _curriculumData[_selectedSubject] = list;
              });

              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added "${titleController.text}" to Curriculum! 📘'),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Add Unit to Syllabus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final units = _currentUnits;
    int totalTopics = 0;
    int completedTopics = 0;
    int totalPlannedPeriods = 0;
    int totalCompletedPeriods = 0;

    for (var u in units) {
      totalPlannedPeriods += u.plannedPeriods;
      totalCompletedPeriods += u.completedPeriods;
      for (var t in u.subTopics) {
        totalTopics++;
        if (t.isCompleted) completedTopics++;
      }
    }

    final double overallProgress = totalTopics == 0 ? 0 : (completedTopics / totalTopics);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Teaching Units & Syllabus Tracker',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Day-wise Lesson Planner',
            onPressed: () => context.push('/daily-lesson-planner'),
            icon: const Icon(Icons.calendar_month_rounded, color: Color(0xFF6C5CE7)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Switcher & Add Button
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _subjects.contains(_selectedSubject) ? _selectedSubject : _subjects.first,
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6C5CE7)),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                          items: _subjects.map((s) {
                            return DropdownMenuItem<String>(
                              value: s,
                              child: Row(
                                children: [
                                  const Icon(Icons.auto_stories_rounded, color: Color(0xFF6C5CE7), size: 18),
                                  const SizedBox(width: 10),
                                  Text(s),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _selectedSubject = val);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _showAddUnitDialog,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text('Add Unit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C5CE7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // OVERALL SYLLABUS MASTERY HUD BANNER
            FadeSlideEntry(
              delay: const Duration(milliseconds: 100),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF4834D4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'ACADEMIC SESSION 2026-27',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Overall Syllabus Progress',
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$completedTopics of $totalTopics Topics Covered across ${units.length} Units',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${(overallProgress * 100).toInt()}%',
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: overallProgress,
                        minHeight: 8,
                        backgroundColor: Colors.white.withValues(alpha: 0.25),
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF00FFC6)),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3 Micro Metrics Grid
                    Row(
                      children: [
                        _buildMetricPill('Units Planned', '${units.length}', Icons.layers_outlined),
                        const SizedBox(width: 8),
                        _buildMetricPill('Periods Spent', '$totalCompletedPeriods/$totalPlannedPeriods', Icons.access_time_rounded),
                        const SizedBox(width: 8),
                        _buildMetricPill('Velocity', 'On Track ⚡', Icons.speed_rounded),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // SECTION HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Curriculum Units & Sub-topic Checklist',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                ),
                Text(
                  '${units.length} Units Total',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // LIST OF UNITS
            if (units.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                child: const Text('No teaching units defined yet for this subject. Click "Add Unit" to begin!'),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: units.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final unit = units[index];
                  return FadeSlideEntry(
                    delay: Duration(milliseconds: 150 + (index * 60)),
                    child: _buildUnitCard(unit),
                  );
                },
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricPill(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 9, fontWeight: FontWeight.w600)),
                  Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitCard(TeachingUnitModel unit) {
    final double p = unit.progress;
    final isDone = p >= 1.0;
    final inProgress = p > 0.0 && p < 1.0;

    final Color statusColor = isDone
        ? const Color(0xFF10B981)
        : inProgress
            ? const Color(0xFFF39C12)
            : const Color(0xFF64748B);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: inProgress ? const Color(0xFF6C5CE7).withValues(alpha: 0.3) : const Color(0xFFE2E8F0),
          width: inProgress ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: inProgress,
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 18),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  unit.chapterNumber,
                  style: const TextStyle(color: Color(0xFF6C5CE7), fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  unit.title,
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Color(0xFF1E293B)),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  unit.status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 10),
                ),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(p * 100).toInt()}% Covered (${unit.subTopics.where((t) => t.isCompleted).length}/${unit.subTopics.length} Topics)',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                    ),
                    Text(
                      'Target: ${unit.targetDate} • ${unit.completedPeriods}/${unit.plannedPeriods} Periods',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: p,
                    minHeight: 5,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation(statusColor),
                  ),
                ),
              ],
            ),
          ),
          children: [
            const Divider(color: Color(0xFFF1F5F9)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('SUB-TOPICS & PEDAGOGICAL MILESTONES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF94A3B8))),
                InkWell(
                  onTap: () => context.push('/daily-lesson-planner'),
                  child: const Row(
                    children: [
                      Icon(Icons.edit_calendar_rounded, size: 14, color: Color(0xFF6C5CE7)),
                      SizedBox(width: 4),
                      Text('Plan Day-wise Lesson', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...unit.subTopics.map((topic) {
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: topic.isCompleted ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: topic.isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _toggleSubTopic(unit.id, topic.id),
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: topic.isCompleted ? const Color(0xFF10B981) : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: topic.isCompleted ? const Color(0xFF10B981) : const Color(0xFFCBD5E1),
                            width: 1.5,
                          ),
                        ),
                        child: topic.isCompleted
                            ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        topic.title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: topic.isCompleted ? const Color(0xFF166534) : const Color(0xFF1E293B),
                          decoration: topic.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        '~${topic.periods} Periods',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
