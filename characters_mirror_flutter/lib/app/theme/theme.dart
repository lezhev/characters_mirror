import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      color: darkColorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24,
      color: lightColorScheme.primary,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Основные поверхности
  surface: Color(0xFF0F0F12),
  onSurface: Color(0xFFF0E6D2),
  surfaceDim: Color(0xFF0F0F12),
  surfaceBright: Color(0xFF1F1F26),
  surfaceContainerLowest: Color(0xFF0F0F12),
  surfaceContainerLow: Color(0xFF2A2A35),
  surfaceContainer: Color(0xFF252530),
  surfaceContainerHigh: Color(0xFF1F1F26),
  surfaceContainerHighest: Color(0xFF1A1A1F),

  primary: Color(0xFFD4A568),
  onPrimary: Color(0xFF0F0F12),
  secondary: Color(0xFF2A2A35),
  onSecondary: Color(0xFFF0E6D2),

  tertiary: Color(0xFFB83241),
  onTertiary: Color(0xFFF0E6D2),

  // Ошибки / destructive
  error: Color(0xFFB83241),
  onError: Color(0xFFF0E6D2),

  // Контуры и вспомогательные
  outline: Color(0x33D4A568), // border
  outlineVariant: Color(0xFF958D7A),
  inverseSurface: Color(0xFFF0E6D2),
  onInverseSurface: Color(0xFF0F0F12),

  shadow: Color(0x66000000),
  scrim: Color(0x66000000),
);

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Основные поверхности
  surface: Color(0xFFF5F1E8), // card
  onSurface: Color(0xFF2D2520), // card-foreground
  surfaceDim: Color(0xFFEDE8DC), // muted
  surfaceBright: Color(0xFFF5F1E8), // background
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFE3D4B5), // secondary
  surfaceContainer: Color(0xFFF5F1E8),
  surfaceContainerHigh: Color(0xFFEDE8DC),
  surfaceContainerHighest: Color(0xFFFFFFFF),

  primary: Color(0xFFC9975B),
  onPrimary: Color(0xFF2D2520),
  secondary: Color(0xFFE8DCC4),
  onSecondary: Color(0xFF2D2520),

  tertiary: Color(0xFF9D2833),
  onTertiary: Color(0xFFFFFFFF),

  // Ошибки / destructive
  error: Color(0xFFC42837),
  onError: Color(0xFFFFFFFF),

  // Контуры и вспомогательные
  outline: Color(0x269D2833), // border
  outlineVariant: Color(0xFF6B5D52), // muted-foreground
  inverseSurface: Color(0xFF2D2520),
  onInverseSurface: Color(0xFFF5F1E8),

  shadow: Color(0x33000000),
  scrim: Color(0x33000000),
);
