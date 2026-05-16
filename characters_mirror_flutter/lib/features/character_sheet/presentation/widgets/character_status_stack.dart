import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/condition_type_labels.dart';
import 'package:flutter/material.dart';

enum CharacterStatusStackMode {
  hidden,
  icons,
  labels,
}

class CharacterStatusStack extends StatelessWidget {
  const CharacterStatusStack({
    required this.character,
    required this.mode,
    required this.onModePressed,
    required this.onInspirationChanged,
    required this.onSaveConditions,
    required this.onRemoveCondition,
    required this.onCancelConcentration,
    super.key,
  });

  final CharacterData character;
  final CharacterStatusStackMode mode;
  final VoidCallback onModePressed;
  final Future<void> Function(bool value) onInspirationChanged;
  final Future<void> Function({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) onSaveConditions;
  final Future<void> Function(ConditionType condition) onRemoveCondition;
  final Future<void> Function() onCancelConcentration;

  @override
  Widget build(BuildContext context) {
    final activeConcentrationSpell =
        _normalizedText(character.activeConcentrationSpellName);
    final activeConditions = _activeConditions(character.activeConditions);
    final exhaustionLevel = _normalizedExhaustionLevel(
      character.exhaustionLevel,
    );
    final inspired = character.inspiration == true;
    final showItems = mode != CharacterStatusStackMode.hidden;
    final showLabels = mode == CharacterStatusStackMode.labels;

    return Column(
      key: const ValueKey('character-status-stack'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showItems) ...[
          if (activeConcentrationSpell != null) ...[
            _StatusRow(
              key: const ValueKey('active-concentration-row'),
              icon: Icons.blur_on,
              label: activeConcentrationSpell,
              showLabel: showLabels,
              removeKey: const ValueKey('active-concentration-cancel'),
              onRemove: onCancelConcentration,
            ),
            const SizedBox(height: 8),
          ],
          for (final condition in activeConditions) ...[
            _StatusRow(
              key: ValueKey('active-condition-${condition.name}'),
              icon: Icons.do_not_disturb,
              label: conditionTypeLabel(condition),
              showLabel: showLabels,
              removeKey: ValueKey('active-condition-remove-${condition.name}'),
              onRemove: () => onRemoveCondition(condition),
            ),
            const SizedBox(height: 8),
          ],
          if (exhaustionLevel != null) ...[
            _StatusRow(
              key: const ValueKey('active-condition-exhaustion'),
              icon: Icons.do_not_disturb,
              label: 'Истощение $exhaustionLevel',
              showLabel: showLabels,
              removeKey: const ValueKey('active-condition-remove-exhaustion'),
              onRemove: () => onRemoveCondition(ConditionType.exhaustion),
            ),
            const SizedBox(height: 8),
          ],
          _StatusButton(
            key: const ValueKey('status-conditions-button'),
            icon: Icons.do_not_disturb,
            label: 'Состояния',
            showLabel: showLabels,
            onPressed: () => _openConditionsDialog(context),
          ),
          const SizedBox(height: 8),
          _StatusButton(
            key: const ValueKey('status-inspiration-toggle'),
            customIcon: inspired
                ? const Icon(Icons.flare, size: 20)
                : const _InactiveInspirationIcon(),
            label: 'Вдохновение',
            selected: inspired,
            showLabel: showLabels,
            onPressed: () async {
              await onInspirationChanged(!inspired);
            },
          ),
          const SizedBox(height: 8),
        ],
        _StatusButton(
          key: const ValueKey('status-visibility-toggle'),
          icon: switch (mode) {
            CharacterStatusStackMode.hidden => Icons.visibility,
            CharacterStatusStackMode.icons => Icons.open_in_full,
            CharacterStatusStackMode.labels => Icons.visibility_off,
          },
          label: switch (mode) {
            CharacterStatusStackMode.hidden => 'Показать',
            CharacterStatusStackMode.icons => 'Развернуть',
            CharacterStatusStackMode.labels => 'Свернуть',
          },
          showLabel: mode != CharacterStatusStackMode.hidden,
          onPressed: onModePressed,
        ),
      ],
    );
  }

  Future<void> _openConditionsDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return _ConditionsDialog(
          activeConditions: _activeConditions(character.activeConditions),
          exhaustionLevel: _normalizedExhaustionLevel(
                character.exhaustionLevel,
              ) ??
              0,
          onSave: onSaveConditions,
        );
      },
    );
  }
}

