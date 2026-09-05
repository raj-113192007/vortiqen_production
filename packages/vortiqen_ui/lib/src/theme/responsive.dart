import 'package:flutter/material.dart';

/// Screen Breakpoints standardized for VortiQen multi-platform UI
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < mobile;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobile && MediaQuery.of(context).size.width < tablet;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet && MediaQuery.of(context).size.width < desktop;
  static bool isWide(BuildContext context) => MediaQuery.of(context).size.width >= desktop;
  static bool isTabletOrDesktop(BuildContext context) => MediaQuery.of(context).size.width >= mobile;
}

/// Handy extensions on BuildContext for quick responsive logic
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isMobile => ResponsiveBreakpoints.isMobile(this);
  bool get isTablet => ResponsiveBreakpoints.isTablet(this);
  bool get isDesktop => ResponsiveBreakpoints.isDesktop(this);
  bool get isWide => ResponsiveBreakpoints.isWide(this);
  bool get isTabletOrDesktop => ResponsiveBreakpoints.isTabletOrDesktop(this);

  /// Select a value dynamically based on screen size
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? wide,
  }) {
    if (isWide && wide != null) return wide;
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Calculates responsive column counts for grids
  int responsiveGridCount({
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
    int wide = 4,
  }) {
    if (isWide) return wide;
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  /// Default standard responsive padding
  EdgeInsets get responsivePadding {
    if (isWide) return const EdgeInsets.symmetric(horizontal: 40, vertical: 24);
    if (isDesktop) return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    if (isTablet) return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  }
}

/// A container that centers content and enforces max-width constraints on wide screens
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth = 1320,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? context.responsivePadding;

    return Align(
      alignment: alignment,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: effectivePadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A Two-Pane layout that displays side-by-side on Tablets/Desktops and stacked on Mobile
class ResponsiveTwoPane extends StatelessWidget {
  final Widget leftPane;
  final Widget rightPane;
  final int leftFlex;
  final int rightFlex;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final double breakpoint;

  const ResponsiveTwoPane({
    super.key,
    required this.leftPane,
    required this.rightPane,
    this.leftFlex = 1,
    this.rightFlex = 1,
    this.spacing = 20,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.breakpoint = 840,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= breakpoint;

    if (isWide) {
      return Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Expanded(flex: leftFlex, child: leftPane),
          SizedBox(width: spacing),
          Expanded(flex: rightFlex, child: rightPane),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        leftPane,
        SizedBox(height: spacing),
        rightPane,
      ],
    );
  }
}

/// Adaptive modal helper that displays a bottom sheet on mobile and a centered dialog on tablets/desktop
class AdaptiveModal {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget title,
    required Widget content,
    List<Widget>? actions,
    double maxWidth = 560,
  }) {
    if (context.isTabletOrDesktop) {
      return showDialog<T>(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            backgroundColor: Colors.white,
            elevation: 8,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: title),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    content,
                    if (actions != null && actions.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: title),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(sheetContext),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              content,
              if (actions != null && actions.isNotEmpty) ...[
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: actions,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
