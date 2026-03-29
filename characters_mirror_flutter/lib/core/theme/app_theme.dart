import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    colorScheme: darkColorScheme, useMaterial3: true, textTheme: textTheme);

final lightTheme = ThemeData(
    colorScheme: lightColorScheme, useMaterial3: true, textTheme: textTheme);
final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Основные поверхности
  surface: Color(0xFF0F0F12), // базовый фон — нейтрально тёмный
  onSurface: Color(0xFFF0E6D2), // тёплый светлый текст
  surfaceDim: Color(0xFF0A0A06), // чуть темнее для фона навигации или теней
  surfaceBright: Color(0xFF1C1A16),
  surfaceContainerLowest: Color(0xFF0B0B0B),
  surfaceContainerLow: Color(0xFF111111),
  surfaceContainer: Color(0xFF131313),
  surfaceContainerHigh: Color(0xFF161618),
  surfaceContainerHighest: Color(0xFF1A1A1F),

  primary: Color(0xFFD4A568),
  onPrimary: Color(0xFF0F0F12),
  secondary: Color(0xFF9E8E7C),
  onSecondary: Color(0xFF0F0F12),

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

final textTheme = TextTheme(
  // Display styles - крупнейший текст
  displayLarge: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 45,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 36,
    fontWeight: FontWeight.w400,
  ),

  // Headline styles - крупные заголовки
  headlineLarge: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 32,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 28,
    fontWeight: FontWeight.w400,
  ),
  headlineSmall: TextStyle(
    color: darkColorScheme.primary,
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),

  // Title styles - заголовки среднего размера
  titleLarge: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 22,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleSmall: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),

  // Body styles - основной текст
  bodyLarge: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    color: darkColorScheme.onSurfaceVariant,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),

  // Label styles - метки, кнопки и т.д.
  labelLarge: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    color: darkColorScheme.onSurface,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    color: darkColorScheme.onSurfaceVariant,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
);
