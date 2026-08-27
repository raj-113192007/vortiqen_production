import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class SuperAdminDashboardScreen extends ConsumerWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(platformStatsProvider);
    final schoolsAsync = ref.watch(allSchoolsProvider);
    final user = ref.watch(authProvider).value?.user;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        title: const Text('VortiQen SuperAdmin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh Platform Stats',
            onPressed: () {
              ref.invalidate(platformStatsProvider);
              ref.invalidate(allSchoolsProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vibrant Header
            VibrantHeader(
              role: AppRole.superAdmin,
              title: 'Master Control Tower',
              subtitle: 'Global Multi-Tenant Ecosystem & Fleet Health',
              userName: user?.name ?? 'SuperAdmin',
            ),

            const SizedBox(height: 28),

            // Platform Stats Grid
            statsAsync.when(
              data: (stats) => Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Total Affiliated Schools', stats.totalSchools.toString(), Icons.domain_rounded, const Color(0xFFE84393)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard('Platform Active Users', stats.totalUsers.toString(), Icons.people_alt_rounded, const Color(0xFF0984E3)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard('Enrolled Students', stats.totalStudents.toString(), Icons.face_rounded, const Color(0xFF00B894)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard('Monthly Recurring Rev', '₹${stats.totalRevenue}', Icons.currency_rupee_rounded, const Color(0xFFD4AF37)),
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Error loading stats: $e'),
            ),

            const SizedBox(height: 36),

            // Registered Schools List Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Affiliated Schools Registry',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/add-school'),
                  icon: const Icon(Icons.add_business_rounded, size: 18),
                  label: const Text('Add School'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE84393),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Schools Table
            schoolsAsync.when(
              data: (schools) => AnimatedCard(
                padding: EdgeInsets.zero,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
                    columns: const [
                      DataColumn(label: Text('School Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('School Code', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('City', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Tenant Status', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Onboarded Date', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: schools.map((school) => DataRow(
                      cells: [
                        DataCell(Text(school.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B)))),
                        DataCell(Text(school.code)),
                        DataCell(Text(school.city ?? 'N/A')),
                        DataCell(_buildStatusBadge(school.status)),
                        DataCell(Text(school.createdAt.toString().split(' ')[0])),
                        DataCell(
                          DropdownButton<String>(
                            value: school.status,
                            underline: const SizedBox(),
                            items: ['ACTIVE', 'SUSPENDED', 'TRIAL', 'CHURNED'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (newStatus) async {
                              if (newStatus != null && newStatus != school.status) {
                                await ref.read(superadminRepositoryProvider).updateSchoolStatus(school.id, newStatus);
                                ref.invalidate(allSchoolsProvider);
                                ref.invalidate(platformStatsProvider);
                              }
                            },
                          ),
                        ),
                      ],
                    )).toList(),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Error loading schools: $e'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return AnimatedCard(
      borderColor: color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 16),
          Text(title, style: GoogleFonts.inter(fontSize: 12, color: const Color(0xFF64748B), fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B))),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'ACTIVE': color = const Color(0xFF00B894); break;
      case 'SUSPENDED': color = const Color(0xFFD63031); break;
      case 'TRIAL': color = const Color(0xFFF39C12); break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}
