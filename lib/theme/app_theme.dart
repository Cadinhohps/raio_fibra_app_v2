import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFF071B52);
  static const secondaryBlue = Color(0xFF123FCB);
  static const orange = Color(0xFFFF6A00);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFF4F7FB);
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
