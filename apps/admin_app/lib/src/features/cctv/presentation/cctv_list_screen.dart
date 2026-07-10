import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';

class CctvListScreen extends ConsumerWidget {
  const CctvListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camerasAsync = ref.watch(cctvCamerasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CCTV Cameras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Camera',
            onPressed: () {
              // MVP: In a real app, open a modal to add a camera.
              // We can pre-fill dummy data to test it for MVP.
              ref.read(cctvRepositoryProvider).addCamera({
                'name': 'Main Gate Camera',
                'location': 'Entrance',
                'streamUrl': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8', // Dummy HLS
              }).then((_) {
                ref.invalidate(cctvCamerasProvider);
              });
            },
          ),
        ],
      ),
      body: camerasAsync.when(
        data: (cameras) {
          if (cameras.isEmpty) {
            return const Center(child: Text('No CCTV Cameras found. Add one to start.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: cameras.length,
            itemBuilder: (context, index) {
              final camera = cameras[index];
              final isActive = camera.status == 'ACTIVE';
              
              return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    // Navigate to Player
                    context.push('/cctv/player', extra: camera);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.black87,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(Icons.videocam, color: Colors.white54, size: 64),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.green : Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isActive ? 'LIVE' : 'OFFLINE',
                                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(camera.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(camera.location, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
