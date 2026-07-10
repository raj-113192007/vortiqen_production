import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_layout.dart';
import '../schools/onboard_school_modal.dart';
import '../academics/academics_screen.dart';
import '../staff/staff_screen.dart';
import '../students/students_screen.dart';
import '../transport/transport_screen.dart';
import '../attendance/attendance_screen.dart';
import '../fees/fees_screen.dart';
import '../inventory/presentation/inventory_list_screen.dart';
import '../analytics/presentation/analytics_dashboard_screen.dart';
import '../cctv/presentation/cctv_list_screen.dart';
import '../exams/presentation/exams_list_screen.dart';
import '../hr/presentation/hr_dashboard_screen.dart';
import '../chat/presentation/chat_list_screen.dart';
import '../admissions/admissions_list_screen.dart';
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_selectedIndex) {
      case 0:
        content = _buildOverview(context);
        break;
      case 2:
        content = const StaffScreen();
        break;
      case 3:
        content = const AcademicsScreen();
        break;
      case 4:
        content = const StudentsScreen();
        break;
      case 5:
        content = const TransportScreen();
        break;
      case 6:
        content = const AttendanceScreen();
        break;
      case 7:
        content = const FeesScreen();
        break;
      case 8:
        content = const AdmissionsListScreen();
        break;
      case 9:
        content = const InventoryListScreen();
        break;
      case 10:
        content = const ExamsListScreen();
        break;
      case 11:
        content = const HrDashboardScreen();
        break;
      case 12:
        content = const ChatListScreen();
        break;
      case 13:
        content = const AnalyticsDashboardScreen();
        break;
      case 14:
        content = const CctvListScreen();
        break;
      default:
        content = Center(
          child: Text(
            'Coming Soon',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white54),
          ),
        );
    }

    return DashboardLayout(
      selectedIndex: _selectedIndex,
      onItemSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: content,
    );
  }

  Widget _buildOverview(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Logout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(authProvider.notifier).logout();
                  context.go('/login');
                },
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Stat Cards Row
          Row(
            children: [
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final schoolsAsync = ref.watch(schoolsProvider);
                    return schoolsAsync.when(
                      data: (schools) => _buildStatCard(
                        context,
                        title: 'Total Schools',
                        value: '${schools.length}',
                        icon: Icons.apartment,
                        trend: '+1',
                        isPositive: true,
                      ),
                      loading: () => _buildStatCard(
                        context,
                        title: 'Total Schools',
                        value: '...',
                        icon: Icons.apartment,
                        trend: '',
                        isPositive: true,
                      ),
                      error: (err, stack) => _buildStatCard(
                        context,
                        title: 'Total Schools',
                        value: 'Error',
                        icon: Icons.error,
                        trend: '',
                        isPositive: false,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Active Users',
                  value: '24.5k',
                  icon: Icons.group,
                  trend: '+5.4%',
                  isPositive: true,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Monthly Revenue',
                  value: '\$124.5k',
                  icon: Icons.account_balance_wallet,
                  trend: '+18.2%',
                  isPositive: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Charts and Quick Actions Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Revenue Chart
              Expanded(
                flex: 2,
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue Overview',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 300,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                              bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(0, 3),
                                  FlSpot(1, 4),
                                  FlSpot(2, 3.5),
                                  FlSpot(3, 5),
                                  FlSpot(4, 4.5),
                                  FlSpot(5, 6),
                                  FlSpot(6, 7),
                                ],
                                isCurved: true,
                                color: Theme.of(context).colorScheme.primary,
                                barWidth: 4,
                                isStrokeCapRound: true,
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              
              // Quick Actions
              Expanded(
                flex: 1,
                child: GlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildQuickActionBtn(
                        context, 
                        icon: Icons.add_circle_outline, 
                        label: 'Onboard New School',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const OnboardSchoolModal(),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildQuickActionBtn(
                        context, 
                        icon: Icons.campaign, 
                        label: 'Send Announcement',
                      ),
                      const SizedBox(height: 16),
                      _buildQuickActionBtn(
                        context, 
                        icon: Icons.table_chart, 
                        label: 'Export Monthly Report',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required String trend,
    required bool isPositive,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return HoverableGlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colorScheme.primary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up : Icons.trending_down,
                      color: isPositive ? Colors.green : Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionBtn(BuildContext context, {required IconData icon, required String label, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}

// GlassCard Widget
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// Custom Hoverable widget for GlassCard
class HoverableGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;

  const HoverableGlassCard({super.key, required this.child, required this.padding});

  @override
  State<HoverableGlassCard> createState() => _HoverableGlassCardState();
}

class _HoverableGlassCardState extends State<HoverableGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: GlassCard(
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

