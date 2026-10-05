import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';
import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_details_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'spell_page/spell_level_widgets.dart';
part 'spell_page/spell_management.dart';
part 'spell_page/spell_helpers.dart';

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
            onSlotCountChanged: (level, available) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .setCurrentSpellSlotsForLevel(level, available),
              );
              return Future.value();
            },
            onSpellCast: (spell) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .castSpell(spell),
              );
              return Future.value();
            },
            onSpellcastingBonusesChanged: (saveDcBonus, attackBonus) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .saveSpellcastingBonuses(
                      saveDcBonus: saveDcBonus,
                      attackBonus: attackBonus,
                    ),
              );
              return Future.value();
            },
            onSpellPreparedChanged: (spell, prepared, classDataId) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .setSpellPrepared(
                      spell,
                      prepared,
                      classDataId: classDataId,
                    ),
              );
              return Future.value();
            },
            onSpellLearned: (spell, classDataId) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .learnSpell(spell, classDataId: classDataId),
              );
              return Future.value();
            },
            onSpellForgotten: (spell) {
              runCharacterSheetSave(
                context,
                ref
                    .read(
                        characterSheetControllerProvider(characterId).notifier)
                    .forgetSpell(spell,
                        classDataId: _primarySpellClassId(character)),
              );
              return Future.value();
            },
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
    this.onSpellcastingBonusesChanged,
    this.onSpellPreparedChanged,
    this.onSpellLearned,
    this.onSpellForgotten,
    this.diceRoller,
  });

  final CharacterData character;
  final Future<void> Function(int level, int available)? onSlotCountChanged;
  final Future<void> Function(SpellData spell)? onSpellCast;
  final Future<void> Function(int saveDcBonus, int attackBonus)?
      onSpellcastingBonusesChanged;
  final Future<void> Function(SpellData spell, bool prepared, int? classDataId)?
      onSpellPreparedChanged;
  final Future<void> Function(SpellData spell, int? classDataId)?
      onSpellLearned;
  final Future<void> Function(SpellData spell)? onSpellForgotten;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    final spellStats = _spellStats(character);
    final preparation = _spellPreparationState(character);
    final spellsByLevel = _spellEntriesByLevel(character, preparation);
    final cantrips = spellsByLevel[0] ?? const <_SpellEntry>[];
    final spellLevels = _spellLevels(character, spellsByLevel);
    final castButtonWidth = _spellCastButtonWidth(
      context,
      spellStats.attackBonusLabel,
    );

    return ListView(
      children: [
        AppSectionHeader(
          title: 'Заклинания',
          showDivider: false,
          trailing: TextButton(
            onPressed: () => _openSpellManagementPage(context, spellStats),
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
          entries: cantrips,
          spellStats: spellStats,
          castButtonWidth: castButtonWidth,
          onSpellCast: onSpellCast,
          diceRoller: diceRoller,
        ),
        for (final level in spellLevels) ...[
          const SizedBox(height: 20),
          _SpellLevelSection(
            title: 'Круг $level',
            entries: spellsByLevel[level] ?? const <_SpellEntry>[],
            slots: _slotCount(character, level),
            currentSlots: _currentSlotCount(character, level),
            spellStats: spellStats,
            castButtonWidth: castButtonWidth,
            onSlotCountChanged: onSlotCountChanged == null
                ? null
                : (available) {
                    onSlotCountChanged!(level, available);
                  },
            onSpellCast: onSpellCast,
            diceRoller: diceRoller,
          ),
        ],
        const SizedBox(height: 24),
        const SpellIconLegend(),
      ],
    );
  }

  void _openSpellManagementPage(BuildContext context, _SpellStats spellStats) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _SpellManagementPage(
          character: character,
          spellStats: spellStats,
          onSpellcastingBonusesChanged: onSpellcastingBonusesChanged,
          onSpellPreparedChanged: onSpellPreparedChanged,
          onSpellLearned: onSpellLearned,
          onSpellForgotten: onSpellForgotten,
        ),
      ),
    );
  }
}
