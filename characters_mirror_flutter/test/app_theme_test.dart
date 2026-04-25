import 'dart:math' as math;

import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App themes', () {
    test('key ColorScheme pairs meet text contrast requirements', () {
      for (final scheme in [darkColorScheme, lightColorScheme]) {
        final pairs = <String, ({Color background, Color foreground})>{
          'surface/onSurface': (
            background: scheme.surface,
            foreground: scheme.onSurface,
          ),
          'surface/onSurfaceVariant': (
            background: scheme.surface,
            foreground: scheme.onSurfaceVariant,
          ),
          'primary/onPrimary': (
            background: scheme.primary,
            foreground: scheme.onPrimary,
          ),
          'primaryContainer/onPrimaryContainer': (
            background: scheme.primaryContainer,
            foreground: scheme.onPrimaryContainer,
          ),
          'secondary/onSecondary': (
            background: scheme.secondary,
            foreground: scheme.onSecondary,
          ),
          'error/onError': (
            background: scheme.error,
            foreground: scheme.onError,
          ),
        };

        for (final entry in pairs.entries) {
          expect(
            _contrastRatio(
              entry.value.background,
              entry.value.foreground,
            ),
            greaterThanOrEqualTo(4.5),
            reason: '${scheme.brightness} ${entry.key}',
          );
        }
      }
    });

    test('light theme text colors come from light ColorScheme', () {
      expect(
          lightTheme.textTheme.bodyMedium?.color, lightColorScheme.onSurface);
      expect(
        lightTheme.textTheme.bodySmall?.color,
        lightColorScheme.onSurfaceVariant,
      );
      expect(
        lightTheme.textTheme.headlineMedium?.color,
        lightColorScheme.primary,
      );
    });

    test('game color pairs meet text contrast requirements', () {
      final pairs = <String, ({Color background, Color foreground})>{
        'dark healing/onHealing': (
          background: darkGameColors.healing,
          foreground: darkGameColors.onHealing,
        ),
        'dark action/healingOnDark': (
          background: darkColorScheme.surfaceContainerHighest,
          foreground: darkGameColors.healingOnDark,
        ),
        'dark temporaryHitPoints/onTemporaryHitPoints': (
          background: darkGameColors.temporaryHitPoints,
          foreground: darkGameColors.onTemporaryHitPoints,
        ),
        'dark action/temporaryHitPointsOnDark': (
          background: darkColorScheme.surfaceContainerHighest,
          foreground: darkGameColors.temporaryHitPointsOnDark,
        ),
        'dark action/damageOnDark': (
          background: darkColorScheme.surfaceContainerHighest,
          foreground: darkGameColors.damageOnDark,
        ),
        'light healing/onHealing': (
          background: lightGameColors.healing,
          foreground: lightGameColors.onHealing,
        ),
        'light action/healingOnDark': (
          background: lightColorScheme.inverseSurface,
          foreground: lightGameColors.healingOnDark,
        ),
        'light temporaryHitPoints/onTemporaryHitPoints': (
          background: lightGameColors.temporaryHitPoints,
          foreground: lightGameColors.onTemporaryHitPoints,
        ),
        'light action/temporaryHitPointsOnDark': (
          background: lightColorScheme.inverseSurface,
          foreground: lightGameColors.temporaryHitPointsOnDark,
        ),
        'light action/damageOnDark': (
          background: lightColorScheme.inverseSurface,
          foreground: lightGameColors.damageOnDark,
        ),
      };

      for (final entry in pairs.entries) {
        expect(
          _contrastRatio(
            entry.value.background,
            entry.value.foreground,
          ),
          greaterThanOrEqualTo(4.5),
          reason: entry.key,
        );
      }
    });

    test('adaptive theme scales typography by width', () {
      final compact = adaptThemeForWidth(lightTheme, 320);
      final wide = adaptThemeForWidth(lightTheme, 1024);

      expect(
        compact.textTheme.bodyMedium!.fontSize!,
        lessThan(lightTheme.textTheme.bodyMedium!.fontSize!),
      );
      expect(
        wide.textTheme.bodyMedium!.fontSize!,
        greaterThan(lightTheme.textTheme.bodyMedium!.fontSize!),
      );
      expect(
        wide.textTheme.headlineSmall!.fontSize!,
        greaterThan(compact.textTheme.headlineSmall!.fontSize!),
      );
    });
  });
}

double _contrastRatio(Color left, Color right) {
  final leftLuminance = _relativeLuminance(left);
  final rightLuminance = _relativeLuminance(right);
  final lighter = math.max(leftLuminance, rightLuminance);
  final darker = math.min(leftLuminance, rightLuminance);

  return (lighter + 0.05) / (darker + 0.05);
}

double _relativeLuminance(Color color) {
  return 0.2126 * _linearizedColorComponent(color.r) +
      0.7152 * _linearizedColorComponent(color.g) +
      0.0722 * _linearizedColorComponent(color.b);
}

double _linearizedColorComponent(double value) {
  if (value <= 0.03928) {
    return value / 12.92;
  }

  return math.pow((value + 0.055) / 1.055, 2.4).toDouble();
}
