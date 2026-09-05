import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class YoutubeLecturesScreen extends StatefulWidget {
  const YoutubeLecturesScreen({super.key});

  @override
  State<YoutubeLecturesScreen> createState() => _YoutubeLecturesScreenState();
}

class _YoutubeLecturesScreenState extends State<YoutubeLecturesScreen> {
  String _selectedSubject = 'All';

  final List<Map<String, dynamic>> _lectures = [
    {
      'title': 'Light: Reflection & Refraction (Complete Chapter One-Shot)',
      'subject': 'Physics',
      'unit': 'Unit 10: Optics',
      'teacher': 'Prof. H. C. Verma',
      'duration': '52:14 Mins',
      'views': '1.2k School Views',
      'youtubeUrl': 'https://youtube.com/watch?v=demo_physics_optics',
      'timestamps': ['00:00 - Introduction', '08:30 - Laws of Reflection', '21:15 - Mirror Formula & Magnification', '38:40 - Solved Board Numericals'],
      'notesPdf': 'Optics_Master_Notes.pdf',
    },
    {
      'title': 'Quadratic Equations: Complete Concept & NCERT Ex 4.2',
      'subject': 'Mathematics',
      'unit': 'Unit 4: Algebra',
      'teacher': 'Dr. S. Ramanujan',
      'duration': '44:20 Mins',
      'views': '980 School Views',
      'youtubeUrl': 'https://youtube.com/watch?v=demo_maths_quad',
      'timestamps': ['00:00 - Factorisation Method', '14:20 - Completing the Square', '28:10 - Quadratic Formula & Discriminant'],
      'notesPdf': 'Quadratic_Formula_Sheet.pdf',
    },
    {
      'title': 'Chemical Reactions & Equations (Balancing & Types with Lab Demos)',
      'subject': 'Chemistry',
      'unit': 'Unit 1: Chemical Substances',
      'teacher': 'Dr. Meenakshi Sharma',
      'duration': '38:45 Mins',
      'views': '1.5k School Views',
      'youtubeUrl': 'https://youtube.com/watch?v=demo_chem_reactions',
      'timestamps': ['00:00 - Physical vs Chemical Change', '09:12 - Balancing Chemical Equations', '22:40 - Redox Reactions Demo'],
      'notesPdf': 'Chemical_Reactions_Handout.pdf',
    },
    {
      'title': 'Python Loops, Lists & String Manipulation Masterclass',
      'subject': 'Computer Science',
      'unit': 'Unit 2: Programming in Python',
      'teacher': 'Mr. Amit Gupta',
      'duration': '48:10 Mins',
      'views': '640 School Views',
      'youtubeUrl': 'https://youtube.com/watch?v=demo_cs_python',
      'timestamps': ['00:00 - For vs While Loops', '15:20 - List Comprehensions', '32:10 - Coding Interview Questions'],
      'notesPdf': 'Python_Cheatsheet.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    final filteredLectures = _selectedSubject == 'All'
        ? _lectures
        : _lectures.where((l) => l['subject'] == _selectedSubject).toList();

    final isWide = context.screenWidth >= 960;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Physics', 'Mathematics', 'Chemistry', 'Computer Science'].map((subj) {
                  final isSelected = _selectedSubject == subj;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(subj),
                      onSelected: (val) => setState(() => _selectedSubject = subj),
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
            const SizedBox(height: 16),

            // Video Lecture Cards (Responsive 2-column or list)
            if (isWide)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.85,
                ),
                itemCount: filteredLectures.length,
                itemBuilder: (context, index) => _buildLectureCard(context, filteredLectures[index], primaryColor),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredLectures.length,
                itemBuilder: (context, index) => _buildLectureCard(context, filteredLectures[index], primaryColor),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLectureCard(BuildContext context, Map<String, dynamic> item, Color primaryColor) {
    final timestamps = item['timestamps'] as List<String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simulated YouTube Video Banner with Play Overlay
          GestureDetector(
            onTap: () => _openVideoPlayerDialog(context, item),
            child: Container(
              height: 165,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                gradient: LinearGradient(
                  colors: [Color(0xFF2D3436), Color(0xFF636E72)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 14,
                    bottom: 10,
                    child: Text(
                      item['subject'],
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.15), fontSize: 32, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF0000),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(color: Colors.red.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow, color: Colors.white, size: 26),
                        SizedBox(width: 6),
                        Text('Play Lecture', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(item['duration'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Details Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['unit'],
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 10),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(item['views'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['title'],
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: -0.3),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text('Curated by ${item['teacher']}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                const SizedBox(height: 10),

                // Timestamps list
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('📌 Key Timestamps:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
                      const SizedBox(height: 4),
                      ...timestamps.take(3).map((t) => Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(t, style: const TextStyle(fontSize: 10, color: Color(0xFF0984E3), fontWeight: FontWeight.w500)),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Download Notes Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Downloading "${item['notesPdf']}"... 📄')),
                      );
                    },
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Download Notes PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openVideoPlayerDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['subject'], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0984E3))),
                      IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  Text(item['title'], style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                  const SizedBox(height: 16),
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.play_circle_filled, color: Colors.white, size: 60),
                          SizedBox(height: 8),
                          Text('Streaming Teacher Video Lecture...', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Teacher Notes: ${item['teacher']} recommends reviewing the chapter worksheet before watching the numerical section.', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
