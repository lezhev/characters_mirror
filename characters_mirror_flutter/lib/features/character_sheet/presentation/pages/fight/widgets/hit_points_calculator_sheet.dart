import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'hit_points_calculator_sheet/hit_point_summaries.dart';
part 'hit_points_calculator_sheet/hit_point_tuning.dart';
part 'hit_points_calculator_sheet/hit_point_inputs_actions.dart';

class HitPointsCalculatorSheet extends StatefulWidget {
  const HitPointsCalculatorSheet({
    required this.character,
    required this.onApplyAction,
    required this.onSaveDeathSavingThrows,
    required this.onSaveSettings,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function({
    required HitPointAction action,
    required int amount,
  }) onApplyAction;
  final Future<void> Function({
    required int successes,
    required int failures,
  }) onSaveDeathSavingThrows;
  final Future<void> Function({
    required List<CharacterClassEntryData> classEntries,
    required int hpPerLevelBonus,
    required int hpFlatBonus,
    required Map<String, int> currentHitDice,
    required Map<String, int> hitDiceMaxOverrides,
  }) onSaveSettings;

  @override
  State<HitPointsCalculatorSheet> createState() =>
      _HitPointsCalculatorSheetState();
}

class _HitPointsCalculatorSheetState extends State<HitPointsCalculatorSheet> {
  late HitPointTotals _totals;
  late HitPointSettingsDraft _settings;
  late final TextEditingController _controller;
  late int _deathSaveSuccesses;
  late int _deathSaveFailures;
  bool _isTuning = false;

  @override
  void initState() {
    super.initState();
    _totals = hitPointTotalsFromCharacter(widget.character);
    _settings = hitPointSettingsFromCharacter(widget.character);
    _deathSaveSuccesses =
        normalizeDeathSaveCount(widget.character.deathSaveSuccesses);
    _deathSaveFailures =
        normalizeDeathSaveCount(widget.character.deathSaveFailures);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameColors = AppGameColors.of(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: 16 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Хиты',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Закрыть',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_totals.currentHp == 0)
                _DeathSavingThrowsSummary(
                  successes: _deathSaveSuccesses,
                  failures: _deathSaveFailures,
                  isSaving: false,
                  onSuccessChanged: (index, value) => _setDeathSave(
                    isSuccess: true,
                    index: index,
                    checked: value,
                  ),
                  onFailureChanged: (index, value) => _setDeathSave(
                    isSuccess: false,
                    index: index,
                    checked: value,
                  ),
                )
              else
                _HitPointSummary(totals: _totals),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: const [_HitPointExpressionFormatter()],
                decoration: InputDecoration(
                  labelText: 'Значение',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _backspace,
                    icon: const Icon(Icons.backspace_outlined),
                    tooltip: 'Стереть',
                  ),
                ),
                onSubmitted: (_) => _applyAndSave(HitPointAction.damage),
              ),
              const SizedBox(height: 12),
              _CalculatorGrid(
                onInput: _appendInput,
                isEnabled: true,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _ActionButton(
                    label: 'Временные',
                    accentColor: gameColors.temporaryHitPointsOnDark,
                    isSaving: false,
                    onPressed: () => _applyAndSave(HitPointAction.temporary),
                  ),
                  _ActionButton(
                    label: 'Лечение',
                    accentColor: gameColors.healingOnDark,
                    isSaving: false,
                    onPressed: () => _applyAndSave(HitPointAction.heal),
                  ),
                  _ActionButton(
                    label: 'Урон',
                    accentColor: gameColors.damageOnDark,
                    isSaving: false,
                    onPressed: () => _applyAndSave(HitPointAction.damage),
                  ),
                  IconButton.filledTonal(
                    key: const Key('hit_points_tune_button'),
                    tooltip: 'Настроить хиты',
                    onPressed: () => setState(() => _isTuning = !_isTuning),
                    icon: const Icon(Icons.tune),
                  ),
                ],
              ),
              if (_isTuning) ...[
                const SizedBox(height: 16),
                _HitPointTunePanel(
                  character: widget.character,
                  settings: _settings,
                  isSaving: false,
                  onHpGainChanged: _setHpGain,
                  onHpPerLevelBonusChanged: (value) => _saveSettings(
                    _settings.copyWith(hpPerLevelBonus: value),
                  ),
                  onHpFlatBonusChanged: (value) => _saveSettings(
                    _settings.copyWith(hpFlatBonus: value),
                  ),
                  onHitDiceCurrentChanged: _setCurrentHitDice,
                  onHitDiceMaxChanged: _setHitDiceMax,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _appendInput(String value) {
    final currentText = _controller.text;
    if (value == '+' || value == '-') {
      if (currentText.isEmpty) {
        return;
      }
      if (currentText.endsWith('+') || currentText.endsWith('-')) {
        _controller.text =
            '${currentText.substring(0, currentText.length - 1)}$value';
      } else {
        _controller.text = '$currentText$value';
      }
    } else {
      _controller.text = '$currentText$value';
    }
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }

  void _backspace() {
    final currentText = _controller.text;
    if (currentText.isEmpty) {
      return;
    }
    _controller.text = currentText.substring(0, currentText.length - 1);
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
  }

  Future<void> _applyAndSave(HitPointAction action) async {
    final value = evaluateHitPointExpression(_controller.text);
    if (value == null || value <= 0) {
      return;
    }

    final previousTotals = _totals;
    final previousSuccesses = _deathSaveSuccesses;
    final previousFailures = _deathSaveFailures;
    final nextTotals = applyHitPointChange(
      totals: _totals,
      value: value,
      action: action,
    );

    setState(() {
      _totals = nextTotals;
      if (nextTotals.currentHp > 0) {
        _deathSaveSuccesses = 0;
        _deathSaveFailures = 0;
      }
    });

    try {
      await widget.onApplyAction(
        action: action,
        amount: value,
      );
      _controller.clear();
    } catch (error) {
      if (mounted) {
        setState(() {
          _totals = previousTotals;
          _deathSaveSuccesses = previousSuccesses;
          _deathSaveFailures = previousFailures;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    }
  }

  Future<void> _setDeathSave({
    required bool isSuccess,
    required int index,
    required bool checked,
  }) async {
    final previousSuccesses = _deathSaveSuccesses;
    final previousFailures = _deathSaveFailures;
    final nextValue = checked ? index + 1 : index;
    final nextSuccesses = isSuccess ? nextValue : previousSuccesses;
    final nextFailures = isSuccess ? previousFailures : nextValue;

    setState(() {
      _deathSaveSuccesses = nextSuccesses;
      _deathSaveFailures = nextFailures;
    });

    try {
      await widget.onSaveDeathSavingThrows(
        successes: nextSuccesses,
        failures: nextFailures,
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          _deathSaveSuccesses = previousSuccesses;
          _deathSaveFailures = previousFailures;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    }
  }

  Future<void> _setHpGain(int entryIndex, int levelIndex, int value) {
    return _saveSettings(
      _settings.copyWith(
        classEntries: setHpGainForLevel(
          entries: _settings.classEntries,
          entryIndex: entryIndex,
          levelIndex: levelIndex,
          value: value,
        ),
      ),
    );
  }

  Future<void> _setCurrentHitDice(String key, int value) {
    final current = {..._settings.currentHitDice};
    current[key] = value;
    return _saveSettings(_settings.copyWith(currentHitDice: current));
  }

  Future<void> _setHitDiceMax(String key, int value) {
    final baseMax = baseHitDiceMaxFromCharacter(widget.character);
    final overrides = {..._settings.hitDiceMaxOverrides};
    if (value == baseMax[key]) {
      overrides.remove(key);
    } else {
      overrides[key] = value;
    }
    return _saveSettings(_settings.copyWith(hitDiceMaxOverrides: overrides));
  }

  Future<void> _saveSettings(HitPointSettingsDraft nextSettings) async {
    final previousSettings = _settings;
    final previousTotals = _totals;
    final baseHitDiceMax = baseHitDiceMaxFromCharacter(
      widget.character.copyWith(classEntries: nextSettings.classEntries),
    );
    final normalizedMaxOverrides = normalizeHitDiceMaxOverridesForSave(
          baseHitDiceMax,
          nextSettings.hitDiceMaxOverrides,
        ) ??
        const <String, int>{};
    final effectiveMax =
        effectiveHitDiceMax(baseHitDiceMax, normalizedMaxOverrides);
    final normalizedSettings = nextSettings.copyWith(
      currentHitDice: effectiveCurrentHitDice(
        nextSettings.currentHitDice,
        effectiveMax,
      ),
      hitDiceMaxOverrides: normalizedMaxOverrides,
    );
    final nextMaxHp = calculateMaxHpForCharacter(
      widget.character,
      classEntries: normalizedSettings.classEntries,
      hpPerLevelBonus: normalizedSettings.hpPerLevelBonus,
      hpFlatBonus: normalizedSettings.hpFlatBonus,
    );
    final nextCurrentHp = previousTotals.currentHp == previousTotals.maxHp
        ? nextMaxHp
        : previousTotals.currentHp.clamp(0, nextMaxHp).toInt();
    final nextTotals = previousTotals.copyWith(
      currentHp: nextCurrentHp,
      maxHp: nextMaxHp,
    );

    setState(() {
      _settings = normalizedSettings;
      _totals = nextTotals;
    });

    try {
      await widget.onSaveSettings(
        classEntries: normalizedSettings.classEntries,
        hpPerLevelBonus: normalizedSettings.hpPerLevelBonus,
        hpFlatBonus: normalizedSettings.hpFlatBonus,
        currentHitDice: normalizedSettings.currentHitDice,
        hitDiceMaxOverrides: normalizedSettings.hitDiceMaxOverrides,
      );
    } catch (error) {
      if (mounted) {
        setState(() {
          _settings = previousSettings;
          _totals = previousTotals;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    }
  }
}
