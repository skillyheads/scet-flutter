import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primaryBlue = Colors.blue;
  static const MaterialColor primaryPurple = Colors.purple;
  static const MaterialColor primaryGreen = Colors.green;
  static const MaterialColor primaryOrange = Colors.orange;
  static const MaterialColor primaryRed = Colors.red;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: primaryBlue),
        titleTextStyle: TextStyle(
          color: primaryBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class AppColors {
  static const Color cardGradientStart = Colors.white;
  static final Color cardGradientEnd = Colors.blue.withOpacity(0.1);

  static final Color nameColor = Colors.purple.shade700;
  static final Color phoneColor = Colors.green.shade700;
  static final Color avatarBorder = Colors.blue.shade200;
  static final Color avatarBackground = Colors.blue.shade100;
  static final Color avatarText = Colors.blue.shade700;
  static final Color arrowIcon = Colors.blue.shade400;

  // Form colors - using MaterialColor for shade access
  static const MaterialColor addFormAccent = Colors.blue;
  static const MaterialColor editFormAccent = Colors.orange;
  static const MaterialColor deleteAccent = Colors.red;
  static const MaterialColor nameFieldColor = Colors.purple;
  static const MaterialColor phoneFieldColor = Colors.green;
}
