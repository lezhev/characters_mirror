import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/compact_value_button.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpellPage extends ConsumerWidget {
  const SpellPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(humanReadableError(error)),
      ),
      data: (character) => Padding(
        padding: const EdgeInsets.all(12),
        child: PageSizeLimiter(
          child: SpellPageContent(
            character: character,
            onSlotCountChanged: ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .setCurrentSpellSlotsForLevel,
            onSpellCast: ref
                .read(characterSheetControllerProvider(characterId).notifier)
                .spendSpellSlot,
          ),
        ),
      ),
    );
  }
}

class SpellPageContent extends StatelessWidget {
  const SpellPageContent({
    required this.character,
    super.key,
    this.onSlotCountChanged,
    this.onSpellCast,
    this.diceRoller,
  });

  final CharacterData character;
  final Future<void> Function(int level, int available)? onSlotCountChanged;
  final Future<void> Function(int level)? onSpellCast;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    final spellStats = _spellStats(character);
    final spellsByLevel = _spellsByLevel(character);
    final cantrips = spellsByLevel[0] ?? const <SpellData>[];
    final spellLevels = _spellLevels(character, spellsByLevel);

    return ListView(
      children: [
        AppSectionHeader(
          title: 'Заклинания',
          showDivider: false,
          trailing: TextButton(
            onPressed: () {},
            child: const Icon(Icons.tune),
          ),
        ),
        const SizedBox(height: 12),
        SegmentedStatBar(
          segments: [
            SegmentedStatBarItem(
              label: 'Спасбросок',
              value: spellStats.saveDcLabel,
            ),
            SegmentedStatBarItem(
              label: 'Атака',
              value: spellStats.attackBonusLabel,
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SpellLevelSection(
          title: 'Заговоры',
          spells: cantrips,
          spellStats: spellStats,
          onSpellCast: onSpellCast,
          diceRoller: diceRoller,
        ),
        for (final level in spellLevels) ...[
          const SizedBox(height: 20),
          _SpellLevelSection(
            title: 'Уровень $level',
            spells: spellsByLevel[level] ?? const <SpellData>[],
            slots: _slotCount(character, level),
            currentSlots: _currentSlotCount(character, level),
            spellStats: spellStats,
            onSlotCountChanged: onSlotCountChanged == null
                ? null
                : (available) {
                    onSlotCountChanged!(level, available);
                  },
            onSpellCast: onSpellCast,
            diceRoller: diceRoller,
          ),
        ],
      ],
    );
  }
}

class _SpellLevelSection extends StatelessWidget {
  const _SpellLevelSection({
    required this.title,
    required this.spells,
    required this.spellStats,
    this.slots,
    this.currentSlots,
    this.onSlotCountChanged,
    this.onSpellCast,
    this.diceRoller,
  });

  final String title;
  final List<SpellData> spells;
  final _SpellStats spellStats;
  final int? slots;
  final int? currentSlots;
  final ValueChanged<int>? onSlotCountChanged;
  final Future<void> Function(int level)? onSpellCast;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SpellLevelHeader(
          title: title,
          slots: slots,
          currentSlots: currentSlots,
          onSlotCountChanged: onSlotCountChanged,
        ),
        const SizedBox(height: 8),
        for (var index = 0; index < spells.length; index++) ...[
          _SpellCard(
            spell: spells[index],
            spellStats: spellStats,
            availableSlots:
                (spells[index].level ?? 0) <= 0 ? null : currentSlots,
            onSpellCast: onSpellCast,
            diceRoller: diceRoller,
          ),
          if (index < spells.length - 1) const SizedBox(height: 4),
        ],
      ],
    );
  }
}

class _SpellLevelHeader extends StatelessWidget {
  const _SpellLevelHeader({
    required this.title,
    this.slots,
    this.currentSlots,
    this.onSlotCountChanged,
  });

  final String title;
  final int? slots;
  final int? currentSlots;
  final ValueChanged<int>? onSlotCountChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final slotCount = slots ?? 0;
    final availableSlots =
        (currentSlots ?? slotCount).clamp(0, slotCount).toInt();

