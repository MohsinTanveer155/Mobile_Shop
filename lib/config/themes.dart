import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.deepIndigo,
    onPrimary: Colors.white,
    secondary: AppColors.cyan,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
  ),
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.deepIndigo,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    iconTheme: IconThemeData(color: AppColors.deepIndigo),
    titleTextStyle: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.surface,
  ),
  cardTheme: CardThemeData(
    color: AppColors.surface,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.05),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.deepIndigo,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.deepIndigo,
      side: const BorderSide(color: AppColors.deepIndigo, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceAlt,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.deepIndigo, width: 1.8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    hintStyle: const TextStyle(color: AppColors.textSecondary),
    labelStyle: const TextStyle(color: AppColors.textSecondary),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.border,
    thickness: 1,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
    bodySmall: TextStyle(fontSize: 13, color: AppColors.textSecondary),
  ),
);

final ThemeData appDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.deepIndigo,
    onPrimary: Colors.white,
    secondary: AppColors.cyan,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkTextPrimary,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  primaryColor: AppColors.deepIndigo,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkTextPrimary,
    iconTheme: IconThemeData(color: AppColors.cyan),
    titleTextStyle: TextStyle(
      color: AppColors.darkTextPrimary,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.darkSurface,
  ),
  cardTheme: CardThemeData(
    color: AppColors.darkSurface,
    elevation: 2,
    shadowColor: Colors.black.withValues(alpha: 0.35),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: AppColors.cyan,
      foregroundColor: AppColors.darkTextPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: AppColors.cyan, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1F2641),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.cyan, width: 1.8),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    hintStyle: const TextStyle(color: AppColors.darkTextSecondary),
    labelStyle: const TextStyle(color: AppColors.darkTextSecondary),
  ),
  dividerTheme: const DividerThemeData(
    color: AppColors.darkBorder,
    thickness: 1,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: AppColors.darkTextPrimary),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary),
    bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
    bodySmall: TextStyle(fontSize: 13, color: AppColors.darkTextSecondary),
  ),
);
