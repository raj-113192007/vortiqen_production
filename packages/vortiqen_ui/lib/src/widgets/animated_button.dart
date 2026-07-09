import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    )
    .animate(onPlay: (controller) => controller.repeat(reverse: true))
    .shimmer(duration: 2000.ms, color: Colors.white24)
    .animate()
    .scaleXY(begin: 0.95, end: 1.0, duration: 400.ms, curve: Curves.easeOut);
  }
}
