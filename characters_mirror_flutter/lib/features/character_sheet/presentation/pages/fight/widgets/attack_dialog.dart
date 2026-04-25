import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_autosize_text_field.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter/material.dart';

Future<void> showAttackDialog(
  BuildContext context, {
  required CharacterAttackData attack,
  required bool isCreating,
  required Future<void> Function(CharacterAttackData draft) onDraftChanged,
  Future<void> Function()? onDelete,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return AttackDialog(
        attack: attack,
        isCreating: isCreating,
        onDraftChanged: onDraftChanged,
        onDelete: onDelete,
      );
    },
  );
}

class AttackDialog extends StatefulWidget {
  const AttackDialog({
    required this.attack,
    required this.isCreating,
    required this.onDraftChanged,
    super.key,
    this.onDelete,
  });

  final CharacterAttackData attack;
  final bool isCreating;
  final Future<void> Function(CharacterAttackData draft) onDraftChanged;
  final Future<void> Function()? onDelete;

  @override
  State<AttackDialog> createState() => _AttackDialogState();
}

class _AttackDialogState extends State<AttackDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _damageController;
  late final TextEditingController _bonusController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _tagController;

  late Ability? _leadingAbility;
  late DamageType? _damageType;
  late List<String> _selectedTags;

  CharacterAttackData? _lastSavedDraft;
  CharacterAttackData? _pendingSave;
  bool _isSaving = false;
  bool _confirmDelete = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.attack.name ?? '');
    _damageController = TextEditingController(text: widget.attack.damage ?? '');
    _bonusController = TextEditingController(
      text: (widget.attack.customAttackBonus ?? 0).toString(),
    );
    _descriptionController =
        TextEditingController(text: widget.attack.description ?? '');
    _tagController = TextEditingController();
    _leadingAbility = widget.attack.leadingAbility ?? Ability.strength;
    _damageType = widget.attack.damageType;
    _selectedTags = [...?widget.attack.tags];
    _lastSavedDraft = widget.isCreating ? null : widget.attack;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _damageController.dispose();
    _bonusController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final suggestions = matchingWeaponPropertySuggestions(
      query: _tagController.text,
      selectedTags: _selectedTags,
    );

    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(24, 16, 12, 0),
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.isCreating ? 'Новая атака' : 'Редактирование атаки',
            ),
          ),
          if (_isSaving)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            tooltip: 'Закрыть',
          ),
        ],
      ),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                ),
                onChanged: (_) => _queueSave(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Ability>(
                initialValue: _leadingAbility,
                decoration: const InputDecoration(
                  labelText: 'Характеристика',
                ),
                items: [
                  for (final ability in Ability.values)
                    DropdownMenuItem(
                      value: ability,
                      child: Text(abilityLabel(ability)),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    _leadingAbility = value;
                    _confirmDelete = false;
                  });
                  _queueSave();
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bonusController,
                decoration: const InputDecoration(
                  labelText: 'Доп. модификатор ',
                ),
                keyboardType: TextInputType.number,
                onChanged: (_) => _queueSave(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _damageController,
                decoration: const InputDecoration(
                  labelText: 'Урон',
                  hintText: 'Например, 1d8 + 3',
                ),
                onChanged: (_) => _queueSave(),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<DamageType?>(
                initialValue: _damageType,
                decoration: const InputDecoration(
                  labelText: 'Тип урона',
                ),
                items: [
                  const DropdownMenuItem<DamageType?>(
                    value: null,
                    child: Text('Не указан'),
                  ),
                  for (final value in DamageType.values)
                    DropdownMenuItem<DamageType?>(
                      value: value,
                      child: Text(damageTypeLabel(value)),
                    ),
                ],
                onChanged: (value) {
                  setState(() {
                    _damageType = value;
                    _confirmDelete = false;
                  });
                  _queueSave();
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Теги',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              if (_selectedTags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in _selectedTags)
                      InputChip(
                        label: Text(attackTagLabel(tag)),
                        onDeleted: () {
                          setState(() {
                            _selectedTags.remove(tag);
                            _confirmDelete = false;
                          });
                          _queueSave();
                        },
                      ),
                  ],
                ),
              if (_selectedTags.isNotEmpty) const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        labelText: 'Добавить тег',
                        hintText: 'Например, фехтовальное',
                      ),
                      onChanged: (_) {
                        setState(() {
                          _confirmDelete = false;
                        });
                      },
                      onFieldSubmitted: _addTag,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _addTag(_tagController.text),
                    icon: const Icon(Icons.add),
                    tooltip: 'Добавить тег',
                  ),
                ],
              ),
              if (suggestions.isNotEmpty) const SizedBox(height: 8),
              if (suggestions.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in suggestions)
                      ActionChip(
                        label: Text(attackTagLabel(tag)),
                        onPressed: () => _addTag(tag),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              AppAutosizeTextField(
                label: 'Описание',
                controller: _descriptionController,
                minLines: 3,
                onChanged: (_) => _queueSave(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (!widget.isCreating && widget.onDelete != null)
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            onPressed: _isSaving ? null : _handleDeletePressed,
            child: Text(_confirmDelete ? 'Точно?' : 'Удалить'),
          ),
      ],
    );
  }

  CharacterAttackData _buildDraft() {
    return CharacterAttackData(
      id: widget.attack.id,
      name: normalizedAttackText(_nameController.text),
      leadingAbility: _leadingAbility,
      damage: normalizedAttackText(_damageController.text),
      customAttackBonus: int.tryParse(_bonusController.text.trim()) ?? 0,
      damageType: _damageType,
      tags: _selectedTags,
      description: normalizedAttackText(_descriptionController.text),
      updatedAt: widget.attack.updatedAt,
    );
  }

  void _addTag(String rawValue) {
    final normalized = normalizedAttackText(rawValue);
    if (normalized == null) {
      return;
    }

    final alreadyExists = _selectedTags.any(
      (tag) => tag.toLowerCase() == normalized.toLowerCase(),
    );
    if (alreadyExists) {
      _tagController.clear();
      setState(() {
        _confirmDelete = false;
      });
      return;
    }

    setState(() {
      _selectedTags.add(normalized);
      _tagController.clear();
      _confirmDelete = false;
    });
    _queueSave();
  }

  void _queueSave() {
    _pendingSave = _buildDraft();
    _confirmDelete = false;
    if (_isSaving) {
      return;
    }
    _flushPendingSaves();
  }

  Future<void> _flushPendingSaves() async {
    while (_pendingSave != null) {
      final draft = _pendingSave!;
      _pendingSave = null;

      if (attackEquals(_lastSavedDraft, draft)) {
        continue;
      }

      if (mounted) {
        setState(() {
          _isSaving = true;
        });
      }

      try {
        await widget.onDraftChanged(draft);
        _lastSavedDraft = draft;
      } catch (error) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(humanReadableError(error)),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _handleDeletePressed() async {
    if (!_confirmDelete) {
      setState(() {
        _confirmDelete = true;
      });
      return;
    }

    final onDelete = widget.onDelete;
    if (onDelete == null) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await onDelete();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(humanReadableError(error)),
        ),
      );
    }
  }
}
