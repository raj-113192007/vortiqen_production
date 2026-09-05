import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentHomeworkScreen extends StatefulWidget {
  final String childName;
  const ParentHomeworkScreen({super.key, this.childName = 'Aarav Sharma'});

  @override
  State<ParentHomeworkScreen> createState() => _ParentHomeworkScreenState();
}

class _ParentHomeworkScreenState extends State<ParentHomeworkScreen> {
  String _selectedFilter = 'ALL';
  Map<String, dynamic>? _selectedAssignment;

  final List<Map<String, dynamic>> _assignments = [
    {
      'id': 'hw_001',
      'subject': 'Physics',
      'title': 'Unit 3: Electromagnetic Induction Numerical Worksheet',
      'teacher': 'Dr. Priya Verma',
      'assignedDate': '03 Sep 2026',
      'dueDate': '07 Sep 2026',
      'status': 'PENDING',
      'maxMarks': 25,
      'score': null,
      'color': const Color(0xFF6C5CE7),
      'description':
          'Solve exercise questions 1 to 15 from NCERT Chapter 6. Include step-by-step vector diagrams for Faraday\'s and Lenz\'s laws.',
      'teacherRemarks': null,
      'submissionDate': null,
      'attachments': ['Faraday_Induction_Worksheet.pdf (1.4 MB)'],
    },
    {
      'id': 'hw_002',
      'subject': 'Mathematics',
      'title': 'Integral Calculus: Definite Integrals Application',
      'teacher': 'Mr. Anil Kapoor',
      'assignedDate': '01 Sep 2026',
      'dueDate': '04 Sep 2026',
      'status': 'GRADED',
      'maxMarks': 30,
      'score': 28,
      'color': const Color(0xFF0984E3),
      'description':
          'Calculate bounded area under curves for standard parabola and ellipse intersection problems.',
      'teacherRemarks':
          'Outstanding step-by-step differentiation and integral bounds. Neat handwriting!',
      'submissionDate': '03 Sep 2026, 06:45 PM',
      'attachments': ['Aarav_Calculus_Submission.pdf (3.2 MB)'],
    },
    {
      'id': 'hw_003',
      'subject': 'Chemistry',
      'title': 'Organic Chemistry: Aldehydes & Ketones Reaction Mechanism',
      'teacher': 'Mrs. Kavita Roy',
      'assignedDate': '28 Aug 2026',
      'dueDate': '02 Sep 2026',
      'status': 'GRADED',
      'maxMarks': 20,
      'score': 19,
      'color': const Color(0xFF00B894),
      'description':
          'Draw nucleophilic addition mechanisms for Grignard reagents attacking carbonyl carbons.',
      'teacherRemarks': 'Great mechanism clarity. Reagent labeling was immaculate.',
      'submissionDate': '01 Sep 2026, 08:12 PM',
      'attachments': ['Reaction_Mechanisms_Notes.pdf (2.1 MB)'],
    },
    {
      'id': 'hw_004',
      'subject': 'English Literature',
      'title': 'Essay: Symbolism of the Green Light in The Great Gatsby',
      'teacher': 'Ms. Sarah Jenkins',
      'assignedDate': '04 Sep 2026',
      'dueDate': '09 Sep 2026',
      'status': 'IN_PROGRESS',
      'maxMarks': 20,
      'score': null,
      'color': const Color(0xFFE17055),
      'description':
          'Write an analytical essay (600-800 words) exploring Jay Gatsby\'s yearning for the past and the American Dream.',
      'teacherRemarks': null,
      'submissionDate': null,
      'attachments': ['Gatsby_Essay_Rubric.pdf (820 KB)'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedAssignment = _assignments.first;
  }

  List<Map<String, dynamic>> get _filteredList {
    if (_selectedFilter == 'ALL') return _assignments;
    return _assignments.where((a) => a['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Homework & Assignments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              'Monitoring: ${widget.childName} • Class 10-A',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ResponsiveContainer(
        maxWidth: 1320,
        child: ResponsiveTwoPane(
          breakpoint: 880,
          leftFlex: 5,
          rightFlex: 6,
          leftPane: _buildAssignmentListPane(theme),
          rightPane: _selectedAssignment == null
              ? const Center(child: Text('Select an assignment to inspect details'))
              : _buildAssignmentDetailPane(theme, _selectedAssignment!),
        ),
      ),
    );
  }

  Widget _buildAssignmentListPane(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('ALL', 'All (4)'),
              const SizedBox(width: 8),
              _buildFilterChip('PENDING', 'Pending (1)'),
              const SizedBox(width: 8),
              _buildFilterChip('IN_PROGRESS', 'In Progress (1)'),
              const SizedBox(width: 8),
              _buildFilterChip('GRADED', 'Graded (2)'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Assignment List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = _filteredList[index];
            final isSelected = _selectedAssignment?['id'] == item['id'];

            return AnimatedCard(
              padding: const EdgeInsets.all(16),
              color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
              border: Border.all(
                color: isSelected ? const Color(0xFF6366F1) : const Color(0xFFE2E8F0),
                width: isSelected ? 1.5 : 1.0,
              ),
              child: InkWell(
                onTap: () => setState(() => _selectedAssignment = item),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['subject'],
                            style: TextStyle(
                              color: item['color'] as Color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        _buildStatusBadge(item['status']),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          item['teacher'],
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        const Spacer(),
                        Icon(Icons.event_outlined, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          'Due: ${item['dueDate']}',
                          style: TextStyle(
                            color: item['status'] == 'PENDING'
                                ? const Color(0xFFDC2626)
                                : Colors.grey[600],
                            fontWeight: item['status'] == 'PENDING'
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterChip(String key, String label) {
    final isSelected = _selectedFilter == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) setState(() => _selectedFilter = key);
      },
      selectedColor: const Color(0xFF6366F1),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : const Color(0xFF475569),
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? Colors.transparent : const Color(0xFFCBD5E1),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color fg;
    String text;

    switch (status) {
      case 'GRADED':
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF16A34A);
        text = 'GRADED';
        break;
      case 'PENDING':
        bg = const Color(0xFFFEE2E2);
        fg = const Color(0xFFDC2626);
        text = 'DUE SOON';
        break;
      case 'IN_PROGRESS':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFD97706);
        text = 'IN PROGRESS';
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF64748B);
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  Widget _buildAssignmentDetailPane(ThemeData theme, Map<String, dynamic> item) {
    return AnimatedCard(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE2E8F0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['subject'],
                  style: TextStyle(
                    color: item['color'] as Color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              if (item['score'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF10B981)),
                  ),
                  child: Text(
                    'Score: ${item['score']} / ${item['maxMarks']} (${((item['score'] / item['maxMarks']) * 100).toInt()}%)',
                    style: const TextStyle(
                      color: Color(0xFF047857),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            item['title'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color(0xFF6366F1),
                  child: const Icon(Icons.school, size: 16, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['teacher'],
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    Text(
                      'Assigned on ${item['assignedDate']} • Due on ${item['dueDate']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Assignment Overview & Instructions',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF334155)),
          ),
          const SizedBox(height: 8),
          Text(
            item['description'],
            style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF475569)),
          ),
          if (item['teacherRemarks'] != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.feedback_outlined, size: 18, color: Color(0xFF2563EB)),
                      SizedBox(width: 8),
                      Text(
                        'Teacher Feedback & Remarks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1D4ED8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['teacherRemarks'],
                    style: const TextStyle(
                      color: Color(0xFF1E40AF),
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                  if (item['submissionDate'] != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Submitted on: ${item['submissionDate']}',
                      style: TextStyle(color: Colors.blue[800], fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          const Text(
            'Attachments & Worksheets',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF334155)),
          ),
          const SizedBox(height: 8),
          ...((item['attachments'] as List<String>).map(
            (att) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.picture_as_pdf, color: Color(0xFFEF4444), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      att,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.download_rounded, size: 18, color: Color(0xFF6366F1)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloading $att...')),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sent reminder notification to ${widget.childName}!')),
                    );
                  },
                  icon: const Icon(Icons.notifications_active_outlined, size: 16),
                  label: const Text('Remind Child'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Parent Signature acknowledged & saved!'),
                        backgroundColor: Color(0xFF10B981),
                      ),
                    );
                  },
                  icon: const Icon(Icons.draw_outlined, size: 16),
                  label: const Text('Parent Sign-off'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
