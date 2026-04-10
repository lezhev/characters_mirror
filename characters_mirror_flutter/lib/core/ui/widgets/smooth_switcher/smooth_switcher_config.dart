part of '../smooth_switcher.dart';

class SmoothSwitcherEditConfig {
  const SmoothSwitcherEditConfig({
    required this.onSave,
    this.onReset,
    this.dialogTitle = 'Редактирование',
    this.titleFieldLabel = 'Название',
    this.textFieldLabel = 'Текст',
    this.resetLabel = 'Вернуть всё как было',
    this.textMinLines = 3,
    this.textMaxLines = 6,
  });

  final Future<void> Function({
    String? title,
    String? text,
  }) onSave;
  final Future<void> Function()? onReset;
  final String dialogTitle;
  final String titleFieldLabel;
  final String textFieldLabel;
  final String resetLabel;
  final int textMinLines;
  final int textMaxLines;
}

class _SmoothSwitcherAbilityConfig {
  const _SmoothSwitcherAbilityConfig({
    required this.tags,
    required this.isCustomized,
    required this.onSave,
    this.onReset,
    required this.showTitle,
    required this.showText,
    required this.isEditable,
    this.emptyTextPlaceholder,
  });

  final List<FeatureTag>? tags;
  final bool isCustomized;
  final Future<void> Function({
    String? title,
    String? text,
    List<FeatureTag>? tags,
  }) onSave;
  final Future<void> Function()? onReset;
  final bool showTitle;
  final bool showText;
  final bool isEditable;
  final String? emptyTextPlaceholder;
  final String dialogTitle = 'Редактирование способности';
  final String titleFieldLabel = 'Название';
  final String textFieldLabel = 'Текст';
  final String tagsLabel = 'Теги';
  final String resetLabel = 'Вернуть всё как было';
  final int textMinLines = 3;
  final int textMaxLines = 6;
}
