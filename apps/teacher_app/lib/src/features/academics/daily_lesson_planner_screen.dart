import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DailyPeriodLessonPlan {
  final int periodNumber;
  final String timeSlot;
  final String className;
  final String subject;
  final String room;
  final bool isFreePeriod;
  String unitName;
  String topic;
  List<String> objectives;
  List<String> teachingAids;
  String classworkSummary;
  String homeworkAssigned;
  String deliveryStatus; // 'Delivered', 'Partial', 'Rescheduled', 'Draft'
  String reflectionNote;

  DailyPeriodLessonPlan({
    required this.periodNumber,
    required this.timeSlot,
    required this.className,
    required this.subject,
    required this.room,
    this.isFreePeriod = false,
    required this.unitName,
    required this.topic,
    required this.objectives,
    required this.teachingAids,
    required this.classworkSummary,
    required this.homeworkAssigned,
    this.deliveryStatus = 'Draft',
    this.reflectionNote = '',
  });
}

class DailyLessonPlannerScreen extends StatefulWidget {
  const DailyLessonPlannerScreen({super.key});

  @override
  State<DailyLessonPlannerScreen> createState() => _DailyLessonPlannerScreenState();
}

class _DailyLessonPlannerScreenState extends State<DailyLessonPlannerScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedPeriodIndex = 0;

  final List<String> _availableAids = [
    '🖥️ Smartboard Slides',
    '🧪 Lab Apparatus & Demo',
    '✏️ Blackboard Derivation',
    '👥 Group Problem Solving',
    '📖 NCERT Exercises',
    '🎬 3D Simulation Video',
    '📝 Pop Quiz / Flashcards',
  ];

  final List<String> _objectiveSuggestions = [
    'Understand fundamental definitions',
    'Derive core mathematical formula',
    'Solve 5 standard numericals',
    'Analyze real-world practical applications',
    'Draw ray / circuit diagrams with labels',
  ];

  late List<DailyPeriodLessonPlan> _periods;
  late TextEditingController _topicController;
  late TextEditingController _classworkController;
  late TextEditingController _homeworkController;
  late TextEditingController _reflectionController;

  @override
  void initState() {
    super.initState();
    _periods = [
      DailyPeriodLessonPlan(
        periodNumber: 1,
        timeSlot: '08:30 - 09:15 AM',
        className: 'Class 10-A',
        subject: 'Physics',
        room: 'Room 204',
        unitName: 'Unit 02: The Human Eye & Colourful World',
        topic: 'Atmospheric Refraction & Apparent Position of Stars',
        objectives: [
          'Understand fundamental definitions',
          'Analyze real-world practical applications',
        ],
        teachingAids: [
          '🖥️ Smartboard Slides',
          '✏️ Blackboard Derivation',
        ],
        classworkSummary: 'Explained atmospheric optical density gradient causing continuous bending of starlight. Drew step-by-step ray diagram.',
        homeworkAssigned: 'Read NCERT Section 11.3; answer Question 4 & 5 on page 195.',
        deliveryStatus: 'Delivered',
        reflectionNote: 'Students had difficulty visualizing the density layers. Showed a quick prism demo in next 5 minutes.',
      ),
      DailyPeriodLessonPlan(
        periodNumber: 2,
        timeSlot: '09:15 - 10:00 AM',
        className: 'Class 9-B',
        subject: 'Mathematics',
        room: 'Room 108',
        unitName: 'Unit 02: Polynomials & Factors',
        topic: 'Splitting the Middle Term Method for Quadratic Polynomials',
        objectives: [
          'Derive core mathematical formula',
          'Solve 5 standard numericals',
        ],
        teachingAids: [
          '✏️ Blackboard Derivation',
          '📖 NCERT Exercises',
        ],
        classworkSummary: 'Solved 4 algebraic equations on board. Students attempted 3 questions in pairs.',
        homeworkAssigned: 'Complete Exercise 2.4 Questions 3 & 4 in Math Register.',
        deliveryStatus: 'Draft',
      ),
      DailyPeriodLessonPlan(
        periodNumber: 3,
        timeSlot: '10:15 - 11:00 AM',
        className: 'Staff Room',
        subject: 'Lesson Prep & Paper Grading',
        room: 'Faculty Desk 4',
        isFreePeriod: true,
        unitName: 'Planning & Evaluation',
        topic: 'Review Unit Test Marksheets and prepare Lab handouts for Class 10A',
        objectives: [],
        teachingAids: [],
        classworkSummary: '',
        homeworkAssigned: '',
        deliveryStatus: 'Draft',
      ),
      DailyPeriodLessonPlan(
        periodNumber: 4,
        timeSlot: '11:00 - 11:45 AM',
        className: 'Class 10-A',
        subject: 'Physics Lab',
        room: 'Physics Lab Block B',
        unitName: 'Unit 01: Light & Optics Practicals',
        topic: 'Verification of Snell\'s Law using Rectangular Glass Slab and Optical Pins',
        objectives: [
          'Analyze real-world practical applications',
          'Draw ray / circuit diagrams with labels',
        ],
        teachingAids: [
          '🧪 Lab Apparatus & Demo',
          '👥 Group Problem Solving',
        ],
        classworkSummary: 'Hands-on slab refraction tracing on drawing board with pins. Measured angle of incidence vs angle of emergence.',
        homeworkAssigned: 'Complete Lab Record Notebook with calculations of lateral displacement.',
        deliveryStatus: 'Draft',
      ),
      DailyPeriodLessonPlan(
        periodNumber: 5,
        timeSlot: '12:30 - 01:15 PM',
        className: 'Class 11-A',
        subject: 'Physical Sciences',
        room: 'Room 302',
        unitName: 'Unit 04: Laws of Motion & Friction',
        topic: 'Static vs Kinetic Friction, Angle of Repose and Rolling Resistance',
        objectives: [
          'Understand fundamental definitions',
          'Derive core mathematical formula',
        ],
        teachingAids: [
          '🖥️ Smartboard Slides',
          '🎬 3D Simulation Video',
        ],
        classworkSummary: 'Free body diagrams for inclined planes with frictional forces. Solved 2 exemplar problems.',
        homeworkAssigned: 'Practice Problems Sheet #4 Questions 1 to 8.',
        deliveryStatus: 'Draft',
      ),
    ];

    _initControllers();
  }

  void _initControllers() {
    final current = _periods[_selectedPeriodIndex];
    _topicController = TextEditingController(text: current.topic);
    _classworkController = TextEditingController(text: current.classworkSummary);
    _homeworkController = TextEditingController(text: current.homeworkAssigned);
    _reflectionController = TextEditingController(text: current.reflectionNote);
  }

  @override
  void dispose() {
    _topicController.dispose();
    _classworkController.dispose();
    _homeworkController.dispose();
    _reflectionController.dispose();
    super.dispose();
  }

  void _syncCurrentPeriodToState() {
    final current = _periods[_selectedPeriodIndex];
    current.topic = _topicController.text;
    current.classworkSummary = _classworkController.text;
    current.homeworkAssigned = _homeworkController.text;
    current.reflectionNote = _reflectionController.text;
  }

  void _selectPeriod(int index) {
    _syncCurrentPeriodToState();
    setState(() {
      _selectedPeriodIndex = index;
      final current = _periods[index];
      _topicController.text = current.topic;
      _classworkController.text = current.classworkSummary;
      _homeworkController.text = current.homeworkAssigned;
      _reflectionController.text = current.reflectionNote;
    });
  }

  void _toggleAid(String aid) {
    setState(() {
      final current = _periods[_selectedPeriodIndex];
      if (current.teachingAids.contains(aid)) {
        current.teachingAids.remove(aid);
      } else {
        current.teachingAids.add(aid);
      }
    });
  }

  void _toggleObjective(String obj) {
    setState(() {
      final current = _periods[_selectedPeriodIndex];
      if (current.objectives.contains(obj)) {
        current.objectives.remove(obj);
      } else {
        current.objectives.add(obj);
      }
    });
  }

  void _saveLessonPlan() {
    _syncCurrentPeriodToState();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lesson Plan Saved Successfully! 📝'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _broadcastToClassDiary() {
    _syncCurrentPeriodToState();
    final current = _periods[_selectedPeriodIndex];

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
                color: const Color(0xFF00B894).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.campaign_rounded, color: Color(0xFF00B894), size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Broadcast to Class Diary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF1E293B))),
            ),
          ],
        ),
        content: SizedBox(
          width: 460,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publish today\'s teaching summary and homework to ${current.className} Parents & Students:',
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('📖 Topic: ${current.topic}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B))),
                    const SizedBox(height: 8),
                    Text('📝 Homework: ${current.homeworkAssigned.isNotEmpty ? current.homeworkAssigned : "None"}', style: const TextStyle(fontSize: 12, color: Color(0xFF334155))),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF10B981)),
                        const SizedBox(width: 4),
                        Text('Target Class: ${current.className} (${current.subject})', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF10B981))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                current.deliveryStatus = 'Delivered';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Broadcasted to ${current.className} Class Diary & Parents successfully! 🚀'),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
            },
            icon: const Icon(Icons.send_rounded, size: 16),
            label: const Text('Broadcast Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B894),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _periods[_selectedPeriodIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Day-wise Lesson Planner & Cockpit',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1E293B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Jump to Today',
            onPressed: () {
              setState(() => _selectedDate = DateTime.now());
            },
            icon: const Icon(Icons.today_rounded, color: Color(0xFF6C5CE7)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HORIZONTAL CALENDAR DATE RIBBON
            FadeSlideEntry(
              duration: const Duration(milliseconds: 250),
              child: _buildDateRibbon(),
            ),
            const SizedBox(height: 18),

            // 2. TIMETABLE PERIOD SLIDER STRIP
            FadeSlideEntry(
              delay: const Duration(milliseconds: 80),
              child: _buildPeriodSelector(),
            ),
            const SizedBox(height: 20),

            // 3. MAIN LESSON PLANNER CARD
            FadeSlideEntry(
              delay: const Duration(milliseconds: 140),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header of the selected period
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: current.isFreePeriod
                                    ? const Color(0xFF64748B).withValues(alpha: 0.1)
                                    : const Color(0xFF6C5CE7).withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                current.isFreePeriod ? Icons.desk_rounded : Icons.auto_stories_rounded,
                                color: current.isFreePeriod ? const Color(0xFF64748B) : const Color(0xFF6C5CE7),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Period ${current.periodNumber}: ${current.className}',
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        current.subject,
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF6C5CE7)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${current.timeSlot} • ${current.room}',
                                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Delivery Status Segment
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusBg(current.deliveryStatus),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: current.deliveryStatus,
                              icon: const Icon(Icons.arrow_drop_down, size: 18),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: _getStatusColor(current.deliveryStatus),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Draft', child: Text('📝 Plan Draft')),
                                DropdownMenuItem(value: 'Delivered', child: Text('🟢 Delivered 100%')),
                                DropdownMenuItem(value: 'Partial', child: Text('🟡 Partial (Carry over)')),
                                DropdownMenuItem(value: 'Rescheduled', child: Text('🔴 Rescheduled')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => current.deliveryStatus = val);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 18),

                    // SECTION 1: UNIT & TOPIC FOR TODAY
                    const Text('1. SYLLABUS UNIT & TOPIC FOCUS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark_outline_rounded, size: 18, color: Color(0xFF6C5CE7)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              current.unitName,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _topicController,
                      decoration: InputDecoration(
                        labelText: 'Specific Topic / Formula / Derivation for this Period',
                        hintText: 'e.g. Atmospheric Refraction & Scattering of Light',
                        prefixIcon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF6C5CE7)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // SECTION 2: LEARNING OBJECTIVES
                    const Text('2. PEDAGOGICAL LEARNING OBJECTIVES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
                    const SizedBox(height: 6),
                    const Text('What will scholars be able to do or understand by the end of this 45-minute period?', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _objectiveSuggestions.map((obj) {
                        final isSelected = current.objectives.contains(obj);
                        return FilterChip(
                          label: Text(obj),
                          selected: isSelected,
                          onSelected: (_) => _toggleObjective(obj),
                          backgroundColor: const Color(0xFFF8FAFC),
                          selectedColor: const Color(0xFF6C5CE7).withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFF475569),
                          ),
                          checkmarkColor: const Color(0xFF6C5CE7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 22),

                    // SECTION 3: TEACHING METHODOLOGY & AIDS
                    const Text('3. TEACHING METHODOLOGY & MULTIMEDIA AIDS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableAids.map((aid) {
                        final isSelected = current.teachingAids.contains(aid);
                        return FilterChip(
                          label: Text(aid),
                          selected: isSelected,
                          onSelected: (_) => _toggleAid(aid),
                          backgroundColor: const Color(0xFFF8FAFC),
                          selectedColor: const Color(0xFF00B894).withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                            color: isSelected ? const Color(0xFF00B894) : const Color(0xFF475569),
                          ),
                          checkmarkColor: const Color(0xFF00B894),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: isSelected ? const Color(0xFF00B894) : const Color(0xFFE2E8F0)),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 22),

                    // SECTION 4: CLASSWORK NOTES & HOMEWORK
                    const Text('4. CLASSWORK SUMMARY & HOMEWORK ASSIGNMENT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _classworkController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Classwork Covered (Notes & Examples Solved)',
                        hintText: 'e.g. Explained prism refraction laws and derived Snell\'s constant equation on board.',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _homeworkController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Homework Assigned (Broadcasts to Student & Parent App)',
                        hintText: 'e.g. Solve NCERT Exercise 11.2 Questions 1 to 5 in Physics Homework Notebook.',
                        prefixIcon: const Icon(Icons.assignment_turned_in_outlined, size: 20, color: Color(0xFFF39C12)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _reflectionController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Teacher Reflection / Carry-over Note (Private for teacher)',
                        hintText: 'e.g. 5 students had trouble with Question 3. Need 10 minutes recap at start of next class.',
                        prefixIcon: const Icon(Icons.lightbulb_outline_rounded, size: 20, color: Color(0xFF64748B)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ACTION BUTTONS BAR
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton.icon(
                            onPressed: _saveLessonPlan,
                            icon: const Icon(Icons.save_outlined, size: 18),
                            label: const Text('Save Plan'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF6C5CE7),
                              side: const BorderSide(color: Color(0xFF6C5CE7)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: _broadcastToClassDiary,
                            icon: const Icon(Icons.send_rounded, size: 18),
                            label: const Text('📢 Broadcast to Class Diary'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00B894),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                              textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRibbon() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
            icon: const Icon(Icons.chevron_left_rounded, color: Color(0xFF64748B)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.event_available_rounded, color: Color(0xFF6C5CE7), size: 20),
                const SizedBox(width: 8),
                Text(
                  DateFormat('EEEE, dd MMMM yyyy').format(_selectedDate),
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
            },
            icon: const Icon(Icons.chevron_right_rounded, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _periods.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final p = _periods[index];
          final isSelected = index == _selectedPeriodIndex;

          return InkWell(
            onTap: () => _selectPeriod(index),
            borderRadius: BorderRadius.circular(16),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6C5CE7) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Period ${p.periodNumber}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (p.isFreePeriod)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: isSelected ? Colors.white : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${p.className} • ${p.subject}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white.withValues(alpha: 0.85) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusBg(String status) {
    switch (status) {
      case 'Delivered':
        return const Color(0xFF10B981).withValues(alpha: 0.12);
      case 'Partial':
        return const Color(0xFFF39C12).withValues(alpha: 0.12);
      case 'Rescheduled':
        return const Color(0xFFEF4444).withValues(alpha: 0.12);
      default:
        return const Color(0xFF64748B).withValues(alpha: 0.12);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return const Color(0xFF10B981);
      case 'Partial':
        return const Color(0xFFD97706);
      case 'Rescheduled':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF475569);
    }
  }
}
