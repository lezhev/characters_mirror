import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HitPointsCalculatorSheet extends StatefulWidget {
  const HitPointsCalculatorSheet({
    required this.character,
    required this.onSave,
    required this.onSaveDeathSavingThrows,
    required this.onSaveSettings,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function({
    required int currentHp,
    required int temporaryHp,
  }) onSave;
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
      await widget.onSave(
        currentHp: nextTotals.currentHp,
        temporaryHp: nextTotals.temporaryHp,
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

class _HitPointSummary extends StatelessWidget {
  const _HitPointSummary({
    required this.totals,
  });

  final HitPointTotals totals;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gameColors = AppGameColors.of(context);

    return Row(
      children: [
        Expanded(
          child: _SummaryValue(
            label: 'Текущие',
            value: '${totals.currentHp}',
            color: colorScheme.onSurface,
          ),
        ),
        Expanded(
          child: _SummaryValue(
            label: 'Максимум',
            value: '${totals.maxHp}',
            color: colorScheme.primary,
          ),
        ),
        Expanded(
          child: _SummaryValue(
            label: 'Временные',
            value: '${totals.temporaryHp}',
            color: gameColors.temporaryHitPoints,
          ),
        ),
      ],
    );
  }
}

class _DeathSavingThrowsSummary extends StatelessWidget {
  const _DeathSavingThrowsSummary({
    required this.successes,
    required this.failures,
    required this.isSaving,
    required this.onSuccessChanged,
    required this.onFailureChanged,
  });

  final int successes;
  final int failures;
  final bool isSaving;
  final void Function(int index, bool checked) onSuccessChanged;
  final void Function(int index, bool checked) onFailureChanged;

  @override
  Widget build(BuildContext context) {
    final gameColors = AppGameColors.of(context);

    return Row(
      children: [
        Expanded(
          child: _DeathSaveGroup(
            label: 'Успехи',
            color: gameColors.healingOnDark,
            checkedCount: successes,
            isSaving: isSaving,
            onChanged: onSuccessChanged,
          ),
        ),
        IconButton.filledTonal(
          key: const Key('death_saves_skull_button'),
          onPressed: null,
          icon: const Icon(Icons.dangerous_rounded),
          tooltip: 'Спасброски от смерти',
        ),
        Expanded(
          child: _DeathSaveGroup(
            label: 'Провалы',
            color: gameColors.damageOnDark,
            checkedCount: failures,
            isSaving: isSaving,
            onChanged: onFailureChanged,
          ),
        ),
      ],
    );
  }
}

class _DeathSaveGroup extends StatelessWidget {
  const _DeathSaveGroup({
    required this.label,
    required this.color,
    required this.checkedCount,
    required this.isSaving,
    required this.onChanged,
  });

  final String label;
  final Color color;
  final int checkedCount;
  final bool isSaving;
  final void Function(int index, bool checked) onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(label, style: textTheme.bodySmall),
        const SizedBox(height: 4),
        Wrap(
          spacing: 2,
          alignment: WrapAlignment.center,
          children: [
            for (var index = 0; index < 3; index++)
              Checkbox(
                key: Key('${label}_death_save_$index'),
                value: checkedCount > index,
                activeColor: color,
                onChanged: isSaving
                    ? null
                    : (value) => onChanged(index, value ?? false),
              ),
          ],
        ),
      ],
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          label,
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}

class _CalculatorGrid extends StatelessWidget {
  const _CalculatorGrid({
    required this.onInput,
    required this.isEnabled,
  });

  final ValueChanged<String> onInput;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    const values = ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '+', '-'];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 2.2,
      children: [
        for (final value in values)
          OutlinedButton(
            onPressed: isEnabled ? () => onInput(value) : null,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(value),
          ),
      ],
    );
  }
}

class _HitPointTunePanel extends StatelessWidget {
  const _HitPointTunePanel({
    required this.character,
    required this.settings,
    required this.isSaving,
    required this.onHpGainChanged,
    required this.onHpPerLevelBonusChanged,
    required this.onHpFlatBonusChanged,
    required this.onHitDiceCurrentChanged,
    required this.onHitDiceMaxChanged,
  });

