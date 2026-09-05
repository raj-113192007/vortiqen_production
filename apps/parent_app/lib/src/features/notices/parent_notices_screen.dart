import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class ParentNoticesScreen extends StatefulWidget {
  const ParentNoticesScreen({super.key});

  @override
  State<ParentNoticesScreen> createState() => _ParentNoticesScreenState();
}

class _ParentNoticesScreenState extends State<ParentNoticesScreen> {
  String _activeCategory = 'ALL';

  final List<Map<String, dynamic>> _notices = [
    {
      'id': 'cir_001',
      'category': 'ACADEMICS',
      'title': 'CBSE Term 1 Board Practicals & Project Submission Schedule',
      'date': '04 Sep 2026',
      'author': 'Academic Dean & Examination Cell',
      'isUrgent': true,
      'summary':
          'All students of Class 10 & 12 must submit their Science, Computer Science, and Mathematics practical project portfolios signed by subject teachers by 20th September 2026.',
      'attachment': 'Term1_Practical_Datesheet_2026.pdf (1.8 MB)',
    },
    {
      'id': 'cir_002',
      'category': 'TRANSPORT',
      'title': 'Route 14 & Route 08 Morning Pickup Timing Adjustment (+10 Mins)',
      'date': '02 Sep 2026',
      'author': 'Transport Fleet Directorate',
      'isUrgent': false,
      'summary':
          'Due to metro flyover maintenance on Sector 62 Link Road, morning pickup timings for Route 14 will begin 10 minutes earlier starting Monday.',
      'attachment': 'Route_14_Revised_Schedule.pdf (920 KB)',
    },
    {
      'id': 'cir_003',
      'category': 'HOLIDAYS',
      'title': 'Autumn Festive Break & Dussehra Vacation Notice',
      'date': '28 Aug 2026',
      'author': 'Office of the Principal',
      'isUrgent': false,
      'summary':
          'The school campus will remain closed from 02 October to 08 October for Dussehra and Autumn break. Online remedial doubt counters will remain active on the student portal.',
      'attachment': null,
    },
    {
      'id': 'cir_004',
      'category': 'SPORTS & EVENTS',
      'title': '34th Annual Inter-School Athletic Meet 2026 Registration',
      'date': '25 Aug 2026',
      'author': 'Sports Department',
      'isUrgent': false,
      'summary':
          'Students interested in track events (100m, 400m relay, long jump) and badminton can register their interest via the Physical Education department.',
      'attachment': 'Athletics_Meet_Entry_Form.pdf (1.2 MB)',
    },
  ];

  List<Map<String, dynamic>> get _filteredNotices {
    if (_activeCategory == 'ALL') return _notices;
    return _notices.where((n) => n['category'] == _activeCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('School Notices & Circulars', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChip('ALL', 'All Notices (${_notices.length})'),
                    const SizedBox(width: 8),
                    _buildChip('ACADEMICS', 'Academics'),
                    const SizedBox(width: 8),
                    _buildChip('TRANSPORT', 'Transport'),
                    const SizedBox(width: 8),
                    _buildChip('HOLIDAYS', 'Holidays'),
                    const SizedBox(width: 8),
                    _buildChip('SPORTS & EVENTS', 'Sports & Events'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Notices List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredNotices.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final notice = _filteredNotices[index];
                  final isUrgent = notice['isUrgent'] == true;

                  return AnimatedCard(
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    border: Border.all(
                      color: isUrgent ? const Color(0xFFFCA5A5) : const Color(0xFFE2E8F0),
                      width: isUrgent ? 1.5 : 1.0,
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
                                color: _getCategoryColor(notice['category']).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                notice['category'],
                                style: TextStyle(
                                  color: _getCategoryColor(notice['category']),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (isUrgent) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEF4444),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'URGENT',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                Text(
                                  notice['date'],
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          notice['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notice['summary'],
                          style: const TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF475569)),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.account_balance, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Text(
                              'Issued by: ${notice['author']}',
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            if (notice['attachment'] != null)
                              OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Downloading ${notice['attachment']}...')),
                                  );
                                },
                                icon: const Icon(Icons.download_rounded, size: 14),
                                label: const Text('Download Circular PDF', style: TextStyle(fontSize: 11)),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String key, String label) {
    final isSelected = _activeCategory == key;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {
        if (val) setState(() => _activeCategory = key);
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

  Color _getCategoryColor(String cat) {
    switch (cat) {
      case 'ACADEMICS':
        return const Color(0xFF6366F1);
      case 'TRANSPORT':
        return const Color(0xFFF59E0B);
      case 'HOLIDAYS':
        return const Color(0xFF10B981);
      case 'SPORTS & EVENTS':
        return const Color(0xFFEC4899);
      default:
        return const Color(0xFF64748B);
    }
  }
}
