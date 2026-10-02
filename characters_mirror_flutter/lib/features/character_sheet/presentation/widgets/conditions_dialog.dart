import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/condition_type_labels.dart';
import 'package:flutter/material.dart';

class ConditionsDialog extends StatefulWidget {
  const ConditionsDialog({
    required this.activeConditions,
    required this.exhaustionLevel,
    required this.onSave,
    super.key,
  });

  final List<ConditionType> activeConditions;
  final int exhaustionLevel;
  final Future<void> Function({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) onSave;

  @override
  State<ConditionsDialog> createState() => _ConditionsDialogState();
}

class _ConditionsDialogState extends State<ConditionsDialog> {
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

List<ConditionType> _orderedConditions(Set<ConditionType> conditions) {
  return [
    for (final condition in ConditionType.values)
      if (condition != ConditionType.exhaustion &&
          conditions.contains(condition))
        condition,
  ];
}
