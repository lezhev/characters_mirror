import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
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
                    .forgetSpell(spell),
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

class _SpellLevelSection extends StatelessWidget {
  const _SpellLevelSection({
    required this.title,
    required this.entries,
    required this.spellStats,
    required this.castButtonWidth,
    this.slots,
    this.currentSlots,
    this.onSlotCountChanged,
    this.onSpellCast,
    this.diceRoller,
  });

  final String title;
  final List<_SpellEntry> entries;
  final _SpellStats spellStats;
  final double castButtonWidth;
  final int? slots;
  final int? currentSlots;
  final ValueChanged<int>? onSlotCountChanged;
  final Future<void> Function(SpellData spell)? onSpellCast;
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
        for (var index = 0; index < entries.length; index++) ...[
          _SpellCard(
            entry: entries[index],
            spellStats: spellStats,
            castButtonWidth: castButtonWidth,
            availableSlots:
                (entries[index].spell.level ?? 0) <= 0 ? null : currentSlots,
            onSpellCast: onSpellCast,
            diceRoller: diceRoller,
          ),
          if (index < entries.length - 1) const SizedBox(height: 4),
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
    required this.entry,
    required this.spellStats,
    required this.castButtonWidth,
    required this.availableSlots,
    this.onSpellCast,
    this.diceRoller,
  });

  final _SpellEntry entry;
  final _SpellStats spellStats;
  final double castButtonWidth;
  final int? availableSlots;
  final Future<void> Function(SpellData spell)? onSpellCast;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final spell = entry.spell;
    final disabledBySlots =
        (spell.level ?? 0) > 0 && (availableSlots ?? 0) <= 0;
    final disabledByPreparation =
        entry.canPrepare && !entry.isPrepared && (spell.level ?? 0) > 0;
    final canCast = onSpellCast != null &&
        !disabledBySlots &&
        !disabledByPreparation &&
        (spell.requiresAttackRoll != true || spellStats.canRollSpellAttack);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => showSpellDetailsDialog(context, spell),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spellName(spell),
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    SpellPrimaryMetadata(spell: spell),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              KeyedSubtree(
                key: ValueKey(
                    'cast-spell-${spellKey(spell) ?? spellName(spell)}'),
                child: _SpellCastButton(
                  spell: spell,
                  spellStats: spellStats,
                  width: castButtonWidth,
                  enabled: canCast,
                  onPressed: () => _castSpell(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _castSpell(BuildContext context) async {
    final spell = entry.spell;
    await onSpellCast?.call(spell);
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
    required this.width,
    required this.enabled,
    required this.onPressed,
  });

  final SpellData spell;
  final _SpellStats spellStats;
  final double width;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (spell.requiresAttackRoll == true) {
      return SizedBox(
        width: width,
        child: OutlinedButton(
          onPressed: enabled ? onPressed : null,
          style: _spellCastButtonStyle(
            horizontalPadding: 8,
            verticalPadding: 10,
          ),
          child: Text(
            spellStats.attackBonusLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: _spellCastButtonStyle(
          horizontalPadding: 10,
          verticalPadding: 10,
        ),
        child: const Icon(Icons.auto_awesome, size: 18),
      ),
    );
  }
}

class _SpellManagementPage extends StatefulWidget {
  const _SpellManagementPage({
    required this.character,
    required this.spellStats,
    this.onSpellcastingBonusesChanged,
    this.onSpellPreparedChanged,
    this.onSpellLearned,
    this.onSpellForgotten,
  });

  final CharacterData character;
  final _SpellStats spellStats;
  final Future<void> Function(int saveDcBonus, int attackBonus)?
      onSpellcastingBonusesChanged;
  final Future<void> Function(SpellData spell, bool prepared, int? classDataId)?
      onSpellPreparedChanged;
  final Future<void> Function(SpellData spell, int? classDataId)?
      onSpellLearned;
  final Future<void> Function(SpellData spell)? onSpellForgotten;

  @override
  State<_SpellManagementPage> createState() => _SpellManagementPageState();
}

class _SpellManagementPageState extends State<_SpellManagementPage> {
  late CharacterData _character;
  late final TextEditingController _saveDcController;
  late final TextEditingController _attackController;
  late Future<_SpellManagementData> _dataFuture;

  @override
  void initState() {
    super.initState();
    _character = widget.character;
    _saveDcController = TextEditingController(
      text: widget.spellStats.finalSaveDc.toString(),
    );
    _attackController = TextEditingController(
      text: widget.spellStats.finalAttackBonus.toString(),
    );
    _dataFuture = _loadData();
  }

  @override
  void dispose() {
    _saveDcController.dispose();
    _attackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки заклинаний')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: _SpellcastingSettingsPanel(
              spellStats: widget.spellStats,
              saveDcController: _saveDcController,
              attackController: _attackController,
              onChanged: _saveSpellcastingBonuses,
            ),
          ),
          Expanded(
            child: FutureBuilder<_SpellManagementData>(
              future: _dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                      child: Text(humanReadableError(snapshot.error!)));
                }

                final data = snapshot.data!;
                final tabCount = data.canPrepare ? 2 : 1;
                return DefaultTabController(
                  length: tabCount,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          if (data.canPrepare)
                            const Tab(text: 'Подготовленные'),
                          const Tab(text: 'Известные'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            if (data.canPrepare)
                              _PreparedSpellsTab(
                                preparedSpells: data.preparedSpells,
                                preparationSourceSpells:
                                    data.preparationSourceSpells,
                                preparedCountLimit: data.preparedCountLimit,
                                onUnprepareSpell: (spell) => _setSpellPrepared(
                                  spell,
                                  false,
                                  data.primaryClassDataId,
                                ),
                                onPrepareSpell: (spell) => _setSpellPrepared(
                                  spell,
                                  true,
                                  data.primaryClassDataId,
                                ),
                              ),
                            _KnownSpellsTab(
                              knownSpells: data.knownSpells,
                              availableSpells: data.learnableSpells,
                              onForgetSpell: _forgetSpell,
                              onLearnSpell: (spell) => _learnSpell(
                                spell,
                                data.primaryClassDataId,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<_SpellManagementData> _loadData() async {
    final allSpells = await SpellRepository().getAll();
    final classLevels = await ClassLevelRepository().getAll();
    return _buildSpellManagementData(_character, allSpells, classLevels);
  }

  Future<void> _saveSpellcastingBonuses() async {
    final saveDc = int.tryParse(_saveDcController.text.trim());
    final attack = int.tryParse(_attackController.text.trim());
    if (saveDc == null || attack == null) {
      return;
    }
    final saveDcBonus = saveDc - widget.spellStats.baseSaveDc!;
    final attackBonus = attack - widget.spellStats.baseAttackBonus!;
    await widget.onSpellcastingBonusesChanged?.call(
      saveDcBonus,
      attackBonus,
    );
    setState(() {
      _character = _character.copyWith(
        customSpellSaveDcBonus: saveDcBonus == 0 ? null : saveDcBonus,
        customSpellAttackBonus: attackBonus == 0 ? null : attackBonus,
      );
    });
  }

  Future<void> _learnSpell(SpellData spell, int? classDataId) async {
    await widget.onSpellLearned?.call(spell, classDataId);
    setState(() {
      _character = _character.copyWith(
        spellSelections: _addSpellSelection(
          _character.spellSelections,
          spell,
          classDataId,
        ),
      );
      _dataFuture = _loadData();
    });
  }

  Future<void> _forgetSpell(SpellData spell) async {
    await widget.onSpellForgotten?.call(spell);
    final key = spellKey(spell);
    setState(() {
      _character = _character.copyWith(
        spellSelections: [
          for (final selection in _character.spellSelections ??
              const <CharacterSpellSelectionData>[])
            if (_spellSelectionKey(selection) != key) selection,
        ],
        preparedSpellKeys: [
          for (final preparedKey in _effectivePreparedKeys(_character))
            if (preparedKey != key) preparedKey,
        ],
      );
      _dataFuture = _loadData();
    });
  }

  Future<void> _setSpellPrepared(
    SpellData spell,
    bool prepared,
    int? classDataId,
  ) async {
    await widget.onSpellPreparedChanged?.call(spell, prepared, classDataId);
    final key = spellKey(spell);
    if (key == null) {
      return;
    }
    final preparedKeys = _effectivePreparedKeys(_character)..remove(key);
    if (prepared) {
      preparedKeys.add(key);
    }
    setState(() {
      _character = _character.copyWith(
        spellSelections: _hasSpell(_character, key)
            ? _character.spellSelections
            : _addSpellSelection(
                _character.spellSelections,
                spell,
                classDataId,
              ),
        preparedSpellKeys: preparedKeys.toList()..sort(),
      );
      _dataFuture = _loadData();
    });
  }
}

class _SpellcastingSettingsPanel extends StatelessWidget {
  const _SpellcastingSettingsPanel({
    required this.spellStats,
    required this.saveDcController,
    required this.attackController,
    required this.onChanged,
  });

  final _SpellStats spellStats;
  final TextEditingController saveDcController;
  final TextEditingController attackController;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canEdit = spellStats.canEdit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('СЛ и атака', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (canEdit)
          Text(
            'Базовые значения: СЛ ${spellStats.baseSaveDc}, '
            'атака ${_signedLabel(spellStats.baseAttackBonus!)}.',
            style: theme.textTheme.bodySmall,
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                key: const ValueKey('spell-save-dc-field'),
                controller: saveDcController,
                enabled: canEdit,
                keyboardType: TextInputType.number,
                onChanged: (_) => onChanged(),
                onSubmitted: (_) => onChanged(),
                decoration: const InputDecoration(
                  labelText: 'Итоговая сложность',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                key: const ValueKey('spell-attack-bonus-field'),
                controller: attackController,
                enabled: canEdit,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                onChanged: (_) => onChanged(),
                onSubmitted: (_) => onChanged(),
                decoration: const InputDecoration(labelText: 'Итоговая атака'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _KnownSpellsTab extends StatelessWidget {
  const _KnownSpellsTab({
    required this.knownSpells,
    required this.availableSpells,
    required this.onForgetSpell,
    required this.onLearnSpell,
  });

  final List<SpellData> knownSpells;
  final List<SpellData> availableSpells;
  final Future<void> Function(SpellData spell) onForgetSpell;
  final Future<void> Function(SpellData spell) onLearnSpell;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _SpellManagementSection(
          emptyText: 'Нет известных заклинаний.',
          spells: knownSpells,
          actionLabel: 'Убрать',
          onAction: onForgetSpell,
        ),
        const SizedBox(height: 20),
        _SpellManagementSection(
          title: 'Доступные',
          emptyText: 'Нет доступных заклинаний для изучения.',
          spells: availableSpells,
          actionLabel: 'Выучить',
          onAction: onLearnSpell,
        ),
      ],
    );
  }
}

class _PreparedSpellsTab extends StatelessWidget {
  const _PreparedSpellsTab({
    required this.preparedSpells,
    required this.preparationSourceSpells,
    required this.preparedCountLimit,
    required this.onUnprepareSpell,
    required this.onPrepareSpell,
  });

  final List<SpellData> preparedSpells;
  final List<SpellData> preparationSourceSpells;
  final int? preparedCountLimit;
  final Future<void> Function(SpellData spell) onUnprepareSpell;
  final Future<void> Function(SpellData spell) onPrepareSpell;

  @override
  Widget build(BuildContext context) {
    final limitReached = preparedCountLimit != null &&
        preparedSpells.length >= preparedCountLimit!;

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        if (preparedCountLimit != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Подготовлено ${preparedSpells.length} '
                'из $preparedCountLimit'),
          ),
        _SpellManagementSection(
          emptyText: 'Нет подготовленных заклинаний.',
          spells: preparedSpells,
          actionLabel: 'Убрать',
          onAction: onUnprepareSpell,
        ),
        const SizedBox(height: 20),
        _SpellManagementSection(
          emptyText: 'Нет заклинаний для подготовки.',
          spells: preparationSourceSpells,
          actionLabel: 'Подготовить',
          onAction: limitReached ? null : onPrepareSpell,
        ),
      ],
    );
  }
}

class _SpellManagementSection extends StatelessWidget {
  const _SpellManagementSection({
    required this.emptyText,
    required this.spells,
    required this.actionLabel,
    required this.onAction,
    this.title,
  });

  final String? title;
  final String emptyText;
  final List<SpellData> spells;
  final String actionLabel;
  final Future<void> Function(SpellData spell)? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
        ],
        if (spells.isEmpty)
          Text(emptyText, style: theme.textTheme.bodyMedium)
        else
          for (final spell in spells)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(spellName(spell)),
              subtitle: Text(_spellLevelLabel(spell)),
              trailing: TextButton(
                onPressed: onAction == null ? null : () => onAction!(spell),
                child: Text(actionLabel),
              ),
              onTap: () => showSpellDetailsDialog(context, spell),
            ),
      ],
    );
  }
}

