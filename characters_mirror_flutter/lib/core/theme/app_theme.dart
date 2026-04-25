import 'package:flutter/material.dart';

final darkTheme = _buildTheme(darkColorScheme, darkGameColors);
final lightTheme = _buildTheme(lightColorScheme, lightGameColors);
final textTheme = _buildTextTheme(darkColorScheme);

ThemeData _buildTheme(ColorScheme colorScheme, AppGameColors gameColors) {
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.surface,
    textTheme: _buildTextTheme(colorScheme),
    extensions: [gameColors],
  );
}

ThemeData adaptThemeForWidth(ThemeData baseTheme, double width) {
  final scaleFactor = _typographyScaleForWidth(width);
  final scaledTextTheme = _scaleTextTheme(
    baseTheme.textTheme,
    scaleFactor,
  );
  final colorScheme = baseTheme.colorScheme;

  return baseTheme.copyWith(
    textTheme: scaledTextTheme,
    primaryTextTheme: _scaleTextTheme(
      baseTheme.primaryTextTheme,
      scaleFactor,
    ),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      titleTextStyle: scaledTextTheme.titleLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      toolbarTextStyle: scaledTextTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
      ),
    ),
    listTileTheme: baseTheme.listTileTheme.copyWith(
      titleTextStyle: scaledTextTheme.titleSmall,
      subtitleTextStyle: scaledTextTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
    ),
    chipTheme: baseTheme.chipTheme.copyWith(
      labelStyle: scaledTextTheme.labelLarge,
      secondaryLabelStyle: scaledTextTheme.labelLarge,
    ),
  );
}

final darkGameColors = AppGameColors(
  healing: Color(0xFF8CBF7A),
  onHealing: Color(0xFF16100A),
  healingOnDark: Color(0xFF8CBF7A),
  temporaryHitPoints: Color(0xFF7DAED6),
  onTemporaryHitPoints: Color(0xFF16100A),
  temporaryHitPointsOnDark: Color(0xFF7DAED6),
  damageOnDark: Color(0xFFE06A75),
);

final lightGameColors = AppGameColors(
  healing: Color(0xFF3F7D4A),
  onHealing: Color(0xFFFFFFFF),
  healingOnDark: Color(0xFF8CBF7A),
  temporaryHitPoints: Color(0xFF3F6F9F),
  onTemporaryHitPoints: Color(0xFFFFFFFF),
  temporaryHitPointsOnDark: Color(0xFF7DAED6),
  damageOnDark: Color(0xFFE06A75),
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Основные поверхности
  surface: Color(0xFF0F0F12),
  onSurface: Color(0xFFF0E6D2),
  onSurfaceVariant: Color(0xFFC7BBAA),
  surfaceDim: Color(0xFF0A0A06),
  surfaceBright: Color(0xFF1C1A16),
  surfaceContainerLowest: Color(0xFF0B0B0B),
  surfaceContainerLow: Color(0xFF111111),
  surfaceContainer: Color(0xFF131313),
  surfaceContainerHigh: Color(0xFF161618),
  surfaceContainerHighest: Color(0xFF1A1A1F),

  primary: Color(0xFFD4A568),
  onPrimary: Color(0xFF16100A),
  primaryContainer: Color(0xFF3A2A17),
  onPrimaryContainer: Color(0xFFF7D9A8),

  secondary: Color(0xFFB7A18B),
  onSecondary: Color(0xFF16100A),
  secondaryContainer: Color(0xFF2B2520),
  onSecondaryContainer: Color(0xFFE8DCC4),

  tertiary: Color(0xFFD05A66),
  onTertiary: Color(0xFF160607),
  tertiaryContainer: Color(0xFF451016),
  onTertiaryContainer: Color(0xFFFFDADD),

  // Ошибки / destructive
  error: Color(0xFFB83241),
  onError: Color(0xFFF0E6D2),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),

  // Контуры и вспомогательные
  outline: Color(0x33D4A568),
  outlineVariant: Color(0xFF958D7A),
  inverseSurface: Color(0xFFF0E6D2),
  onInverseSurface: Color(0xFF0F0F12),
  inversePrimary: Color(0xFF8A5A24),
  surfaceTint: Color(0xFFD4A568),

  shadow: Color(0x66000000),
  scrim: Color(0x66000000),
);

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Основные поверхности
  surface: Color(0xFFF5F1E8),
  onSurface: Color(0xFF2D2520),
  onSurfaceVariant: Color(0xFF6B5D52),
  surfaceDim: Color(0xFFEDE8DC),
  surfaceBright: Color(0xFFF5F1E8),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFE3D4B5),
  surfaceContainer: Color(0xFFF5F1E8),
  surfaceContainerHigh: Color(0xFFEDE8DC),
  surfaceContainerHighest: Color(0xFFFFFFFF),

  primary: Color(0xFF8A5A24),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFF1D2A1),
  onPrimaryContainer: Color(0xFF2D1B08),

  secondary: Color(0xFF6F5E4D),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DCC4),
  onSecondaryContainer: Color(0xFF251A10),

  tertiary: Color(0xFF9D2833),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDADD),
  onTertiaryContainer: Color(0xFF40000A),

  // Ошибки / destructive
  error: Color(0xFFC42837),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF410002),

  // Контуры и вспомогательные
  outline: Color(0x269D2833),
  outlineVariant: Color(0xFF6B5D52),
  inverseSurface: Color(0xFF2D2520),
  onInverseSurface: Color(0xFFF5F1E8),
  inversePrimary: Color(0xFFD4A568),
  surfaceTint: Color(0xFF8A5A24),

  shadow: Color(0x33000000),
  scrim: Color(0x33000000),
);

