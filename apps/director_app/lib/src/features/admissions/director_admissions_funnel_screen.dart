import 'package:flutter/material.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class DirectorAdmissionsFunnelScreen extends StatelessWidget {
  const DirectorAdmissionsFunnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stages = [
      {'stage': '1. Total Inquiries & Prospect Forms', 'count': '840 Leads', 'pct': '100%', 'color': const Color(0xFF6366F1), 'bar': 1.0},
      {'stage': '2. Campus Tours & Entrance Aptitude Tests', 'count': '520 Attendees', 'pct': '61.9%', 'color': const Color(0xFF0984E3), 'bar': 0.62},
      {'stage': '3. Merit List Shortlisted Applicants', 'count': '310 Qualified', 'pct': '36.9%', 'color': const Color(0xFFF59E0B), 'bar': 0.37},
      {'stage': '4. Confirmed Fee Paid Enrollments', 'count': '240 Admitted', 'pct': '28.5%', 'color': const Color(0xFF10B981), 'bar': 0.28},
    ];

    final channels = [
      {'channel': 'Parent & Alumni Referrals', 'leads': '340 Leads', 'enrolled': '118 Students', 'conv': '34.7%'},
      {'channel': 'Organic Google Search & Website', 'leads': '260 Leads', 'enrolled': '72 Students', 'conv': '27.6%'},
      {'channel': 'Social Media & Digital Ads', 'leads': '160 Leads', 'enrolled': '34 Students', 'conv': '21.2%'},
      {'channel': 'State Education Fair Expo', 'leads': '80 Leads', 'enrolled': '16 Students', 'conv': '20.0%'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admissions Funnel & Growth Analytics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('New Student Intake • Academic Session 2026-27', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ResponsiveContainer(
          maxWidth: 1300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Target Seat Occupancy Card
              AnimatedCard(
                padding: const EdgeInsets.all(24),
                color: const Color(0xFF0F172A),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFD4AF37)),
                      ),
                      child: const Icon(Icons.school, size: 36, color: Color(0xFFD4AF37)),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SEAT OCCUPANCY GOAL', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          const Text('240 / 250 Available Seats Filled (96.0%)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: const LinearProgressIndicator(
                              value: 0.96,
                              minHeight: 8,
                              backgroundColor: Color(0xFF334155),
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Conversion Funnel Bars
              ResponsiveTwoPane(
                breakpoint: 880,
                leftFlex: 6,
                rightFlex: 5,
                leftPane: AnimatedCard(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Lead-to-Enrollment Conversion Funnel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                      const SizedBox(height: 20),
                      ...stages.map((s) {
                        final col = s['color'] as Color;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(s['stage'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  Text('${s['count']} (${s['pct']})', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: col)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: s['bar'] as double,
                                  minHeight: 12,
                                  backgroundColor: const Color(0xFFF1F5F9),
                                  valueColor: AlwaysStoppedAnimation<Color>(col),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                rightPane: AnimatedCard(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Acquisition Channel Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                      const SizedBox(height: 16),
                      ...channels.map((c) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(c['channel'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                                  Text(c['conv'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF10B981))),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text('${c['leads']} ➔ ${c['enrolled']}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
