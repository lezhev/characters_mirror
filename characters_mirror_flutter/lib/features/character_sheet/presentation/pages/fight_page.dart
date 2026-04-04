import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/foundation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FightPage extends ConsumerWidget {
  const FightPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _FightErrorState(
        message: humanReadableError(error),
        onRetry: () => ref
            .read(characterSheetControllerProvider(characterId).notifier)
            .reload(),
      ),
      data: (character) {
        final attacks = character.attacks ?? const <CharacterAttackData>[];
        final displayedAttacks = attacks.isEmpty
            ? [
                CharacterAttackData(
                  leadingAbility: Ability.strength,
                  customAttackBonus: 0,
                  tags: const [],
                ),
              ]
            : attacks;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Атаки',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () => _onAddAttack(context, ref),
                      icon: const Icon(Icons.add),
                      label: const Text('Добавить'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: displayedAttacks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      final attack = displayedAttacks[index];
                      final isPlaceholder = attacks.isEmpty;
                      return AttackCard(
                        attack: attack,
                        attackBonusLabel: _formatAttackBonus(character, attack),
                        damageLabel: _formatDamageLabel(attack),
                        onNamePressed: () => isPlaceholder
                            ? _onAddAttack(
                                context,
                                ref,
                                initialAttack: attack,
                              )
                            : _onEditAttack(
                                context,
                                ref,
                                index,
                                attack,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onAddAttack(
    BuildContext context,
    WidgetRef ref, {
    CharacterAttackData? initialAttack,
  }) async {
    final notifier =
        ref.read(characterSheetControllerProvider(characterId).notifier);
    var createdIndex = -1;
    CharacterAttackData? lastSaved;

    await _showAttackDialog(
      context,
      attack: initialAttack ??
          CharacterAttackData(
            leadingAbility: Ability.strength,
            customAttackBonus: 0,
            tags: const [],
          ),
      isCreating: true,
      onDraftChanged: (draft) async {
        if (_attackEquals(lastSaved, draft)) {
          return;
        }

        if (createdIndex < 0) {
          await notifier.addAttack(draft);
          final current = ref
              .read(characterSheetControllerProvider(characterId))
              .valueOrNull;
          createdIndex = (current?.attacks?.length ?? 1) - 1;
        } else {
          await notifier.updateAttack(createdIndex, draft);
        }

        lastSaved = draft;
      },
    );
  }

  Future<void> _onEditAttack(
    BuildContext context,
    WidgetRef ref,
    int index,
    CharacterAttackData attack,
  ) async {
    final notifier =
        ref.read(characterSheetControllerProvider(characterId).notifier);

    await _showAttackDialog(
      context,
      attack: attack,
      isCreating: false,
      onDraftChanged: (draft) => notifier.updateAttack(index, draft),
      onDelete: () => notifier.deleteAttack(index),
    );
  }
}

class AttackCard extends StatelessWidget {
  const AttackCard({
    required this.attack,
    required this.attackBonusLabel,
    required this.damageLabel,
    required this.onNamePressed,
    super.key,
  });

  final CharacterAttackData attack;
  final String attackBonusLabel;
  final String damageLabel;
  final VoidCallback onNamePressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(attackBonusLabel),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onNamePressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    attack.name ?? 'Название',
                    style: textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    damageLabel,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FightErrorState extends StatelessWidget {
  const _FightErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showAttackDialog(
  BuildContext context, {
  required CharacterAttackData attack,
  required bool isCreating,
  required Future<void> Function(CharacterAttackData draft) onDraftChanged,
  Future<void> Function()? onDelete,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) {
      return _AttackDialog(
        attack: attack,
        isCreating: isCreating,
        onDraftChanged: onDraftChanged,
        onDelete: onDelete,
      );
    },
  );
}

class _AttackDialog extends StatefulWidget {
  const _AttackDialog({
    required this.attack,
    required this.isCreating,
    required this.onDraftChanged,
    this.onDelete,
  });

  final CharacterAttackData attack;
  final bool isCreating;
  final Future<void> Function(CharacterAttackData draft) onDraftChanged;
  final Future<void> Function()? onDelete;

  @override
  State<_AttackDialog> createState() => _AttackDialogState();
}

class _AttackDialogState extends State<_AttackDialog> {
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
    final suggestions = _matchingWeaponPropertySuggestions(
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
                      child: Text(_abilityLabel(ability)),
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
                      child: Text(_damageTypeLabel(value)),
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
                        label: Text(_tagLabel(tag)),
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
                        hintText: 'Например, finesse',
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
                        label: Text(_tagLabel(tag)),
                        onPressed: () => _addTag(tag),
                      ),
                  ],
                ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                ),
                minLines: 3,
                maxLines: 3,
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
      name: _normalizedText(_nameController.text),
      leadingAbility: _leadingAbility,
      damage: _normalizedText(_damageController.text),
      customAttackBonus: int.tryParse(_bonusController.text.trim()) ?? 0,
      damageType: _damageType,
      tags: _selectedTags,
      description: _normalizedText(_descriptionController.text),
    );
  }

  void _addTag(String rawValue) {
    final normalized = _normalizedText(rawValue);
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

      if (_attackEquals(_lastSavedDraft, draft)) {
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

String _formatAttackBonus(CharacterData character, CharacterAttackData attack) {
  final proficiencyBonus = character.derived?.proficiencyBonus ?? 0;
  final abilityModifier = attack.leadingAbility == null
      ? 0
      : character.derived?.abilityModifiers?[attack.leadingAbility!.name] ?? 0;
  final customBonus = attack.customAttackBonus ?? 0;
  final total = proficiencyBonus + abilityModifier + customBonus;
  return total >= 0 ? '+$total' : '$total';
}

String _formatDamageLabel(CharacterAttackData attack) {
  return attack.damage ?? 'Урон';
}

String _abilityLabel(Ability ability) {
  switch (ability) {
    case Ability.strength:
      return 'Сила';
    case Ability.dexterity:
      return 'Ловкость';
    case Ability.constitution:
      return 'Телосложение';
    case Ability.intelligence:
      return 'Интеллект';
    case Ability.wisdom:
      return 'Мудрость';
    case Ability.charisma:
      return 'Харизма';
  }
}

String _damageTypeLabel(DamageType damageType) {
  switch (damageType) {
    case DamageType.acid:
      return 'Кислота';
    case DamageType.bludgeoning:
      return 'Дробящий';
    case DamageType.cold:
      return 'Холод';
    case DamageType.fire:
      return 'Огонь';
    case DamageType.force:
      return 'Силовой';
    case DamageType.lightning:
      return 'Молния';
    case DamageType.necrotic:
      return 'Некротический';
    case DamageType.piercing:
      return 'Колющий';
    case DamageType.poison:
      return 'Яд';
    case DamageType.psychic:
      return 'Психический';
    case DamageType.radiant:
      return 'Излучение';
    case DamageType.slashing:
      return 'Рубящий';
    case DamageType.thunder:
      return 'Гром';
  }
}

String _tagLabel(String tag) {
  return _weaponPropertyLabels[tag.toLowerCase()] ?? tag;
}

List<String> _matchingWeaponPropertySuggestions({
  required String query,
  required List<String> selectedTags,
}) {
  final normalizedQuery = query.trim().toLowerCase();
  if (normalizedQuery.isEmpty) {
    return const [];
  }

  return _weaponPropertySuggestions.where((tag) {
    final alreadySelected = selectedTags.any(
      (selectedTag) => selectedTag.toLowerCase() == tag,
    );
    if (alreadySelected) {
      return false;
    }
    return tag.startsWith(normalizedQuery);
  }).toList();
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

bool _attackEquals(CharacterAttackData? left, CharacterAttackData right) {
  if (left == null) {
    return false;
  }

  return left.name == right.name &&
      left.leadingAbility == right.leadingAbility &&
      left.damage == right.damage &&
      left.customAttackBonus == right.customAttackBonus &&
      left.damageType == right.damageType &&
      left.description == right.description &&
      listEquals(left.tags, right.tags);
}

const List<String> _weaponPropertySuggestions = [
  'ammunition',
  'finesse',
  'heavy',
  'light',
  'loading',
  'range',
  'reach',
  'special',
  'thrown',
  'two-handed',
  'versatile',
];

const Map<String, String> _weaponPropertyLabels = {
  'ammunition': 'Ammunition',
  'finesse': 'Finesse',
  'heavy': 'Heavy',
  'light': 'Light',
  'loading': 'Loading',
  'range': 'Range',
  'reach': 'Reach',
  'special': 'Special',
  'thrown': 'Thrown',
  'two-handed': 'Two-Handed',
  'versatile': 'Versatile',
};
