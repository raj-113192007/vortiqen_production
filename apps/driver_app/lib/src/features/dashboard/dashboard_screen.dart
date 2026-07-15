import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final driverVehicleAsync = ref.watch(driverTransportProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          )
        ],
      ),
      body: driverVehicleAsync.when(
        data: (vehicle) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.directions_bus, size: 32),
                          const SizedBox(width: 16),
                          Text('My Vehicle', style: theme.textTheme.titleLarge),
                        ],
                      ),
                      const Divider(height: 32),
                      _DetailRow('Plate Number', vehicle.plateNumber),
                      const SizedBox(height: 8),
                      _DetailRow('Capacity', '${vehicle.capacity} seats'),
                      if (vehicle.route != null) ...[
                        const SizedBox(height: 8),
                        _DetailRow('Assigned Route', vehicle.route!.name),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Assigned Students (${vehicle.students.length})', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              if (vehicle.students.isEmpty)
                const Center(child: Text('No students assigned yet.'))
              else
                ...vehicle.students.map((student) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person)),
                      title: Text('${student.firstName} ${student.lastName ?? ''}'),
                      subtitle: Text('Roll No: ${student.rollNo}'),
                    ),
                  );
                }),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('No vehicle assigned to you or an error occurred.')),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
