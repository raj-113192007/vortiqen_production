import 'package:flutter/material.dart';

class AnimatedMetricCounter extends StatelessWidget {
  final double targetValue;
  final String prefix;
  final String suffix;
  final int fractionDigits;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;

  const AnimatedMetricCounter({
    super.key,
    required this.targetValue,
    this.prefix = '',
    this.suffix = '',
    this.fractionDigits = 0,
    this.style,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetValue),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        final formatted = fractionDigits == 0
            ? value.toInt().toString().replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},',
                )
            : value.toStringAsFixed(fractionDigits);
        return Text(
          '$prefix$formatted$suffix',
          style: style,
        );
      },
    );
  }
}
