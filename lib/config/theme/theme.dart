import 'package:flutter/material.dart';
import 'package:instagram_clone/config/theme/app_colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: AppColorsLight.backGround,
    primary: AppColorsLight.primary,
    onPrimary: AppColorsDark.grey,
    secondary: AppColorsLight.secondary,
    onSecondary: AppColorsLight.primary,
    onSecondaryContainer: AppColorsLight.grey2,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: AppColorsDark.backGround,
    primary: AppColorsDark.primary,
    onPrimary: AppColorsDark.grey,
    secondary: AppColorsDark.secondary,
    onSecondary: AppColorsDark.grey,
    onSecondaryContainer: AppColorsDark.primary,
  ),
);
