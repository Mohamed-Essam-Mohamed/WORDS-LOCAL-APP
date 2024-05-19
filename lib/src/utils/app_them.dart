import 'package:app_english/src/utils/app_colors.dart';
import 'package:app_english/src/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blackColor,
      titleTextStyle: AppTextStyle.textStyle26,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
  );
}
