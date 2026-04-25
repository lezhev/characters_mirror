import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HitPointsCalculatorSheet extends StatefulWidget {
  const HitPointsCalculatorSheet({
    required this.character,
    required this.onSave,
    super.key,
  });

  final CharacterData character;
  final Future<void> Function({
    required int currentHp,
    required int temporaryHp,
  }) onSave;

  @override
  State<HitPointsCalculatorSheet> createState() =>
      _HitPointsCalculatorSheetState();
}

class _HitPointsCalculatorSheetState extends State<HitPointsCalculatorSheet> {
  late HitPointTotals _totals;
  late final TextEditingController _controller;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _totals = hitPointTotalsFromCharacter(widget.character);
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
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Закрыть',
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
                onClear: _clearInput,
                isEnabled: !_isSaving,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _ActionButton(
                    label: 'Временные',
                    accentColor: gameColors.temporaryHitPointsOnDark,
                    isSaving: _isSaving,
                    onPressed: () => _applyAndSave(HitPointAction.temporary),
                  ),
                  _ActionButton(
                    label: 'Лечение',
                    accentColor: gameColors.healingOnDark,
                    isSaving: _isSaving,
                    onPressed: () => _applyAndSave(HitPointAction.heal),
                  ),
                  _ActionButton(
                    label: 'Урон',
                    accentColor: gameColors.damageOnDark,
                    isSaving: _isSaving,
                    onPressed: () => _applyAndSave(HitPointAction.damage),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _appendInput(String value) {
    if (_isSaving) return;

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

  void _clearInput() {
    _controller.clear();
  }

  Future<void> _applyAndSave(HitPointAction action) async {
    final value = evaluateHitPointExpression(_controller.text);
    if (value == null || value <= 0 || _isSaving) {
      return;
    }

    final previousTotals = _totals;
    final nextTotals = applyHitPointChange(
      totals: _totals,
      value: value,
      action: action,
    );

    setState(() {
      _totals = nextTotals;
      _isSaving = true;
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
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(humanReadableError(error))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
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
    required this.onClear,
    required this.isEnabled,
  });

  final ValueChanged<String> onInput;
  final VoidCallback onClear;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    const values = ['7', '8', '9', '4', '5', '6', '1', '2', '3', '0', '+', '-'];

    return Column(
      children: [
        GridView.count(
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
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: isEnabled ? onClear : null,
            child: const Text('Очистить'),
          ),
        ),
      ],
    );
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
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => HitPointsCalculatorSheet(
      character: character,
      onSave: onSave,
    ),
  );
}