ButtonStyle _spellCastButtonStyle({
  required double horizontalPadding,
  required double verticalPadding,
}) {
  return OutlinedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    minimumSize: const Size(0, 0),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

double _spellCastButtonWidth(BuildContext context, String attackBonusLabel) {
  final textStyle =
      Theme.of(context).textTheme.labelLarge ?? const TextStyle(fontSize: 14);
  final textPainter = TextPainter(
    text: TextSpan(text: attackBonusLabel, style: textStyle),
    maxLines: 1,
    textDirection: Directionality.of(context),
  )..layout();

  const attackHorizontalPadding = 16.0;
  const iconHorizontalPadding = 20.0;
  const iconSize = 18.0;
  return math.max(
    textPainter.width + attackHorizontalPadding,
    iconSize + iconHorizontalPadding,
  );
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
  final baseAttackBonus = proficiencyBonus + abilityModifier;
  final baseSaveDc = 8 + baseAttackBonus;
  final attackBonus = baseAttackBonus + (character.customSpellAttackBonus ?? 0);
  final saveDc = baseSaveDc + (character.customSpellSaveDcBonus ?? 0);

  return _SpellStats(
    saveDcLabel: '$saveDc',
    attackBonusLabel: _signedLabel(attackBonus),
    baseSaveDc: baseSaveDc,
    baseAttackBonus: baseAttackBonus,
    saveDcBonus: character.customSpellSaveDcBonus ?? 0,
    attackBonus: character.customSpellAttackBonus ?? 0,
    canRollSpellAttack: true,
  );
}

Map<int, List<_SpellEntry>> _spellEntriesByLevel(
  CharacterData character,
  _SpellPreparationState preparation,
) {
  final result = <int, List<_SpellEntry>>{};
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
    final key = spellKey(spell);
    if (key == null || !seen.add(key)) {
      continue;
    }
    final level = spell.level ?? 0;
    final isPrepared = preparation.preparedKeys.contains(key) ||
        preparation.alwaysPreparedKeys.contains(key);
    if (preparation.canPrepare && level > 0 && !isPrepared) {
      continue;
    }
    result.putIfAbsent(level, () => <_SpellEntry>[]).add(
          _SpellEntry(
            spell: spell,
            canPrepare: preparation.canPrepare && level > 0,
            isPrepared: isPrepared,
            isAlwaysPrepared: preparation.alwaysPreparedKeys.contains(key),
          ),
        );
  }

  return result;
}

