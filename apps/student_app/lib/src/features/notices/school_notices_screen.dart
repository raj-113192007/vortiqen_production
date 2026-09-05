import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class SchoolNoticesScreen extends StatefulWidget {
  const SchoolNoticesScreen({super.key});

  @override
  State<SchoolNoticesScreen> createState() => _SchoolNoticesScreenState();
}

class _SchoolNoticesScreenState extends State<SchoolNoticesScreen> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _notices = [
    {
      'title': 'Annual Inter-School Sports Meet 2026 & Science Exhibition',
      'category': 'Events',
      'date': '29 Aug 2026',
      'author': 'Principal Office',
      'isUrgent': true,
      'content': 'We are pleased to announce our 15th Annual Sports Meet & Science Fair. Registrations for track, badminton, robotics, and coding events are open till 5th September.',
      'attachment': 'sports_event_schedule.pdf',
    },
    {
      'title': 'Revised Examination Timetable for Mid-Term Exams (Class 10)',
      'category': 'Academics',
      'date': '26 Aug 2026',
      'author': 'Examination Controller',
      'isUrgent': false,
      'content': 'Please find attached the updated Mid-Term theory & practical examination schedule. Admit cards will be distributed in respective homerooms starting Monday.',
      'attachment': 'midterm_timetable_v2.pdf',
    },
    {
      'title': 'School Holiday Declaration on Account of Janmashtami',
      'category': 'Holidays',
      'date': '24 Aug 2026',
      'author': 'Administration',
      'isUrgent': false,
      'content': 'The school will remain closed on Thursday, 3rd September 2026 on account of Janmashtami. Regular classes will resume on Friday as per timetable.',
      'attachment': null,
    },
    {
      'title': 'CBSE National Level Coding & AI Hackathon Registrations',
      'category': 'Academics',
      'date': '20 Aug 2026',
      'author': 'Computer Science Dept',
      'isUrgent': false,
      'content': 'Students interested in participating in the CBSE National Level AI Hackathon should register their 3-member team with Mr. Gupta before 10th September.',
      'attachment': 'hackathon_guidelines.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    final filteredNotices = _selectedCategory == 'All'
        ? _notices
        : _notices.where((n) => n['category'] == _selectedCategory).toList();

    final isWide = context.screenWidth >= 880;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text('School Notices & Circulars'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          maxWidth: 1200,
          child: Column(
            children: [
              // Category Filter Chips
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['All', 'Academics', 'Events', 'Holidays', 'Urgent'].map((cat) {
                      final isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(cat),
                          onSelected: (val) => setState(() => _selectedCategory = cat),
                          selectedColor: primaryColor.withValues(alpha: 0.15),
                          checkmarkColor: primaryColor,
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
              ),
              const SizedBox(height: 16),

              // Notice List / Grid
              if (isWide)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.45,
                  ),
                  itemCount: filteredNotices.length,
                  itemBuilder: (context, index) => _buildNoticeCard(context, filteredNotices[index], primaryColor),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredNotices.length,
                  itemBuilder: (context, index) => _buildNoticeCard(context, filteredNotices[index], primaryColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeCard(BuildContext context, Map<String, dynamic> notice, Color primaryColor) {
    final isUrgent = notice['isUrgent'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUrgent ? const Color(0xFFE84393).withValues(alpha: 0.4) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(notice['category']).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      notice['category'],
                      style: TextStyle(
                        color: _getCategoryColor(notice['category']),
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text(
                    notice['date'],
                    style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                notice['title'],
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: -0.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                notice['content'],
                style: TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.45),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.account_balance, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(notice['author'], style: TextStyle(color: Colors.grey[600], fontSize: 11)),
              const Spacer(),
              if (notice['attachment'] != null)
                InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Downloading "${notice['attachment']}"... 📄')),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.attachment, size: 16, color: primaryColor),
                      const SizedBox(width: 4),
                      Text(
                        'Download PDF',
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String cat) {
    switch (cat) {
      case 'Academics':
        return const Color(0xFF0984E3);
      case 'Events':
        return const Color(0xFF6C5CE7);
      case 'Holidays':
        return const Color(0xFF00B894);
      case 'Urgent':
        return const Color(0xFFE84393);
      default:
        return const Color(0xFF2D3436);
    }
  }
}
