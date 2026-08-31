import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'admissions_provider.dart';
import 'package:go_router/go_router.dart';

class AdmissionsListScreen extends ConsumerStatefulWidget {
  const AdmissionsListScreen({super.key});

  @override
  ConsumerState<AdmissionsListScreen> createState() => _AdmissionsListScreenState();
}

class _AdmissionsListScreenState extends ConsumerState<AdmissionsListScreen> {
  String _selectedStatus = 'ALL';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final enquiriesAsync = ref.watch(admissionsProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 16,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          FadeSlideEntry(
            duration: const Duration(milliseconds: 400),
            child: _buildHeader(context),
          ),
          const SizedBox(height: 20),

          enquiriesAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (enquiries) {
              final total = enquiries.length;
              final pending = enquiries.where((e) => e.status == 'PENDING').length;
              final interviews = enquiries.where((e) => e.status == 'INTERVIEW_SCHEDULED').length;
              final approved = enquiries.where((e) => e.status == 'APPROVED').length;

              final filtered = enquiries.where((e) {
                final matchesStatus = _selectedStatus == 'ALL' || e.status == _selectedStatus;
                final q = _searchQuery.toLowerCase();
                final matchesQuery = q.isEmpty ||
                    e.studentName.toLowerCase().contains(q) ||
                    e.parentName.toLowerCase().contains(q) ||
                    e.phone.toLowerCase().contains(q) ||
                    (e.classApplied ?? '').toLowerCase().contains(q);
                return matchesStatus && matchesQuery;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Pipeline Summary KPIs
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 100),
                    child: _buildPipelineKpis(total, pending, interviews, approved),
                  ),
                  const SizedBox(height: 20),

                  // 3. Search & Filter Bar
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 150),
                    child: _buildSearchAndFilters(),
                  ),
                  const SizedBox(height: 16),

                  // 4. Enquiries List
                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 200),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final enquiry = filtered[index];
                          final statusColor = _getStatusColor(enquiry.status);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HoverLiftCard(
                              padding: const EdgeInsets.all(16),
                              borderRadius: 14,
                              hoverBorderColor: statusColor.withValues(alpha: 0.4),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: statusColor.withValues(alpha: 0.12),
                                    child: Text(
                                      (enquiry.studentName.isNotEmpty ? enquiry.studentName[0] : 'S').toUpperCase(),
                                      style: TextStyle(fontWeight: FontWeight.w800, color: statusColor, fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              enquiry.studentName,
                                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF6C5CE7).withValues(alpha: 0.08),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                'Class: ${enquiry.classApplied ?? 'General'}',
                                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF6C5CE7)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Parent: ${enquiry.parentName} • Phone: ${enquiry.phone}',
                                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      enquiry.status.replaceAll('_', ' '),
                                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 16,
        runSpacing: 16,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admissions & Scholar Onboarding Pipeline',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Track Prospective Enquiries, Schedule Entrance Interviews & Convert Candidates',
                style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFF10B981)),
                    SizedBox(width: 6),
                    Text('ADMISSIONS OPEN', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => context.go('/admissions/new'),
                icon: const Icon(Icons.person_add_rounded, size: 16),
                label: const Text('New Scholar Enquiry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C5CE7),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineKpis(int total, int pending, int interviews, int approved) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth < 650 ? 2 : 4;
        return GridView.count(
          crossAxisCount: crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: crossCount == 4 ? 2.3 : 2.0,
          children: [
            _buildMetricTile(total.toDouble(), 'Total Enquiries', Icons.feed_outlined, const Color(0xFF6C5CE7), 'All candidates logged'),
            _buildMetricTile(pending.toDouble(), 'Pending Review', Icons.hourglass_top_rounded, const Color(0xFFF59E0B), 'Awaiting first contact'),
            _buildMetricTile(interviews.toDouble(), 'Interviews Booked', Icons.event_available_rounded, const Color(0xFF0984E3), 'Screening scheduled'),
            _buildMetricTile(approved.toDouble(), 'Admitted Scholars', Icons.verified_user_outlined, const Color(0xFF10B981), 'Ready for enrollment'),
          ],
        );
      },
    );
  }

  Widget _buildMetricTile(double value, String label, IconData icon, Color color, String sub) {
    return HoverLiftCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      borderRadius: 14,
      hoverBorderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedMetricCounter(
                  targetValue: value,
                  fractionDigits: 0,
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: color),
                ),
                Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
                Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    const filters = [
      {'label': 'All Enquiries', 'key': 'ALL'},
      {'label': 'Pending', 'key': 'PENDING'},
      {'label': 'Interviews', 'key': 'INTERVIEW_SCHEDULED'},
      {'label': 'Approved', 'key': 'APPROVED'},
      {'label': 'Rejected', 'key': 'REJECTED'},
    ];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            onChanged: (v) => setState(() => _searchQuery = v),
            decoration: const InputDecoration(
              icon: Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 20),
              hintText: 'Search by Candidate Name, Parent Name, Phone, or Class...',
              hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filters.map((f) {
              final isSelected = _selectedStatus == f['key'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f['label']!),
                  selected: isSelected,
                  selectedColor: const Color(0xFF6C5CE7),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 11,
                  ),
                  side: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : const Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  onSelected: (sel) {
                    if (sel) setState(() => _selectedStatus = f['key']!);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.person_search_rounded, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No Admission Enquiries Found', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('No prospective scholar entries match the current filter or search criteria.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return const Color(0xFFF59E0B);
      case 'INTERVIEW_SCHEDULED':
        return const Color(0xFF0984E3);
      case 'APPROVED':
        return const Color(0xFF10B981);
      case 'REJECTED':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF64748B);
    }
  }
}
