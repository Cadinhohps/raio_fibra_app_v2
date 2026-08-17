import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFFFF7A00); // laranja principal
  static const secondaryBlue = Color(0xFFFFA726); // laranja claro
  static const orange = Color(0xFFFF6A00); // laranja forte

  static const black = Color(0xFF111111);
  static const dark = Color(0xFF1C1208);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFFFF3E0); // fundo laranja claro

  static const success = Color(0xFF00A86B);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Arial',
      scaffoldBackgroundColor: AppColors.lightGray,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondaryBlue),
      useMaterial3: true,
    );
  }
}