class _StatusButton extends StatelessWidget {
  const _StatusButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.customIcon,
    this.selected = false,
    this.showLabel = true,
  });

  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final bool selected;
  final bool showLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = selected ? colorScheme.primary : colorScheme.onSurface;

    return Tooltip(
      message: label,
      child: _StatusSurface(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: showLabel ? 10 : 8,
              vertical: 8,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme(
                  data: IconThemeData(color: foreground, size: 20),
                  child: customIcon ?? Icon(icon),
                ),
                if (showLabel) ...[
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: foreground,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.label,
    required this.showLabel,
    required this.removeKey,
    required this.onRemove,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool showLabel;
  final Key removeKey;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Tooltip(
      message: label,
      child: _StatusSurface(
        child: Padding(
          padding: showLabel
              ? const EdgeInsets.only(left: 10, top: 6, bottom: 6)
              : const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              if (showLabel) ...[
                const SizedBox(width: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Text(
                    label,
                    key: icon == Icons.blur_on
                        ? const ValueKey('active-concentration-text')
                        : null,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  key: removeKey,
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: colorScheme.onSurfaceVariant,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusSurface extends StatelessWidget {
  const _StatusSurface({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.94),
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _InactiveInspirationIcon extends StatelessWidget {
  const _InactiveInspirationIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 20,
      child: Center(
        child: SizedBox.square(
          dimension: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionsDialog extends StatefulWidget {
  const _ConditionsDialog({
    required this.activeConditions,
    required this.exhaustionLevel,
    required this.onSave,
  });

  final List<ConditionType> activeConditions;
  final int exhaustionLevel;
  final Future<void> Function({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) onSave;

  @override
  State<_ConditionsDialog> createState() => _ConditionsDialogState();
}

class _ConditionsDialogState extends State<_ConditionsDialog> {
  late final Set<ConditionType> _selectedConditions;
  late int _exhaustionLevel;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _selectedConditions = {
      for (final condition in widget.activeConditions)
        if (condition != ConditionType.exhaustion) condition,
    };
    _exhaustionLevel = widget.exhaustionLevel.clamp(0, 6).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
      title: Row(
        children: [
          const Expanded(child: Text('Состояния')),
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: SizedBox.square(
                dimension: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          IconButton(
            onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            tooltip: 'Закрыть',
          ),
        ],
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                key: const ValueKey('condition-exhaustion-field'),
                initialValue: _exhaustionLevel,
                decoration: const InputDecoration(
                  labelText: 'Истощение',
                ),
                items: [
                  for (var value = 0; value <= 6; value++)
                    DropdownMenuItem(
                      value: value,
                      child: Text(value == 0 ? 'Нет' : '$value'),
                    ),
                ],
                onChanged: _isSaving
                    ? null
                    : (value) {
                        setState(() {
                          _exhaustionLevel = value ?? 0;
                        });
                      },
              ),
              const SizedBox(height: 8),
              for (final condition in _conditionOptions)
                CheckboxListTile(
                  key: ValueKey('condition-option-${condition.name}'),
                  dense: true,
                  value: _selectedConditions.contains(condition),
                  title: Text(conditionTypeLabel(condition)),
                  onChanged: _isSaving
                      ? null
                      : (value) {
                          setState(() {
                            if (value == true) {
                              _selectedConditions.add(condition);
                            } else {
                              _selectedConditions.remove(condition);
                            }
                          });
                        },
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
        FilledButton(
          key: const ValueKey('save-conditions'),
          onPressed: _isSaving ? null : _save,
          child: const Text('Сохранить'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() {
      _isSaving = true;
    });
    try {
      await widget.onSave(
        activeConditions: _orderedConditions(_selectedConditions),
        exhaustionLevel: _exhaustionLevel == 0 ? null : _exhaustionLevel,
      );
      if (mounted) {
        Navigator.of(context).pop();
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

final _conditionOptions = ConditionType.values
    .where((condition) => condition != ConditionType.exhaustion)
    .toList(growable: false);

List<ConditionType> _activeConditions(List<ConditionType>? conditions) {
  return _orderedConditions({
    for (final condition in conditions ?? const <ConditionType>[])
      if (condition != ConditionType.exhaustion) condition,
  });
}

List<ConditionType> _orderedConditions(Set<ConditionType> conditions) {
  return [
    for (final condition in ConditionType.values)
      if (condition != ConditionType.exhaustion &&
          conditions.contains(condition))
        condition,
  ];
}

int? _normalizedExhaustionLevel(int? value) {
  if (value == null || value <= 0) {
    return null;
  }
  return value.clamp(1, 6).toInt();
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
