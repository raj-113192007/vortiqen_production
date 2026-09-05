import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class UnitwisePyqsScreen extends StatefulWidget {
  const UnitwisePyqsScreen({super.key});

  @override
  State<UnitwisePyqsScreen> createState() => _UnitwisePyqsScreenState();
}

class _UnitwisePyqsScreenState extends State<UnitwisePyqsScreen> {
  String _selectedUnit = 'All Units';

  final List<Map<String, dynamic>> _pyqPapers = [
    {
      'title': 'Unit 1: Chemical Reactions & Equations (5-Year Solved PYQ Collection)',
      'subject': 'Science (Chemistry)',
      'unit': 'Unit 1',
      'years': '2021 - 2025 Board Papers',
      'weightage': '8 Marks in Final Exam',
      'isHighYield': true,
      'questionsCount': '42 Solved Questions',
      'fileName': 'Chemistry_Unit1_PYQs_Solved.pdf',
    },
    {
      'title': 'Unit 10: Light - Reflection & Refraction (Ray Diagrams & Numerical Bank)',
      'subject': 'Science (Physics)',
      'unit': 'Unit 10',
      'years': '2020 - 2025 Board Papers',
      'weightage': '10 Marks in Final Exam',
      'isHighYield': true,
      'questionsCount': '58 Solved Questions',
      'fileName': 'Physics_Unit10_Optics_PYQs.pdf',
    },
    {
      'title': 'Unit 4: Quadratic Equations & Arithmetic Progressions',
      'subject': 'Mathematics',
      'unit': 'Unit 4',
      'years': '2022 - 2025 Board Papers',
      'weightage': '12 Marks in Final Exam',
      'isHighYield': true,
      'questionsCount': '64 Solved Questions',
      'fileName': 'Maths_Unit4_Algebra_PYQs.pdf',
    },
    {
      'title': 'Unit 6: Life Processes (Circulation, Respiration & Excretion)',
      'subject': 'Science (Biology)',
      'unit': 'Unit 6',
      'years': '2021 - 2025 Board Papers',
      'weightage': '9 Marks in Final Exam',
      'isHighYield': false,
      'questionsCount': '36 Solved Questions',
      'fileName': 'Biology_Unit6_LifeProcesses_PYQs.pdf',
    },
    {
      'title': 'Unit 2: Nationalism in Europe & India (Long Answer Mastery)',
      'subject': 'Social Science',
      'unit': 'Unit 2',
      'years': '2020 - 2025 Board Papers',
      'weightage': '7 Marks in Final Exam',
      'isHighYield': false,
      'questionsCount': '28 Solved Questions',
      'fileName': 'SocialScience_Unit2_History_PYQs.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.studentPrimary;

    final filteredList = _selectedUnit == 'All Units'
        ? _pyqPapers
        : _pyqPapers.where((p) => p['unit'] == _selectedUnit).toList();

    final isWide = context.screenWidth >= 960;

    return SingleChildScrollView(
      child: ResponsiveContainer(
        maxWidth: 1200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B894), Color(0xFF00CEC9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history_edu, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Unit-wise Solved PYQ Repository', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                        SizedBox(height: 2),
                        Text('Official board questions with detailed marking scheme steps', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Unit Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All Units', 'Unit 1', 'Unit 4', 'Unit 6', 'Unit 10', 'Unit 2'].map((u) {
                  final isSelected = _selectedUnit == u;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(u),
                      onSelected: (val) => setState(() => _selectedUnit = u),
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

            // PYQ Cards List (Responsive 2-column or list)
            if (isWide)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index) => _buildPyqCard(context, filteredList[index]),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) => _buildPyqCard(context, filteredList[index]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPyqCard(BuildContext context, Map<String, dynamic> item) {
    final isHighYield = item['isHighYield'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighYield ? const Color(0xFF00B894).withValues(alpha: 0.35) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0984E3).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      item['subject'],
                      style: const TextStyle(color: Color(0xFF0984E3), fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                  if (isHighYield)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFF16A34A), size: 12),
                          SizedBox(width: 4),
                          Text('HIGH WEIGHTAGE', style: TextStyle(color: Color(0xFF16A34A), fontSize: 9, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, letterSpacing: -0.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text('📅 ${item['years']}', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                  const SizedBox(width: 12),
                  Text('🎯 ${item['weightage']}', style: const TextStyle(fontSize: 11, color: Color(0xFF0984E3), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(item['questionsCount'], style: const TextStyle(fontSize: 11, color: Color(0xFF475569), fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading Solved PYQ "${item['fileName']}"... 📥'),
                      backgroundColor: const Color(0xFF00B894),
                    ),
                  );
                },
                icon: const Icon(Icons.download, size: 16),
                label: const Text('Download Solved PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0984E3),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