List<int> _spellLevels(
  CharacterData character,
  Map<int, List<_SpellEntry>> spellsByLevel,
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

_SpellPreparationState _spellPreparationState(CharacterData character) {
  final alwaysPreparedKeys = {
    for (final key in character.derived?.alwaysPreparedSpellKeys ?? const [])
      if (_normalizedText(key) != null) _normalizedText(key)!,
  };
  final defaultPreparedKeys = {
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selection.kind == CharacterSpellSelectionKind.preparedSpell &&
          _spellSelectionKey(selection) != null)
        _spellSelectionKey(selection)!,
  };
  final explicitPreparedKeys = character.preparedSpellKeys;
  final preparedKeys = explicitPreparedKeys == null
      ? defaultPreparedKeys
      : {
          for (final key in explicitPreparedKeys)
            if (_normalizedText(key) != null) _normalizedText(key)!,
        };

  return _SpellPreparationState(
    canPrepare: defaultPreparedKeys.isNotEmpty || explicitPreparedKeys != null,
    preparedKeys: preparedKeys,
    alwaysPreparedKeys: alwaysPreparedKeys,
  );
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spellKey) ?? spellKey(selection.spell);
}

_SpellManagementData _buildSpellManagementData(
  CharacterData character,
  List<SpellData> allSpells,
  List<ClassLevelData> classLevels,
) {
  final classIds = {
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (entry.classData?.id != null) entry.classData!.id!,
  };
  final subclassIds = {
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (entry.subclass?.id != null) entry.subclass!.id!,
  };
  final knownSpells = _knownSpells(character);
  final knownKeys = {
    for (final spell in knownSpells)
      if (spellKey(spell) != null) spellKey(spell)!,
  };
  final maxLevel = _maxAvailableSpellLevel(character);
  final availableSpells = [
    for (final spell in allSpells)
      if (_isSpellAvailableForCharacter(
            spell,
            classIds: classIds,
            subclassIds: subclassIds,
          ) &&
          (spell.level ?? 0) <= maxLevel)
        spell,
  ]..sort(_compareSpells);

  final preparedContexts = _preparedClassContexts(character, classLevels);
  final canPrepare = preparedContexts.isNotEmpty;
  final isWizard = preparedContexts.any((entry) {
    final name = entry.classData?.name?.trim().toLowerCase() ?? '';
    return name.contains('wizard') || name.contains('волшеб');
  });
  final preparedKeys = _effectivePreparedKeys(character);
  final spellByKey = <String, SpellData>{
    for (final spell in availableSpells)
      if (spellKey(spell) != null) spellKey(spell)!: spell,
    for (final spell in knownSpells)
      if (spellKey(spell) != null) spellKey(spell)!: spell,
  };
  final preparedSpells = [
    for (final key in preparedKeys)
      if (spellByKey[key] != null && (spellByKey[key]!.level ?? 0) > 0)
        spellByKey[key]!,
  ]..sort(_compareSpells);
  final preparationPool =
      (isWizard ? knownSpells : availableSpells).where((spell) {
    final key = spellKey(spell);
    return (spell.level ?? 0) > 0 && key != null && !preparedKeys.contains(key);
  }).toList()
        ..sort(_compareSpells);

  return _SpellManagementData(
    canPrepare: canPrepare,
    primaryClassDataId: _primarySpellClassId(character),
    knownSpells: knownSpells,
    learnableSpells: [
      for (final spell in availableSpells)
        if (spellKey(spell) != null && !knownKeys.contains(spellKey(spell)))
          spell,
    ],
    preparedSpells: preparedSpells,
    preparationSourceSpells: preparationPool,
    preparedCountLimit: _preparedSpellCountLimit(
      character,
      preparedContexts,
      classLevels,
    ),
  );
}

