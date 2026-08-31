import 'package:flutter/material.dart';

class HoverLiftCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color? borderColor;
  final Color? hoverBorderColor;
  final double borderRadius;
  final double liftDistance;

  const HoverLiftCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.hoverBorderColor,
    this.borderRadius = 14,
    this.liftDistance = 3.0,
  });

  @override
  State<HoverLiftCard> createState() => _HoverLiftCardState();
}

class _HoverLiftCardState extends State<HoverLiftCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorder = _isHovered
        ? (widget.hoverBorderColor ?? const Color(0xFF4F46E5).withValues(alpha: 0.35))
        : (widget.borderColor ?? const Color(0xFFE2E8F0));

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -widget.liftDistance : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: effectiveBorder, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.06 : 0.02),
                blurRadius: _isHovered ? 14 : 6,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
