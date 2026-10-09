import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/condition_type_labels.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/conditions_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

bool hasActiveCharacterStatus(CharacterData character) {
  return character.inspiration == true ||
      (character.activeConditions?.isNotEmpty ?? false) ||
      (character.exhaustionLevel ?? 0) > 0 ||
      (character.activeConcentrationSpellName?.trim().isNotEmpty ?? false);
}

Future<void> showQuickActionsSheet({
  required BuildContext context,
  required int characterId,
  required CharacterData character,
  required Future<void> Function(bool value) onInspirationChanged,
  required Future<void> Function({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) onSaveConditions,
  required Future<void> Function() onCancelConcentration,
  required ValueChanged<RestType> onRestSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => SafeArea(
      child: QuickActionsSheet(
        characterId: characterId,
        character: character,
        onInspirationChanged: onInspirationChanged,
        onSaveConditions: onSaveConditions,
        onCancelConcentration: onCancelConcentration,
        onRestSelected: onRestSelected,
      ),
    ),
  );
}

class QuickActionsSheet extends ConsumerWidget {
  const QuickActionsSheet({
    required this.characterId,
    required this.character,
    required this.onInspirationChanged,
    required this.onSaveConditions,
    required this.onCancelConcentration,
    required this.onRestSelected,
    super.key,
  });

  final int characterId;
  final CharacterData character;
  final Future<void> Function(bool value) onInspirationChanged;
  final Future<void> Function({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) onSaveConditions;
  final Future<void> Function() onCancelConcentration;
  final ValueChanged<RestType> onRestSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCharacter =
        ref.watch(characterSheetControllerProvider(characterId)).valueOrNull ??
            character;
    final concentrationName = _normalizedText(
      currentCharacter.activeConcentrationSpellName,
    );
    final conditions = _activeConditions(currentCharacter.activeConditions);
    final exhaustion = _normalizedExhaustion(currentCharacter.exhaustionLevel);
    final mediaQuery = MediaQuery.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.85),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
              child: Text(
                'Быстрые действия',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text('Состояние'),
            ),
            SwitchListTile(
              key: const ValueKey('quick-inspiration-toggle'),
              secondary: const Icon(Icons.flare),
              title: const Text('Вдохновение'),
              subtitle: Text(
                currentCharacter.inspiration == true ? 'Активно' : 'Не активно',
              ),
              value: currentCharacter.inspiration == true,
              onChanged: (value) => unawaited(onInspirationChanged(value)),
            ),
            ListTile(
              key: const ValueKey('quick-conditions-button'),
              leading: const Icon(Icons.do_not_disturb_on_outlined),
              title: const Text('Состояния'),
              subtitle: Text(_conditionsSummary(conditions, exhaustion)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openConditionsDialog(
                context,
                conditions,
                exhaustion ?? 0,
              ),
            ),
            if (concentrationName != null)
              ListTile(
                key: const ValueKey('quick-concentration-row'),
                leading: const Icon(Icons.blur_on),
                title: const Text('Концентрация'),
                subtitle: Text(concentrationName),
                trailing: TextButton(
                  key: const ValueKey('quick-cancel-concentration'),
                  onPressed: () => unawaited(onCancelConcentration()),
                  child: const Text('Сбросить'),
                ),
              ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Text('Отдых'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('quick-short-rest'),
                      onPressed: () => _selectRest(context, RestType.shortRest),
                      icon: const Icon(Icons.coffee_outlined),
                      label: const Text('Короткий отдых'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      key: const ValueKey('quick-long-rest'),
                      onPressed: () => _selectRest(context, RestType.longRest),
                      icon: const Icon(Icons.bedtime_outlined),
                      label: const Text('Долгий отдых'),
                    ),
                  ),
                ],
              ),
            ),
            if ((character.derived?.activeFeatures ??
                    <CharacterFeatureViewData>[])
                .any((feature) =>
                    (feature.resources ?? <CharacterResourceViewData>[])
                        .any((resource) => resource.resetOn == RestType.dawn)))
              Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: OutlinedButton.icon(
                      key: const ValueKey('quick-new-day'),
                      onPressed: () => _selectRest(context, RestType.dawn),
                      icon: const Icon(Icons.wb_sunny_outlined),
                      label: const Text('Новый день'))),
          ],
        ),
      ),
    );
  }

  Future<void> _openConditionsDialog(
    BuildContext context,
    List<ConditionType> conditions,
    int exhaustion,
  ) {
    return showDialog<void>(
      context: context,
      builder: (_) => ConditionsDialog(
        activeConditions: conditions,
        exhaustionLevel: exhaustion,
        onSave: onSaveConditions,
      ),
    );
  }

  void _selectRest(BuildContext context, RestType restType) {
    onRestSelected(restType);
    Navigator.of(context).pop();
  }
}

List<ConditionType> _activeConditions(List<ConditionType>? conditions) {
  return [
    for (final condition in ConditionType.values)
      if (condition != ConditionType.exhaustion &&
          (conditions ?? const <ConditionType>[]).contains(condition))
        condition,
  ];
}

int? _normalizedExhaustion(int? value) {
  if (value == null || value <= 0) return null;
  return value.clamp(1, 6).toInt();
}

String _conditionsSummary(List<ConditionType> conditions, int? exhaustion) {
  final labels = [
    for (final condition in conditions) conditionTypeLabel(condition),
    if (exhaustion != null) 'Истощение $exhaustion',
  ];
  return labels.isEmpty ? 'Нет активных состояний' : labels.join(', ');
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