List<SpellData> _knownSpells(CharacterData character) {
  final seen = <String>{};
  final result = <SpellData>[];
  final selections = [...?character.spellSelections]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );
  for (final selection in selections) {
    final spell = selection.spell;
    final key = _spellSelectionKey(selection);
    if (spell == null || key == null || !seen.add(key)) {
      continue;
    }
    result.add(spell);
  }
  return result..sort(_compareSpells);
}

bool _isSpellAvailableForCharacter(
  SpellData spell, {
  required Set<int> classIds,
  required Set<int> subclassIds,
}) {
  return spell.availableForClassIds?.any(classIds.contains) == true ||
      spell.availableForSubclassIds?.any(subclassIds.contains) == true;
}

int _maxAvailableSpellLevel(CharacterData character) {
  final levels = [
    ...?character.derived?.spellSlots?.keys,
    ...?character.derived?.pactSlots?.keys,
  ];
  if (levels.isEmpty) {
    return 9;
  }
  return levels.reduce(math.max);
}

List<CharacterClassEntryData> _preparedClassContexts(
  CharacterData character,
  List<ClassLevelData> classLevels,
) {
  return [
    for (final entry
        in character.classEntries ?? const <CharacterClassEntryData>[])
      if (_classLevelForEntry(entry, classLevels)
              ?.preparedSpellFormula
              ?.trim()
              .isNotEmpty ==
          true)
        entry,
  ];
}

