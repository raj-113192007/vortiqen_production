import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/inventory_provider.dart';

class InventoryListScreen extends ConsumerWidget {
  const InventoryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryState = ref.watch(inventoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory & Asset Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/inventory/new'),
            tooltip: 'Add New Asset',
          ),
        ],
      ),
      body: inventoryState.when(
        data: (assets) {
          if (assets.isEmpty) {
            return const Center(child: Text('No assets found.'));
          }
          return ListView.builder(
            itemCount: assets.length,
            itemBuilder: (context, index) {
              final asset = assets[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(asset.status),
                    child: Icon(_getStatusIcon(asset.status), color: Colors.white),
                  ),
                  title: Text(asset.name),
                  subtitle: Text('SKU: ${asset.sku ?? "N/A"} • Status: ${asset.status}'),
                  trailing: asset.status == 'AVAILABLE'
                      ? ElevatedButton(
                          onPressed: () => _showAssignDialog(context, ref, asset.id),
                          child: const Text('Assign'),
                        )
                      : TextButton(
                          onPressed: () => _checkInAsset(context, ref, asset.id),
                          child: const Text('Check In'),
                        ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'AVAILABLE':
        return Colors.green;
      case 'ASSIGNED':
        return Colors.blue;
      case 'MAINTENANCE':
        return Colors.orange;
      case 'RETIRED':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'AVAILABLE':
        return Icons.check_circle;
      case 'ASSIGNED':
        return Icons.person;
      case 'MAINTENANCE':
        return Icons.build;
      case 'RETIRED':
        return Icons.delete;
      default:
        return Icons.inventory;
    }
  }

  void _showAssignDialog(BuildContext context, WidgetRef ref, String assetId) {
    final userIdController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Assign Asset'),
        content: TextField(
          controller: userIdController,
          decoration: const InputDecoration(labelText: 'User ID to assign to'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(inventoryProvider.notifier).assignAsset(assetId, {
                'action': 'CHECK_OUT',
                'userId': userIdController.text,
              });
              Navigator.pop(context);
            },
            child: const Text('Assign'),
          ),
        ],
      ),
    );
  }

  void _checkInAsset(BuildContext context, WidgetRef ref, String assetId) {
    ref.read(inventoryProvider.notifier).assignAsset(assetId, {
      'action': 'CHECK_IN',
      'userId': null,
    });
  }
}
