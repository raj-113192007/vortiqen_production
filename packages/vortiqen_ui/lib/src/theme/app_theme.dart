import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppRole {
  director,
  student,
  teacher,
  admin,
  parent,
  driver,
  superAdmin,
}

class AppColors {
  // Admin: Royal Indigo & Electric Violet
  static const adminPrimary = Color(0xFF6C5CE7);
  static const adminAccent = Color(0xFFA29BFE);
  static const adminGradient = [Color(0xFF6C5CE7), Color(0xFF8E44AD)];

  // Teacher: Emerald Teal & Mint
  static const teacherPrimary = Color(0xFF00B894);
  static const teacherAccent = Color(0xFF55EFC4);
  static const teacherGradient = [Color(0xFF00B894), Color(0xFF00CEC9)];

  // Student: Electric Cyan & Sky Blue
  static const studentPrimary = Color(0xFF0984E3);
  static const studentAccent = Color(0xFF74B9FF);
  static const studentGradient = [Color(0xFF0984E3), Color(0xFF00CEC9)];

  // Parent: Sunset Coral & Amber Gold
  static const parentPrimary = Color(0xFFFF7675);
  static const parentAccent = Color(0xFFFAB1A0);
  static const parentGradient = [Color(0xFFFF7675), Color(0xFFF39C12)];

  // Driver: High-Visibility Cyber Amber
  static const driverPrimary = Color(0xFFF39C12);
  static const driverAccent = Color(0xFFF1C40F);
  static const driverGradient = [Color(0xFFF39C12), Color(0xFFE67E22)];

  // Director: Luxe Obsidian & Royal Gold
  static const directorPrimary = Color(0xFFD4AF37);
  static const directorAccent = Color(0xFFF9E79F);
  static const directorGradient = [Color(0xFFD4AF37), Color(0xFF1E293B)];

  // SuperAdmin: Crimson Ruby & Slate
  static const superAdminPrimary = Color(0xFFE84393);
  static const superAdminAccent = Color(0xFFFD79A8);
  static const superAdminGradient = [Color(0xFFE84393), Color(0xFFD63031)];
}

class AppTheme {
  static Color getPrimaryColor(AppRole role) {
    switch (role) {
      case AppRole.admin:
        return AppColors.adminPrimary;
      case AppRole.teacher:
        return AppColors.teacherPrimary;
      case AppRole.student:
        return AppColors.studentPrimary;
      case AppRole.parent:
        return AppColors.parentPrimary;
      case AppRole.driver:
        return AppColors.driverPrimary;
      case AppRole.director:
        return AppColors.directorPrimary;
      case AppRole.superAdmin:
        return AppColors.superAdminPrimary;
    }
  }

  static List<Color> getGradient(AppRole role) {
    switch (role) {
      case AppRole.admin:
        return AppColors.adminGradient;
      case AppRole.teacher:
        return AppColors.teacherGradient;
      case AppRole.student:
        return AppColors.studentGradient;
      case AppRole.parent:
        return AppColors.parentGradient;
      case AppRole.driver:
        return AppColors.driverGradient;
      case AppRole.director:
        return AppColors.directorGradient;
      case AppRole.superAdmin:
        return AppColors.superAdminGradient;
    }
  }

  static ThemeData getTheme(AppRole role, {bool isDark = false}) {
    final primaryColor = getPrimaryColor(role);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primaryColor,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      textTheme: GoogleFonts.interTextTheme(
        isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: primaryColor.withOpacity(0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          elevation: 3,
          shadowColor: primaryColor.withOpacity(0.3),
        ),
      ),
    );
  }
}
