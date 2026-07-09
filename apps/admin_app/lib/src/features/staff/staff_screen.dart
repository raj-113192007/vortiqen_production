import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

final staffByRoleProvider = FutureProvider.family<List<User>, String>((ref, role) {
  return ref.watch(staffRepositoryProvider).getStaff('1', role: role);
});

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _roleFilter = 'TEACHER'; // Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Staff Management',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Show add staff modal
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Add Staff'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildFilterChip('Teachers', 'TEACHER'),
                const SizedBox(width: 8),
                _buildFilterChip('Drivers', 'DRIVER'),
                const SizedBox(width: 8),
                _buildFilterChip('Admins', 'ADMIN'),
              ],
            ),
            const SizedBox(height: 24),
            _buildStaffList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String role) {
    final isSelected = _roleFilter == role;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _roleFilter = role;
          });
        }
      },
    );
  }

  Widget _buildStaffList() {
    final staffAsync = ref.watch(staffByRoleProvider(_roleFilter));

    return staffAsync.when(
      data: (staffList) {
        if (staffList.isEmpty) {
          return const Center(child: Text('No staff found for this role.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: staffList.length,
          itemBuilder: (context, index) {
            final staff = staffList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(staff.name[0].toUpperCase()),
                ),
                title: Text(staff.name),
                subtitle: Text(staff.email ?? staff.username ?? 'No email/username'),
                trailing: Chip(label: Text(staff.role)),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
