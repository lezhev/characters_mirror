import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:flutter/material.dart';

part 'smooth_switcher/smooth_switcher_animation.dart';
part 'smooth_switcher/smooth_switcher_config.dart';
part 'smooth_switcher/smooth_switcher_dialogs.dart';

class SmoothSwitcher extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final double extraOffset;
  final Object? switchKey;
  final String? title;
  final String? text;
  final TextStyle? titleStyle;
  final TextStyle? textStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final SmoothSwitcherEditConfig? editConfig;
  final EdgeInsetsGeometry contentPadding;
  final double spacing;
  final _SmoothSwitcherAbilityConfig? _abilityConfig;

  const SmoothSwitcher({
    this.extraOffset = 0,
    super.key,
    this.child,
    this.duration = const Duration(milliseconds: 220),
    this.switchKey,
    this.title,
    this.text,
    this.titleStyle,
    this.textStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.editConfig,
    this.contentPadding = EdgeInsets.zero,
    this.spacing = 6,
  }) : _abilityConfig = null;

  SmoothSwitcher.ability({
    required this.title,
    required this.text,
    required List<FeatureTag>? tags,
    required bool isCustomized,
    required Future<void> Function({
      String? title,
      String? text,
      List<FeatureTag>? tags,
    }) onSave,
    Future<void> Function()? onReset,
    bool showTitle = true,
    bool showText = true,
    bool isEditable = true,
    String? emptyTextPlaceholder,
    this.extraOffset = 0,
    super.key,
    this.duration = const Duration(milliseconds: 220),
    this.switchKey,
    this.titleStyle,
    this.textStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.contentPadding = EdgeInsets.zero,
    this.spacing = 6,
  })  : child = null,
        editConfig = null,
        _abilityConfig = _SmoothSwitcherAbilityConfig(
          tags: tags,
          isCustomized: isCustomized,
          onSave: onSave,
          onReset: onReset,
          showTitle: showTitle,
          showText: showText,
          isEditable: isEditable,
          emptyTextPlaceholder: emptyTextPlaceholder,
        );

  @override
  State<SmoothSwitcher> createState() => _SmoothSwitcherState();
}

Future<void> showSmoothSwitcherAbilityDialog({
  required BuildContext context,
  required String? title,
  required String? text,
  required List<FeatureTag>? tags,
  required bool isCustomized,
  required Future<void> Function({
    String? title,
    String? text,
    List<FeatureTag>? tags,
  }) onSave,
  Future<void> Function()? onReset,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return _SmoothSwitcherAbilityDialog(
        abilityConfig: _SmoothSwitcherAbilityConfig(
          tags: tags,
          isCustomized: isCustomized,
          onSave: onSave,
          onReset: onReset,
          showTitle: true,
          showText: true,
          isEditable: true,
        ),
        initialTitle: title,
        initialText: text,
      );
    },
  );
}

List<FeatureTag>? _normalizedFeatureTags(
  List<FeatureTag>? tags, {
  required bool preserveEmpty,
}) {
  if (tags == null) {
    return null;
  }

  final normalized = {...tags}.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  if (normalized.isEmpty && !preserveEmpty) {
    return null;
  }
  return normalized;
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
