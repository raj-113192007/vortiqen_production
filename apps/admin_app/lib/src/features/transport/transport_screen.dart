import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

final adminVehiclesProvider = FutureProvider<List<Vehicle>>((ref) {
  return ref.watch(transportRepositoryProvider).getVehicles();
});

class TransportScreen extends ConsumerStatefulWidget {
  const TransportScreen({super.key});

  @override
  ConsumerState<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends ConsumerState<TransportScreen> {
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
                  'Transport Management',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Show add vehicle/route modal
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Vehicle'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Vehicles',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildVehiclesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildVehiclesList() {
    final vehiclesAsync = ref.watch(adminVehiclesProvider);

    return vehiclesAsync.when(
      data: (vehicles) {
        if (vehicles.isEmpty) {
          return const Center(child: Text('No vehicles found.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = vehicles[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.directions_bus),
                ),
                title: Text(vehicle.plateNumber),
                subtitle: Text('Capacity: ${vehicle.capacity}'),
                trailing: vehicle.driver != null 
                    ? Chip(label: Text(vehicle.driver!.name)) 
                    : const Chip(label: Text('Unassigned')),
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
