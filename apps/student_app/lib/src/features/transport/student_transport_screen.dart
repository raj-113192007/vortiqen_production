import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class StudentTransportScreen extends ConsumerStatefulWidget {
  const StudentTransportScreen({super.key});

  @override
  ConsumerState<StudentTransportScreen> createState() => _StudentTransportScreenState();
}

class _StudentTransportScreenState extends ConsumerState<StudentTransportScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value?.user;
    if (user == null || user.schoolId == null) {
      return const Scaffold(body: Center(child: Text('No student profile found (user missing).')));
    }
    final studentProfileAsync = ref.watch(studentProfileProvider({
      'schoolId': user.schoolId,
      'userId': user.id,
    }));

    return studentProfileAsync.when(
      data: (studentProfile) {
        if (studentProfile == null) {
          return const Scaffold(body: Center(child: Text('No student profile found.')));
        }

        final transportAsync = ref.watch(studentTransportProvider(studentProfile.id));

        return transportAsync.when(
          data: (student) {
              if (student.route == null && student.vehicle == null) {
                return const Center(child: Text('You are not assigned to any transport.'));
              }

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              if (student.route != null)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.route),
                    title: const Text('Route'),
                    subtitle: Text(student.route!.name),
                  ),
                ),
              const SizedBox(height: 16),
              if (student.vehicle != null)
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
                            Text('Vehicle Details', style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        const Divider(height: 32),
                        _DetailRow('Plate Number', student.vehicle!.plateNumber),
                        if (student.vehicle!.driver != null) ...[
                          const SizedBox(height: 8),
                          _DetailRow('Driver Name', student.vehicle!.driver!.name),
                          if (student.vehicle!.driver!.phone != null) ...[
                            const SizedBox(height: 8),
                            _DetailRow('Driver Phone', student.vehicle!.driver!.phone!),
                          ],
                        ]
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
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
