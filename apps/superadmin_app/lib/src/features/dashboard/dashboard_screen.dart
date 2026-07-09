import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class SuperAdminDashboardScreen extends ConsumerWidget {
  const SuperAdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(platformStatsProvider);
    final schoolsAsync = ref.watch(allSchoolsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('VortiQen SuperAdmin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(platformStatsProvider);
              ref.invalidate(allSchoolsProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Platform Overview', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            statsAsync.when(
              data: (stats) => GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 2,
                children: [
                  _buildStatCard(context, 'Total Schools', stats.totalSchools.toString(), Icons.school),
                  _buildStatCard(context, 'Total Users', stats.totalUsers.toString(), Icons.people),
                  _buildStatCard(context, 'Total Students', stats.totalStudents.toString(), Icons.face),
                  _buildStatCard(context, 'Monthly Revenue', '₹${stats.totalRevenue}', Icons.currency_rupee, color: Colors.green),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Error: $e'),
            ),
            
            const SizedBox(height: 48),
            Text('Registered Schools', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            schoolsAsync.when(
              data: (schools) => Card(
                clipBehavior: Clip.antiAlias,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Code')),
                      DataColumn(label: Text('City')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Created At')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: schools.map((school) => DataRow(
                      cells: [
                        DataCell(Text(school.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(school.code)),
                        DataCell(Text(school.city ?? 'N/A')),
                        DataCell(_buildStatusBadge(school.status)),
                        DataCell(Text(school.createdAt.toString().split(' ')[0])),
                        DataCell(
                          DropdownButton<String>(
                            value: school.status,
                            items: ['ACTIVE', 'SUSPENDED', 'TRIAL', 'CHURNED'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                            onChanged: (newStatus) async {
                              if (newStatus != null && newStatus != school.status) {
                                await ref.read(superadminRepositoryProvider).updateSchoolStatus(school.id, newStatus);
                                ref.invalidate(allSchoolsProvider);
                                ref.invalidate(platformStatsProvider);
                              }
                            },
                          )
                        ),
                      ]
                    )).toList(),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Text('Error: $e'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, {Color? color}) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (color ?? theme.colorScheme.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 32, color: color ?? theme.colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey.shade600)),
                  const SizedBox(height: 4),
                  Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'ACTIVE': color = Colors.green; break;
      case 'SUSPENDED': color = Colors.red; break;
      case 'TRIAL': color = Colors.orange; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
