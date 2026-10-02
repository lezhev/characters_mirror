part of '../hit_points_calculator_sheet.dart';

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
            color: colorScheme.onSurface,
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
