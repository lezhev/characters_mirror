import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_limits.dart';

class AppFreeSoloOption<T> {
  const AppFreeSoloOption({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class AppFreeSoloAutocomplete<T> extends StatefulWidget {
  const AppFreeSoloAutocomplete({
    required this.options,
    required this.onAddCanonical,
    required this.onAddCustom,
    this.isSelected,
    this.existingCustomValues = const [],
    this.labelText,
    this.hintText,
    super.key,
  });

  final List<AppFreeSoloOption<T>> options;
  final bool Function(T value)? isSelected;
  final List<String> existingCustomValues;
  final String? labelText;
  final String? hintText;
  final FutureOr<void> Function(T value) onAddCanonical;
  final FutureOr<void> Function(String value) onAddCustom;

  @override
  State<AppFreeSoloAutocomplete<T>> createState() =>
      _AppFreeSoloAutocompleteState<T>();
}

class _AppFreeSoloAutocompleteState<T>
    extends State<AppFreeSoloAutocomplete<T>> {
  late final _GhostTextController _controller;
  late final FocusNode _focusNode;
  var _suggestionsDismissed = false;
  var _highlightedIndex = -1;
  List<AppFreeSoloOption<T>> _suggestions = const [];

  @override
  void initState() {
    super.initState();
    _controller = _GhostTextController();
    _focusNode = FocusNode(onKeyEvent: _handleKeyEvent);
    _focusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant AppFreeSoloAutocomplete<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSuggestions();
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChanged)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (mounted) setState(_updateSuggestions);
  }

  void _handleTextChanged(String _) {
    setState(() {
      _suggestionsDismissed = false;
      _highlightedIndex = -1;
      _updateSuggestions();
    });
  }

  void _updateSuggestions() {
    final query = _normalized(_controller.text);
    if (query.isEmpty) {
      _suggestions = const [];
      _controller.ghostSuffix = '';
      return;
    }

    final available = [
      for (final option in widget.options)
        if (!(widget.isSelected?.call(option.value) ?? false)) option,
    ];
    final matches = [
      for (final option in available)
        if (_normalized(option.label).contains(query)) option,
    ];
    matches.sort((left, right) {
      final leftLabel = _normalized(left.label);
      final rightLabel = _normalized(right.label);
      final rank = _matchRank(leftLabel, query).compareTo(
        _matchRank(rightLabel, query),
      );
      return rank == 0 ? leftLabel.compareTo(rightLabel) : rank;
    });
    _suggestions = matches.take(8).toList();

    final bestLabel =
        _suggestions.isEmpty ? '' : _suggestions.first.label.trim();
    _controller.ghostSuffix = bestLabel.toLowerCase().startsWith(query) &&
            bestLabel.length > query.length
        ? bestLabel.substring(query.length)
        : '';
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final hasSuggestions = _focusNode.hasFocus &&
        !_suggestionsDismissed &&
        _suggestions.isNotEmpty;
    if (event.logicalKey == LogicalKeyboardKey.tab &&
        _controller.ghostSuffix.isNotEmpty) {
      _acceptGhostCompletion();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
        _controller.ghostSuffix.isNotEmpty &&
        _controller.selection.extentOffset == _controller.text.length) {
      _acceptGhostCompletion();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape && hasSuggestions) {
      setState(() {
        _suggestionsDismissed = true;
        _highlightedIndex = -1;
      });
      return KeyEventResult.handled;
    }
    if (hasSuggestions && event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _highlightedIndex = (_highlightedIndex + 1) % _suggestions.length;
      });
      return KeyEventResult.handled;
    }
    if (hasSuggestions && event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _highlightedIndex = _highlightedIndex <= 0
            ? _suggestions.length - 1
            : _highlightedIndex - 1;
      });
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _acceptGhostCompletion() {
    final query = _normalized(_controller.text);
    final option = _suggestions.firstOrNull;
    if (option == null) return;
    final label = option.label.trim();
    if (!label.toLowerCase().startsWith(query)) return;
    _controller
      ..text = label
      ..selection = TextSelection.collapsed(offset: label.length);
    setState(() {
      _highlightedIndex = -1;
      _suggestionsDismissed = false;
      _updateSuggestions();
    });
  }

  Future<void> _submit() async {
    final rawValue = _controller.text;
    final normalizedValue = rawValue.trim();
    if (normalizedValue.isEmpty) return;

    if (_highlightedIndex >= 0 && _highlightedIndex < _suggestions.length) {
      await _addCanonical(_suggestions[_highlightedIndex].value);
      return;
    }

    final exact = widget.options.where(
      (option) => _normalized(option.label) == _normalized(normalizedValue),
    );
    final exactMatch = exact.firstOrNull;
    if (exactMatch != null) {
      if (widget.isSelected?.call(exactMatch.value) ?? false) return;
      await _addCanonical(exactMatch.value);
      return;
    }

    final foldedValue = _normalized(normalizedValue);
    final duplicateCustom = widget.existingCustomValues.any(
      (value) => _normalized(value) == foldedValue,
    );
    if (duplicateCustom) return;

    await widget.onAddCustom(normalizedValue);
    _clearAfterAdd();
  }

  Future<void> _addCanonical(T value) async {
    if (widget.isSelected?.call(value) ?? false) return;
    await widget.onAddCanonical(value);
    _clearAfterAdd();
  }

  void _clearAfterAdd() {
    _controller.clear();
    setState(() {
      _highlightedIndex = -1;
      _suggestionsDismissed = false;
      _updateSuggestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showSuggestions = _focusNode.hasFocus &&
        !_suggestionsDismissed &&
        _controller.text.trim().isNotEmpty &&
        _suggestions.isNotEmpty;
    _controller.ghostStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const ValueKey('app-free-solo-autocomplete-field'),
          controller: _controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.done,
          inputFormatters: [textLengthFormatter(AppInputLimits.shortText)],
          onChanged: _handleTextChanged,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            counterText: '',
            suffixIcon: IconButton(
              key: const ValueKey('app-free-solo-add'),
              tooltip: 'Добавить',
              onPressed: _submit,
              icon: const Icon(Icons.add),
            ),
          ),
        ),
        if (showSuggestions)
          Material(
            elevation: 2,
            color: theme.colorScheme.surfaceContainer,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < _suggestions.length; index++)
                  InkWell(
                    key: ValueKey(
                      'app-free-solo-option-${_suggestions[index].value}',
                    ),
                    onTap: () => _addCanonical(_suggestions[index].value),
                    child: Container(
                      width: double.infinity,
                      color: index == _highlightedIndex
                          ? theme.colorScheme.secondaryContainer
                          : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        _suggestions[index].label,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _GhostTextController extends TextEditingController {
  String ghostSuffix = '';
  TextStyle? ghostStyle;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final input = super.buildTextSpan(
      context: context,
      style: style,
      withComposing: withComposing,
    );
    if (ghostSuffix.isEmpty) return input;
    return TextSpan(
      style: style,
      children: [
        input,
        TextSpan(text: ghostSuffix, style: ghostStyle),
      ],
    );
  }
}

String _normalized(String value) => value.trim().toLowerCase();

int _matchRank(String label, String query) {
  if (label == query) return 0;
  if (label.startsWith(query)) return 1;
  return 2;
}
