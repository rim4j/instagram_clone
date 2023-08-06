import 'package:flutter/material.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColorsLight.backGround,
    primary: AppColorsLight.primary,
    onPrimary: AppColorsDark.grey,
    secondary: AppColorsLight.secondary,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: AppColorsDark.backGround,
    primary: AppColorsDark.primary,
    onPrimary: AppColorsDark.grey,
    secondary: AppColorsDark.secondary,
  ),
);