ClassLevelData? _classLevelForEntry(
  CharacterClassEntryData entry,
  List<ClassLevelData> classLevels,
) {
  final classId = entry.classData?.id;
  final level = entry.level ?? 1;
  if (classId == null) {
    return null;
  }
  for (final classLevel in classLevels) {
    if (classLevel.classDataId == classId && classLevel.level == level) {
      return classLevel;
    }
  }
  return null;
}

int? _preparedSpellCountLimit(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassLevelData> classLevels,
) {
  var total = 0;
  for (final entry in entries) {
    final formula =
        _classLevelForEntry(entry, classLevels)?.preparedSpellFormula;
    final count = _preparedSpellCount(
      formula,
      character: character,
      classLevel: entry.level ?? 1,
    );
    if (count != null) {
      total += count;
    }
  }
  return total == 0 ? null : total;
}

int? _preparedSpellCount(
  String? formula, {
  required CharacterData character,
  required int classLevel,
}) {
  final normalizedFormula = formula?.trim().toLowerCase();
  if (normalizedFormula == null || normalizedFormula.isEmpty) {
    return null;
  }
  Ability? ability;
  for (final candidate in Ability.values) {
    if (normalizedFormula.contains('${candidate.name} modifier')) {
      ability = candidate;
      break;
    }
  }
  if (ability == null || !normalizedFormula.contains('level')) {
    return null;
  }
  final score = character.derived?.abilityScores?[ability.name] ??
      character.baseAbilityScores?[ability.name] ??
      10;
  final count = _abilityModifier(score) + classLevel;
  return count < 1 ? 1 : count;
}

