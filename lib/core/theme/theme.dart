import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF070301);
  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xFFB3B3B3);
  static const accent = Color(0xFFFF0000);
  static const cardBackground = Color(0xFF1A1A1A);
}

class AppTheme {
  static final themeData = ThemeData(
    // primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      background: AppColors.background,
      onBackground: AppColors.primaryText,
      surface: AppColors.cardBackground,
      onSurface: AppColors.primaryText,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.apply(
            bodyColor: AppColors.primaryText,
            displayColor: AppColors.primaryText,
          ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.primaryText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.secondaryText,
    ),
  );
}