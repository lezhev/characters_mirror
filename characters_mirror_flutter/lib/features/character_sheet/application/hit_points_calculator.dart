import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';

enum HitPointAction {
  heal,
  damage,
  temporary,
}

class HitPointTotals {
  const HitPointTotals({
    required this.currentHp,
    required this.maxHp,
    required this.temporaryHp,
  });

  final int currentHp;
  final int maxHp;
  final int temporaryHp;

  HitPointTotals copyWith({
    int? currentHp,
    int? maxHp,
    int? temporaryHp,
  }) {
    return HitPointTotals(
      currentHp: currentHp ?? this.currentHp,
      maxHp: maxHp ?? this.maxHp,
      temporaryHp: temporaryHp ?? this.temporaryHp,
    );
  }
}

class SavedHitPoints {
  const SavedHitPoints({
    required this.currentHp,
    required this.temporaryHp,
  });

  final int? currentHp;
  final int? temporaryHp;
}

HitPointTotals hitPointTotalsFromCharacter(CharacterData character) {
  final maxHp = math.max(0, character.derived?.maxHp ?? 0);
  return HitPointTotals(
    currentHp: (character.currentHp ?? maxHp).clamp(0, maxHp),
    maxHp: maxHp,
    temporaryHp: math.max(0, character.temporaryHp ?? 0),
  );
}

HitPointTotals applyHitPointChange({
  required HitPointTotals totals,
  required int value,
  required HitPointAction action,
}) {
  if (value <= 0) {
    return totals;
  }

  final maxHp = math.max(0, totals.maxHp);
  final currentHp = totals.currentHp.clamp(0, maxHp);
  final temporaryHp = math.max(0, totals.temporaryHp);

  switch (action) {
    case HitPointAction.heal:
      return totals.copyWith(
        currentHp: math.min(maxHp, currentHp + value),
        maxHp: maxHp,
        temporaryHp: temporaryHp,
      );
    case HitPointAction.damage:
      final absorbedByTemporary = math.min(temporaryHp, value);
      final remainingDamage = value - absorbedByTemporary;
      return totals.copyWith(
        currentHp: math.max(0, currentHp - remainingDamage),
        maxHp: maxHp,
        temporaryHp: temporaryHp - absorbedByTemporary,
      );
    case HitPointAction.temporary:
      return totals.copyWith(
        currentHp: currentHp,
        maxHp: maxHp,
        temporaryHp: temporaryHp + value,
      );
  }
}

SavedHitPoints normalizeHitPointsForSave({
  required int currentHp,
  required int maxHp,
  required int temporaryHp,
}) {
  final normalizedMaxHp = math.max(0, maxHp);
  final normalizedCurrentHp = currentHp.clamp(0, normalizedMaxHp);
  final normalizedTemporaryHp = math.max(0, temporaryHp);

  return SavedHitPoints(
    currentHp:
        normalizedCurrentHp == normalizedMaxHp ? null : normalizedCurrentHp,
    temporaryHp: normalizedTemporaryHp == 0 ? null : normalizedTemporaryHp,
  );
}

int? evaluateHitPointExpression(String expression) {
  final normalized = expression.trim();
  if (normalized.isEmpty || !RegExp(r'^\d+([+-]\d+)*$').hasMatch(normalized)) {
    return null;
  }

  var result = 0;
  var currentNumber = 0;
  var operation = '+';

  for (var index = 0; index < normalized.length; index++) {
    final char = normalized[index];
    final digit = int.tryParse(char);
    if (digit != null) {
      currentNumber = currentNumber * 10 + digit;
    }

    if (char == '+' || char == '-' || index == normalized.length - 1) {
      if (operation == '+') {
        result += currentNumber;
      } else {
        result -= currentNumber;
      }
      operation = char;
      currentNumber = 0;
    }
  }

  return result;
}