  final CharacterData character;
  final HitPointSettingsDraft settings;
  final bool isSaving;
  final void Function(int entryIndex, int levelIndex, int value)
      onHpGainChanged;
  final ValueChanged<int> onHpPerLevelBonusChanged;
  final ValueChanged<int> onHpFlatBonusChanged;
  final void Function(String key, int value) onHitDiceCurrentChanged;
  final void Function(String key, int value) onHitDiceMaxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final descriptors = hitPointLevelDescriptors(settings.classEntries);
    final baseHitDiceMax = baseHitDiceMaxFromCharacter(character);
    final hitDiceMax = effectiveHitDiceMax(
      baseHitDiceMax,
      settings.hitDiceMaxOverrides,
    );
    final currentHitDice = effectiveCurrentHitDice(
      settings.currentHitDice,
      hitDiceMax,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Настройка максимума', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (descriptors.isEmpty)
              Text('Нет уровней класса', style: theme.textTheme.bodyMedium)
            else
              for (final entry in settings.classEntries)
                _ClassHpGainGroup(
                  entry: entry,
                  descriptors: descriptors
                      .where((item) => identical(item.entry, entry))
                      .toList(),
                  isSaving: isSaving,
                  onChanged: onHpGainChanged,
                ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AutosaveNumberField(
                    label: 'Бонус за уровень',
                    value: settings.hpPerLevelBonus,
                    signed: true,
                    enabled: !isSaving,
                    onSave: onHpPerLevelBonusChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _AutosaveNumberField(
                    label: 'Единоразовый бонус',
                    value: settings.hpFlatBonus,
                    signed: true,
                    enabled: !isSaving,
                    onSave: onHpFlatBonusChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Кости хитов', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (hitDiceMax.isEmpty)
              Text('Нет костей хитов', style: theme.textTheme.bodyMedium)
            else
              for (final key in hitDiceMax.keys)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 44, child: Text(key)),
                      Expanded(
                        child: _AutosaveNumberField(
                          label: 'Текущие',
                          value: currentHitDice[key] ?? 0,
                          min: 0,
                          max: hitDiceMax[key],
                          enabled: !isSaving,
                          onSave: (value) =>
                              onHitDiceCurrentChanged(key, value),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _AutosaveNumberField(
                          label: 'Максимум',
                          value: hitDiceMax[key] ?? 0,
                          min: 0,
                          enabled: !isSaving,
                          onSave: (value) => onHitDiceMaxChanged(key, value),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _ClassHpGainGroup extends StatelessWidget {
  const _ClassHpGainGroup({
    required this.entry,
    required this.descriptors,
    required this.isSaving,
    required this.onChanged,
  });

  final CharacterClassEntryData entry;
  final List<HitPointLevelDescriptor> descriptors;
  final bool isSaving;
  final void Function(int entryIndex, int levelIndex, int value) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final className = entry.classData?.name ?? 'Класс';

    if (descriptors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(className, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final descriptor in descriptors)
                SizedBox(
                  width: 96,
                  child: _AutosaveNumberField(
                    label: 'Ур. ${descriptor.characterLevel}',
                    value: descriptor.value,
                    min: 1,
                    max: descriptor.hitDie,
                    enabled: !isSaving,
                    onSave: (value) => onChanged(
                      descriptor.entryIndex,
                      descriptor.levelIndex,
                      value,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AutosaveNumberField extends StatefulWidget {
  const _AutosaveNumberField({
    required this.label,
    required this.value,
    required this.onSave,
    this.enabled = true,
    this.signed = false,
    this.min,
    this.max,
  });

  final String label;
  final int value;
  final ValueChanged<int> onSave;
  final bool enabled;
  final bool signed;
  final int? min;
  final int? max;

  @override
  State<_AutosaveNumberField> createState() => _AutosaveNumberFieldState();
}

class _AutosaveNumberFieldState extends State<_AutosaveNumberField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.value}');
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant _AutosaveNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_focusNode.hasFocus && widget.value != oldWidget.value) {
      _controller.text = '${widget.value}';
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _commit();
    _focusNode
      ..removeListener(_handleFocusChanged)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      keyboardType: TextInputType.numberWithOptions(signed: widget.signed),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          widget.signed ? RegExp(r'^-?\d*$') : RegExp(r'^\d*$'),
        ),
      ],
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      onChanged: (_) => _scheduleCommit(),
      onSubmitted: (_) => _commit(),
    );
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus) {
      _commit();
    }
  }

  void _scheduleCommit() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(characterSheetAutosaveDelay, _commit);
  }

  void _commit() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    final parsed = int.tryParse(_controller.text);
    if (parsed == null) {
      _controller.text = '${widget.value}';
      return;
    }
    final min = widget.min;
    final max = widget.max;
    if ((min != null && parsed < min) || (max != null && parsed > max)) {
      _controller.text = '${widget.value}';
      return;
    }
    if (parsed != widget.value) {
      widget.onSave(parsed);
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.accentColor,
    required this.isSaving,
    required this.onPressed,
  });

  final String label;
  final Color accentColor;
  final bool isSaving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.surfaceContainerHighest
        : colorScheme.inverseSurface;

    return FilledButton(
      onPressed: isSaving ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: accentColor,
        disabledBackgroundColor: backgroundColor.withValues(alpha: 0.46),
        disabledForegroundColor: accentColor.withValues(alpha: 0.46),
        side: BorderSide(
          color: accentColor.withValues(alpha: 0.62),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }
}

class _HitPointExpressionFormatter extends TextInputFormatter {
  const _HitPointExpressionFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final nextText = newValue.text;
    if (!RegExp(r'^[0-9+-]*$').hasMatch(nextText)) {
      return oldValue;
    }
    if (nextText.startsWith('+') || nextText.startsWith('-')) {
      return oldValue;
    }
    if (RegExp(r'[+-]{2,}').hasMatch(nextText)) {
      return oldValue;
    }
    return newValue;
  }
}

Future<void> showHitPointsCalculatorSheet({
  required BuildContext context,
  required CharacterData character,
  required Future<void> Function({
    required int currentHp,
    required int temporaryHp,
  }) onSave,
  required Future<void> Function({
    required int successes,
    required int failures,
  }) onSaveDeathSavingThrows,
  required Future<void> Function({
    required List<CharacterClassEntryData> classEntries,
    required int hpPerLevelBonus,
    required int hpFlatBonus,
    required Map<String, int> currentHitDice,
    required Map<String, int> hitDiceMaxOverrides,
  }) onSaveSettings,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => HitPointsCalculatorSheet(
      character: character,
      onSave: onSave,
      onSaveDeathSavingThrows: onSaveDeathSavingThrows,
      onSaveSettings: onSaveSettings,
    ),
  );
}
