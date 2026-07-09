import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppRole {
  director,
  student,
  teacher,
  admin,
}

class AppTheme {
  static ThemeData getTheme(AppRole role) {
    Color primaryColor;
    switch (role) {
      case AppRole.director:
        primaryColor = const Color(0xFFD4AF37); // Premium Gold
        break;
      case AppRole.student:
        primaryColor = const Color(0xFF2196F3); // Friendly Blue
        break;
      case AppRole.teacher:
        primaryColor = const Color(0xFF4CAF50); // Professional Green
        break;
      case AppRole.admin:
        primaryColor = const Color(0xFF9C27B0); // Deep Purple
        break;
    }

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          elevation: 0,
        ),
      ),
    );
  }
}
