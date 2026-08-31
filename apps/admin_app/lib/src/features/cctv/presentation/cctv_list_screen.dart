import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vortiqen_core/vortiqen_core.dart';
import 'package:vortiqen_ui/vortiqen_ui.dart';

class CctvListScreen extends ConsumerWidget {
  const CctvListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camerasAsync = ref.watch(cctvCamerasProvider);
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
            child: _buildHeader(context, ref),
          ),
          const SizedBox(height: 20),

          camerasAsync.when(
            data: (cameras) {
              final total = cameras.length;
              final active = cameras.where((c) => c.status == 'ACTIVE').length;
              final offline = total - active;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Surveillance KPIs
                  FadeSlideEntry(
                    delay: const Duration(milliseconds: 100),
                    child: _buildKpis(total, active, offline),
                  ),
                  const SizedBox(height: 24),

                  if (cameras.isEmpty)
                    _buildEmptyState(context, ref)
                  else
                    FadeSlideEntry(
                      delay: const Duration(milliseconds: 150),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final crossCount = constraints.maxWidth > 1100 ? 3 : (constraints.maxWidth > 650 ? 2 : 1);

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cameras.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossCount,
                              childAspectRatio: 1.25,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemBuilder: (context, index) {
                              final camera = cameras[index];
                              final isActive = camera.status == 'ACTIVE';

                              return HoverLiftCard(
                                onTap: () => context.push('/cctv/player', extra: camera),
                                padding: EdgeInsets.zero,
                                borderRadius: 16,
                                hoverBorderColor: isActive
                                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                    : const Color(0xFFEF4444).withValues(alpha: 0.4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF0F172A),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Icon(Icons.videocam_rounded, color: Color(0xFF475569), size: 54),
                                            Positioned(
                                              top: 12,
                                              right: 12,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: isActive
                                                      ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                                      : const Color(0xFFEF4444).withValues(alpha: 0.2),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: isActive
                                                        ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                                        : const Color(0xFFEF4444).withValues(alpha: 0.4),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    if (isActive) ...[
                                                      const PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFF10B981)),
                                                      const SizedBox(width: 6),
                                                    ],
                                                    Text(
                                                      isActive ? 'LIVE HLS' : 'OFFLINE',
                                                      style: TextStyle(
                                                        color: isActive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 12,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.black.withValues(alpha: 0.6),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: const Text('1080p • 30 FPS', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  camera.name,
                                                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF1E293B)),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Location: ${camera.location}',
                                                  style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(Icons.play_circle_fill_rounded, color: Color(0xFF6C5CE7), size: 28),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, WidgetRef ref) {
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
                'Campus Surveillance & CCTV Command Deck',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5),
              ),
              SizedBox(height: 4),
              Text(
                'Live HLS Feeds for School Gates, Corridors, Playground, Science Labs & Parking',
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
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    PulsingLiveDot(size: 5, pulseScale: 2.0, color: Color(0xFFEF4444)),
                    SizedBox(width: 6),
                    Text('REC LIVE 24/7', style: TextStyle(color: Color(0xFFEF4444), fontSize: 11, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(cctvRepositoryProvider).addCamera({
                    'name': 'Main Gate Entrance Feed',
                    'location': 'Front Gate & Security Desk',
                    'streamUrl': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
                  }).then((_) {
                    ref.invalidate(cctvCamerasProvider);
                  });
                },
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Add Camera Node'),
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

  Widget _buildKpis(int total, int active, int offline) {
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
            _buildMetricTile(total.toDouble(), 'Total Camera Nodes', Icons.videocam_outlined, const Color(0xFF6C5CE7), 'Campus Grid'),
            _buildMetricTile(active.toDouble(), 'Active Online Streams', Icons.stream_rounded, const Color(0xFF10B981), '1080p Streaming'),
            _buildMetricTile(offline.toDouble(), 'Offline / Maint Nodes', Icons.videocam_off_outlined, const Color(0xFFEF4444), 'Check IP link'),
            _buildMetricTile(100.0, 'NVR Storage Health', Icons.storage_rounded, const Color(0xFF0984E3), '30 Days Backup'),
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
                  suffix: label.contains('Health') ? '%' : '',
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

  Widget _buildEmptyState(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.videocam_off_outlined, size: 48, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            const Text('No CCTV Cameras Configured', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1E293B))),
            const SizedBox(height: 4),
            const Text('Click "Add Camera Node" to connect your school HLS stream feed.', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }
}