int? _primarySpellClassId(CharacterData character) {
  final entries = [...?character.classEntries]
    ..sort((left, right) => (left.classOrder ?? 0).compareTo(
          right.classOrder ?? 0,
        ));
  for (final entry in entries) {
    if (entry.classData?.spellcastingAbilityValue != null &&
        entry.classData?.id != null) {
      return entry.classData!.id;
    }
  }
  return entries.firstOrNull?.classData?.id;
}

Set<String> _effectivePreparedKeys(CharacterData character) {
  final explicit = character.preparedSpellKeys;
  if (explicit != null) {
    return {
      for (final key in explicit)
        if (_normalizedText(key) != null) _normalizedText(key)!,
    };
  }
  return {
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selection.kind == CharacterSpellSelectionKind.preparedSpell &&
          _spellSelectionKey(selection) != null)
        _spellSelectionKey(selection)!,
  };
}

List<CharacterSpellSelectionData> _addSpellSelection(
  List<CharacterSpellSelectionData>? selections,
  SpellData spell,
  int? classDataId,
) {
  final key = spellKey(spell);
  final next = [...?selections];
  if (key == null ||
      next.any((selection) => _spellSelectionKey(selection) == key)) {
    return next;
  }
  next.add(
    CharacterSpellSelectionData(
      classDataId: classDataId,
      spell: spell,
      spellId: spell.id,
      spellKey: key,
      kind: (spell.level ?? 0) <= 0
          ? CharacterSpellSelectionKind.knownCantrip
          : CharacterSpellSelectionKind.knownSpell,
      selectionIndex: next.length,
    ),
  );
  return next;
}

bool _hasSpell(CharacterData character, String key) {
  return (character.spellSelections ?? const <CharacterSpellSelectionData>[])
      .any((selection) => _spellSelectionKey(selection) == key);
}

String _spellLevelLabel(SpellData spell) {
  final level = spell.level ?? 0;
  return level <= 0 ? 'Заговор' : 'Круг $level';
}

int _compareSpells(SpellData left, SpellData right) {
  final levelCompare = (left.level ?? 0).compareTo(right.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }
  return spellName(left).compareTo(spellName(right));
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

String _signedLabel(int value) => value >= 0 ? '+$value' : '$value';

class _SpellEntry {
  const _SpellEntry({
    required this.spell,
    required this.canPrepare,
    required this.isPrepared,
    required this.isAlwaysPrepared,
  });

  final SpellData spell;
  final bool canPrepare;
  final bool isPrepared;
  final bool isAlwaysPrepared;
}

class _SpellPreparationState {
  const _SpellPreparationState({
    required this.canPrepare,
    required this.preparedKeys,
    required this.alwaysPreparedKeys,
  });

  final bool canPrepare;
  final Set<String> preparedKeys;
  final Set<String> alwaysPreparedKeys;
}

class _SpellManagementData {
  const _SpellManagementData({
    required this.canPrepare,
    required this.primaryClassDataId,
    required this.knownSpells,
    required this.learnableSpells,
    required this.preparedSpells,
    required this.preparationSourceSpells,
    required this.preparedCountLimit,
  });

  final bool canPrepare;
  final int? primaryClassDataId;
  final List<SpellData> knownSpells;
  final List<SpellData> learnableSpells;
  final List<SpellData> preparedSpells;
  final List<SpellData> preparationSourceSpells;
  final int? preparedCountLimit;
}

class _SpellStats {
  const _SpellStats({
    required this.saveDcLabel,
    required this.attackBonusLabel,
    this.baseSaveDc,
    this.baseAttackBonus,
    this.saveDcBonus = 0,
    this.attackBonus = 0,
    this.canRollSpellAttack = false,
  });

  final String saveDcLabel;
  final String attackBonusLabel;
  final int? baseSaveDc;
  final int? baseAttackBonus;
  final int saveDcBonus;
  final int attackBonus;
  final bool canRollSpellAttack;

  bool get canEdit => baseSaveDc != null && baseAttackBonus != null;
  int get finalSaveDc => (baseSaveDc ?? 0) + saveDcBonus;
  int get finalAttackBonus => (baseAttackBonus ?? 0) + attackBonus;
}