    return Row(
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (slots != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outline,
            ),
          ),
          const SizedBox(width: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var index = 0; index < slotCount; index++)
                _SpellSlotFlag(
                  key: ValueKey('spell-slot-$title-$index'),
                  value: index < availableSlots,
                  onPressed: onSlotCountChanged == null
                      ? null
                      : () {
                          final nextAvailable = index < availableSlots
                              ? availableSlots - 1
                              : availableSlots + 1;
                          onSlotCountChanged!(nextAvailable);
                        },
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _SpellSlotFlag extends StatelessWidget {
  const _SpellSlotFlag({
    required this.value,
    super.key,
    this.onPressed,
  });

  final bool value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      button: onPressed != null,
      selected: value,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox.square(
          dimension: 22,
          child: Center(
            child: SizedBox.square(
              dimension: 18,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.primary),
                ),
                child: value
                    ? Center(
                        child: SizedBox.square(
                          dimension: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SpellCard extends StatelessWidget {
  const _SpellCard({
    required this.spell,
    required this.spellStats,
    required this.availableSlots,
    this.onSpellCast,
    this.diceRoller,
  });

  final SpellData spell;
  final _SpellStats spellStats;
  final int? availableSlots;
  final Future<void> Function(int level)? onSpellCast;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final disabledBySlots =
        (spell.level ?? 0) > 0 && (availableSlots ?? 0) <= 0;
    final canCast = onSpellCast != null &&
        !disabledBySlots &&
        (spell.requiresAttackRoll != true || spellStats.canRollSpellAttack);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _spellName(spell),
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _SpellPrimaryMetadata(spell: spell),
                ],
              ),
            ),
            const SizedBox(width: 12),
            KeyedSubtree(
              key: ValueKey(
                  'cast-spell-${_spellKey(spell) ?? _spellName(spell)}'),
              child: _SpellCastButton(
                spell: spell,
                spellStats: spellStats,
                enabled: canCast,
                onPressed: () => _castSpell(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _castSpell(BuildContext context) async {
    await onSpellCast?.call(spell.level ?? 0);
    if (!context.mounted) {
      return;
    }

    if (spell.requiresSavingThrow == true) {
      RollResultsOverlay.show(
        context,
        _spellSavingThrowMessage(spell, spellStats),
      );
      return;
    }

    if (spell.requiresAttackRoll == true) {
      final roller = diceRoller ?? DiceRoller();
      try {
        final result = roller.rollModifier(spellStats.attackBonusLabel);
        RollResultsOverlay.show(context, result.displayText);
      } on DiceRollException catch (error) {
        RollResultsOverlay.show(context, error.message);
      }
    }
  }
}

class _SpellCastButton extends StatelessWidget {
  const _SpellCastButton({
    required this.spell,
    required this.spellStats,
    required this.enabled,
    required this.onPressed,
  });

  final SpellData spell;
  final _SpellStats spellStats;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (spell.requiresAttackRoll == true) {
      return CompactValueButton(
        label: spellStats.attackBonusLabel,
        width: 54,
        onPressed: enabled ? onPressed : null,
      );
    }

    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: const Icon(Icons.auto_awesome, size: 18),
    );
  }
}

class _SpellPrimaryMetadata extends StatelessWidget {
  const _SpellPrimaryMetadata({
    required this.spell,
  });

  final SpellData spell;

  @override
  Widget build(BuildContext context) {
    final items = [
      if (_normalizedText(spell.castingTime) != null)
        _SpellMetadataItem(
          icon: Icons.bolt,
          label: _spellCastingTimeLabel(spell.castingTime!),
        ),
      if (_normalizedText(spell.range) != null)
        _SpellMetadataItem(
          icon: Icons.swap_horiz,
          label: spell.range!.trim(),
        ),
      if (_normalizedText(spell.duration) != null)
        _SpellMetadataItem(
          icon: Icons.hourglass_empty,
          label: spell.duration!.trim(),
        ),
    ];
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: items,
    );
  }
}

class _SpellMetadataItem extends StatelessWidget {
  const _SpellMetadataItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colorScheme.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

String _spellCastingTimeLabel(String value) {
  final trimmed = value.trim();
  if (trimmed.toLowerCase().startsWith('реакция')) {
    return 'Реакция';
  }
  return trimmed;
}

String _spellSavingThrowMessage(SpellData spell, _SpellStats spellStats) {
  final ability = _savingThrowAbilityGenitiveLabel(spell.savingThrowAbility) ??
      'характеристики';
  return 'Цель должна пройти спасбросок $ability '
      'со сложностью ${spellStats.saveDcLabel}';
}

String? _savingThrowAbilityGenitiveLabel(String? value) {
  switch (_normalizedText(value)?.toLowerCase()) {
    case 'strength':
      return 'Силы';
    case 'dexterity':
      return 'Ловкости';
    case 'constitution':
      return 'Телосложения';
    case 'intelligence':
      return 'Интеллекта';
    case 'wisdom':
      return 'Мудрости';
    case 'charisma':
      return 'Харизмы';
  }
  return _normalizedText(value);
}

_SpellStats _spellStats(CharacterData character) {
  final ability = _spellcastingAbility(character);
  if (ability == null) {
    return const _SpellStats(
      saveDcLabel: '—',
      attackBonusLabel: '—',
    );
  }

  final proficiencyBonus = character.derived?.proficiencyBonus ?? 0;
  final abilityModifier = character.derived?.abilityModifiers?[ability.name] ??
      _abilityModifier(character.baseAbilityScores?[ability.name] ?? 10);
  final attackBonus = proficiencyBonus + abilityModifier;
  final saveDc = 8 + attackBonus;

  return _SpellStats(
    saveDcLabel: '$saveDc',
    attackBonusLabel: _signedLabel(attackBonus),
    canRollSpellAttack: true,
  );
}

Map<int, List<SpellData>> _spellsByLevel(CharacterData character) {
  final result = <int, List<SpellData>>{};
  final seen = <String>{};
  final selections = [...?character.spellSelections]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );

  for (final selection in selections) {
    final spell = selection.spell;
    if (spell == null) {
      continue;
    }
    final key = _spellKey(spell);
    if (key == null || !seen.add(key)) {
      continue;
    }
    final level = spell.level ?? 0;
    result.putIfAbsent(level, () => <SpellData>[]).add(spell);
  }

  return result;
}

List<int> _spellLevels(
  CharacterData character,
  Map<int, List<SpellData>> spellsByLevel,
) {
  final levels = <int>{};
  for (final level in spellsByLevel.keys) {
    if (level > 0) {
      levels.add(level);
    }
  }
  for (final level in character.derived?.spellSlots?.keys ?? const <int>[]) {
    if (_slotCount(character, level) > 0) {
      levels.add(level);
    }
  }
  for (final level in character.derived?.pactSlots?.keys ?? const <int>[]) {
    if (_slotCount(character, level) > 0) {
      levels.add(level);
    }
  }
  return levels.toList()..sort();
}

int _slotCount(CharacterData character, int level) {
  return (character.derived?.spellSlots?[level] ?? 0) +
      (character.derived?.pactSlots?[level] ?? 0);
}

int _currentSlotCount(CharacterData character, int level) {
  final maxSlots = _slotCount(character, level);
  return (character.currentSpellSlots?[level] ?? maxSlots)
      .clamp(0, maxSlots)
      .toInt();
}

String _spellName(SpellData spell) {
  return _normalizedText(spell.name) ??
      _normalizedText(spell.referenceKey) ??
      'Заклинание';
}

String? _spellKey(SpellData spell) {
  return _normalizedText(spell.referenceKey) ?? _normalizedText(spell.name);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

Ability? _spellcastingAbility(CharacterData character) {
  final entries = [...?character.classEntries]
    ..sort((left, right) => (left.classOrder ?? 0).compareTo(
          right.classOrder ?? 0,
        ));

  for (final entry in entries) {
    final ability = entry.classData?.spellcastingAbilityValue;
    if (ability != null) {
      return ability;
    }
  }
  return null;
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

String _signedLabel(int value) => value >= 0 ? '+$value' : '$value';

class _SpellStats {
  const _SpellStats({
    required this.saveDcLabel,
    required this.attackBonusLabel,
    this.canRollSpellAttack = false,
  });

  final String saveDcLabel;
  final String attackBonusLabel;
  final bool canRollSpellAttack;
}