TextTheme _buildTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    // Display styles - крупнейший текст
    displayLarge: TextStyle(
      color: colorScheme.primary,
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      color: colorScheme.primary,
      fontSize: 45,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: colorScheme.primary,
      fontSize: 36,
      fontWeight: FontWeight.w400,
    ),

    // Headline styles - крупные заголовки
    headlineLarge: TextStyle(
      color: colorScheme.primary,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    headlineMedium: TextStyle(
      color: colorScheme.primary,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      color: colorScheme.primary,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),

    // Title styles - заголовки среднего размера
    titleLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),

    // Body styles - основной текст
    bodyLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      color: colorScheme.onSurfaceVariant,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),

    // Label styles - метки, кнопки и т.д.
    labelLarge: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      color: colorScheme.onSurface,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      color: colorScheme.onSurfaceVariant,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );
}

double _typographyScaleForWidth(double width) {
  if (width < 360) {
    return 0.92;
  }
  if (width < 600) {
    return 1.0;
  }
  if (width < 840) {
    return 1.08;
  }
  if (width < 1200) {
    return 1.14;
  }
  return 1.2;
}

TextTheme _scaleTextTheme(TextTheme textTheme, double factor) {
  return textTheme.copyWith(
    displayLarge: _scaleTextStyle(textTheme.displayLarge, factor),
    displayMedium: _scaleTextStyle(textTheme.displayMedium, factor),
    displaySmall: _scaleTextStyle(textTheme.displaySmall, factor),
    headlineLarge: _scaleTextStyle(textTheme.headlineLarge, factor),
    headlineMedium: _scaleTextStyle(textTheme.headlineMedium, factor),
    headlineSmall: _scaleTextStyle(textTheme.headlineSmall, factor),
    titleLarge: _scaleTextStyle(textTheme.titleLarge, factor),
    titleMedium: _scaleTextStyle(textTheme.titleMedium, factor),
    titleSmall: _scaleTextStyle(textTheme.titleSmall, factor),
    bodyLarge: _scaleTextStyle(textTheme.bodyLarge, factor),
    bodyMedium: _scaleTextStyle(textTheme.bodyMedium, factor),
    bodySmall: _scaleTextStyle(textTheme.bodySmall, factor),
    labelLarge: _scaleTextStyle(textTheme.labelLarge, factor),
    labelMedium: _scaleTextStyle(textTheme.labelMedium, factor),
    labelSmall: _scaleTextStyle(textTheme.labelSmall, factor),
  );
}

TextStyle? _scaleTextStyle(TextStyle? style, double factor) {
  if (style == null || style.fontSize == null || factor == 1.0) {
    return style;
  }

  return style.copyWith(
    fontSize: style.fontSize! * factor,
  );
}

class AppGameColors extends ThemeExtension<AppGameColors> {
  const AppGameColors({
    required this.healing,
    required this.onHealing,
    required this.healingOnDark,
    required this.temporaryHitPoints,
    required this.onTemporaryHitPoints,
    required this.temporaryHitPointsOnDark,
    required this.damageOnDark,
  });

  final Color healing;
  final Color onHealing;
  final Color healingOnDark;
  final Color temporaryHitPoints;
  final Color onTemporaryHitPoints;
  final Color temporaryHitPointsOnDark;
  final Color damageOnDark;

  static AppGameColors of(BuildContext context) {
    return Theme.of(context).extension<AppGameColors>() ?? darkGameColors;
  }

  @override
  AppGameColors copyWith({
    Color? healing,
    Color? onHealing,
    Color? healingOnDark,
    Color? temporaryHitPoints,
    Color? onTemporaryHitPoints,
    Color? temporaryHitPointsOnDark,
    Color? damageOnDark,
  }) {
    return AppGameColors(
      healing: healing ?? this.healing,
      onHealing: onHealing ?? this.onHealing,
      healingOnDark: healingOnDark ?? this.healingOnDark,
      temporaryHitPoints: temporaryHitPoints ?? this.temporaryHitPoints,
      onTemporaryHitPoints: onTemporaryHitPoints ?? this.onTemporaryHitPoints,
      temporaryHitPointsOnDark:
          temporaryHitPointsOnDark ?? this.temporaryHitPointsOnDark,
      damageOnDark: damageOnDark ?? this.damageOnDark,
    );
  }

  @override
  AppGameColors lerp(ThemeExtension<AppGameColors>? other, double t) {
    if (other is! AppGameColors) {
      return this;
    }

    return AppGameColors(
      healing: Color.lerp(healing, other.healing, t)!,
      onHealing: Color.lerp(onHealing, other.onHealing, t)!,
      healingOnDark: Color.lerp(healingOnDark, other.healingOnDark, t)!,
      temporaryHitPoints:
          Color.lerp(temporaryHitPoints, other.temporaryHitPoints, t)!,
      onTemporaryHitPoints:
          Color.lerp(onTemporaryHitPoints, other.onTemporaryHitPoints, t)!,
      temporaryHitPointsOnDark: Color.lerp(
        temporaryHitPointsOnDark,
        other.temporaryHitPointsOnDark,
        t,
      )!,
      damageOnDark: Color.lerp(damageOnDark, other.damageOnDark, t)!,
    );
  }
}
