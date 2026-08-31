import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import '../application/inventory_provider.dart';

class InventoryListScreen extends ConsumerStatefulWidget {
  const InventoryListScreen({super.key});

  @override
  ConsumerState<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends ConsumerState<InventoryListScreen> {
  String _selectedStatus = 'ALL';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final inventoryState = ref.watch(inventoryProvider);
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

          inventoryState.when(
            data: (assets) {
              final total = assets.length;
              final available = assets.where((a) => a.status == 'AVAILABLE').length;
              final assigned = assets.where((a) => a.status == 'ASSIGNED').length;
              final maintenance = assets.where((a) => a.status == 'MAINTENANCE').length;

              final filtered = assets.where((a) {
                final matchesStatus = _selectedStatus == 'ALL' || a.status == _selectedStatus;
                final q = _searchQuery.toLowerCase();
                final matchesQuery = q.isEmpty ||
                    a.name.toLowerCase().contains(q) ||
                    (a.sku ?? '').toLowerCase().contains(q);
                return matchesStatus && matchesQuery;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Summary KPIs
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 100),
                    child: _buildKpis(total, available, assigned, maintenance),
                  ),
                  const SizedBox(height: 20),

                  // 3. Search & Filter Bar
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 150),
                    child: _buildSearchAndFilters(),
                  ),
                  const SizedBox(height: 16),

                  // 4. Asset Cards List
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
                          final asset = filtered[index];
                          final statusColor = _getStatusColor(asset.status);
                          final isAvailable = asset.status == 'AVAILABLE';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: HoverLiftCard(
                              padding: const EdgeInsets.all(16),
                              borderRadius: 14,
                              hoverBorderColor: statusColor.withValues(alpha: 0.35),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: statusColor.withValues(alpha: 0.12),
                                    child: Icon(_getStatusIcon(asset.status), color: statusColor, size: 20),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          asset.name,
                                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1E293B)),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'SKU: ${asset.sku ?? "N/A"} • Category: Campus Equipment',
                                          style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: statusColor.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          asset.status,
                                          style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 11),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      if (isAvailable)
                                        ElevatedButton(
                                          onPressed: () => _showAssignDialog(context, ref, asset.id),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF6C5CE7),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            elevation: 0,
                                          ),
                                          child: const Text('Assign', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                        )
                                      else
                                        OutlinedButton(
                                          onPressed: () => _checkInAsset(context, ref, asset.id),
                                          style: OutlinedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          child: const Text('Check In', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                                        ),
                                    ],
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
            loading: () => const Padding(
              padding: EdgeInsets.all(48.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
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
                'Campus Inventory & Asset Management',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Track High-Value School Assets, Lab Gear, Class IT Infrastructure & Maintenance Requests',
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
                    Text('ASSET TRACKER ACTIVE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => context.push('/inventory/new'),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add New Asset'),
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

  Widget _buildKpis(int total, int available, int assigned, int maintenance) {
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
            _buildMetricTile(total.toDouble(), 'Total Assets', Icons.inventory_2_outlined, const Color(0xFF6C5CE7), 'Campus Registry'),
            _buildMetricTile(available.toDouble(), 'Available in Stock', Icons.check_circle_outline_rounded, const Color(0xFF10B981), 'Ready to assign'),
            _buildMetricTile(assigned.toDouble(), 'Currently Assigned', Icons.person_pin_outlined, const Color(0xFF0984E3), 'In Active Use'),
            _buildMetricTile(maintenance.toDouble(), 'Under Repair / Service', Icons.build_circle_outlined, const Color(0xFFF59E0B), 'Service Tickets'),
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
      {'label': 'All Assets', 'key': 'ALL'},
      {'label': 'Available', 'key': 'AVAILABLE'},
      {'label': 'Assigned', 'key': 'ASSIGNED'},
      {'label': 'Maintenance', 'key': 'MAINTENANCE'},
      {'label': 'Retired', 'key': 'RETIRED'},
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
              hintText: 'Search asset by Name, SKU, Serial Number, or Department...',
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
            Icon(Icons.inventory_2_outlined, size: 48, color: Color(0xFF94A3B8)),
            SizedBox(height: 12),
            Text('No Assets Found in Inventory', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            SizedBox(height: 4),
            Text('No equipment items match the current search or category filter.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'AVAILABLE':
        return const Color(0xFF10B981);
      case 'ASSIGNED':
        return const Color(0xFF0984E3);
      case 'MAINTENANCE':
        return const Color(0xFFF59E0B);
      case 'RETIRED':
        return const Color(0xFF64748B);
      default:
        return const Color(0xFF6C5CE7);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'AVAILABLE':
        return Icons.check_circle_outline_rounded;
      case 'ASSIGNED':
        return Icons.person_outline_rounded;
      case 'MAINTENANCE':
        return Icons.build_circle_outlined;
      case 'RETIRED':
        return Icons.delete_outline_rounded;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  void _showAssignDialog(BuildContext context, WidgetRef ref, String assetId) {
    final userIdController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Assign Asset to Staff / Lab', style: TextStyle(fontWeight: FontWeight.w800)),
        content: TextField(
          controller: userIdController,
          decoration: InputDecoration(
            labelText: 'User ID / Staff Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (userIdController.text.isNotEmpty) {
                await ref.read(inventoryProvider.notifier).checkOutAsset(
                      assetId: assetId,
                      userId: userIdController.text,
                    );
                if (context.mounted) Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirm Assignment'),
          ),
        ],
      ),
    );
  }

  void _checkInAsset(BuildContext context, WidgetRef ref, String assetId) async {
    await ref.read(inventoryProvider.notifier).checkInAsset(assetId: assetId);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Asset successfully checked back in to inventory!')));
    }
  }
}
