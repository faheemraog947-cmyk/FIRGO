import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1E3A8A);
  static const Color secondaryColor = Color(0xFFFF6B35);
  static const Color accentColor = Color(0xFF00D9FF);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color successColor = Color(0xFF27AE60);
  static const Color warningColor = Color(0xFFF39C12);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textLight = Color(0xFF95A5A6);
  static const Color dividerColor = Color(0xFFECF0F1);
  static const Color white = Color(0xFFFFFFFF);

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _titleTextStyle.copyWith(color: white),
        iconTheme: const IconThemeData(color: white),
      ),
      textTheme: TextTheme(
        displayLarge: _displayLargeTextStyle,
        displayMedium: _displayMediumTextStyle,
        displaySmall: _displaySmallTextStyle,
        headlineLarge: _headlineLargeTextStyle,
        headlineMedium: _headlineMediumTextStyle,
        headlineSmall: _headlineSmallTextStyle,
        titleLarge: _titleTextStyle,
        bodyLarge: _bodyLargeTextStyle,
        bodyMedium: _bodyMediumTextStyle,
        labelSmall: _labelSmallTextStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: primaryColor),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        foregroundColor: white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _titleTextStyle.copyWith(color: white),
      ),
    );
  }

  // Text Styles
  static const TextStyle _displayLargeTextStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle _displayMediumTextStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle _displaySmallTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textDark,
  );

  static const TextStyle _headlineLargeTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle _headlineMediumTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle _headlineSmallTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle _titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textDark,
  );

  static const TextStyle _bodyLargeTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: textDark,
  );

  static const TextStyle _bodyMediumTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textDark,
  );

  static const TextStyle _labelSmallTextStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: textLight,
  );
}