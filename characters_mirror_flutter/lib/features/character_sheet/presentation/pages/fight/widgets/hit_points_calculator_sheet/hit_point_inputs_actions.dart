part of '../hit_points_calculator_sheet.dart';

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
    required HitPointAction action,
    required int amount,
  }) onApplyAction,
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
      onApplyAction: onApplyAction,
      onSaveDeathSavingThrows: onSaveDeathSavingThrows,
      onSaveSettings: onSaveSettings,
    ),
  );
}
