part of '../spell_page.dart';

class _SpellLevelSection extends StatelessWidget {
  const _SpellLevelSection({
    required this.title,
    required this.entries,
    required this.character,
    this.onSpellCastContext,
    required this.spellStats,
    required this.castButtonWidth,
    this.slots,
    this.currentSlots,
    this.level = 0,
    this.pactSlots,
    this.currentPactSlots,
    this.onPactSlotCountChanged,
    this.onSlotCountChanged,
    this.onSpellCast,
    this.diceRoller,
  });

  final String title;
  final List<_SpellEntry> entries;
  final CharacterData character;
  final Future<void> Function(SpellData spell, SpellCastContext cast)?
      onSpellCastContext;
  final _SpellStats spellStats;
  final double castButtonWidth;
  final int? slots;
  final int? currentSlots;
  final int level;
  final int? pactSlots;
  final int? currentPactSlots;
  final ValueChanged<int>? onPactSlotCountChanged;
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
          level: level,
          slots: slots,
          currentSlots: currentSlots,
          pactSlots: pactSlots,
          currentPactSlots: currentPactSlots,
          onPactSlotCountChanged: onPactSlotCountChanged,
          onSlotCountChanged: onSlotCountChanged,
        ),
        const SizedBox(height: 8),
        for (var index = 0; index < entries.length; index++) ...[
          _SpellCard(
            entry: entries[index],
            character: character,
            onSpellCastContext: onSpellCastContext,
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
    required this.level,
    this.slots,
    this.currentSlots,
    this.pactSlots,
    this.currentPactSlots,
    this.onPactSlotCountChanged,
    this.onSlotCountChanged,
  });

  final String title;
  final int level;
  final int? slots;
  final int? currentSlots;
  final int? pactSlots;
  final int? currentPactSlots;
  final ValueChanged<int>? onPactSlotCountChanged;
  final ValueChanged<int>? onSlotCountChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final slotCount = slots ?? 0;
    final availableSlots =
        (currentSlots ?? slotCount).clamp(0, slotCount).toInt();
    final pactCount = pactSlots ?? 0;
    final availablePact =
        (currentPactSlots ?? pactCount).clamp(0, pactCount).toInt();

    final totalSlots = slotCount + pactCount;
    if (totalSlots == 0) {
      return Text(title, style: theme.textTheme.titleMedium);
    }
    return LayoutBuilder(builder: (context, constraints) {
      final titlePainter = TextPainter(
        text: TextSpan(text: title, style: theme.textTheme.titleMedium),
        textScaler: MediaQuery.textScalerOf(context),
        textDirection: Directionality.of(context),
      )..layout();
      final slotWidth =
          math.max(0.0, constraints.maxWidth - titlePainter.width - 24);
      titlePainter.dispose();
      final spacing = totalSlots > 1
          ? ((slotWidth - totalSlots * 22) / (totalSlots - 1)).clamp(0.0, 6.0)
          : 0.0;
      return Row(
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          const SizedBox(width: 12),
          Expanded(
              child:
                  Divider(height: 1, thickness: 1, color: colorScheme.outline)),
          const SizedBox(width: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: slotWidth),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                key: ValueKey('spell-slot-row-$title'),
                mainAxisSize: MainAxisSize.min,
                spacing: spacing,
                children: [
                  for (var index = 0; index < slotCount; index++)
                    SpellSlotIndicator(
                      key: ValueKey('spell-slot-$title-$index'),
                      level: level,
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
                  for (var index = 0; index < pactCount; index++)
                    SpellSlotIndicator(
                      key: ValueKey('pact-slot-$title-$index'),
                      level: level,
                      variant: SpellSlotVariant.pact,
                      value: index < availablePact,
                      onPressed: onPactSlotCountChanged == null
                          ? null
                          : () => onPactSlotCountChanged!(index < availablePact
                              ? availablePact - 1
                              : availablePact + 1),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _SpellCard extends StatelessWidget {
  const _SpellCard({
    required this.entry,
    required this.character,
    this.onSpellCastContext,
    required this.spellStats,
    required this.castButtonWidth,
    required this.availableSlots,
    this.onSpellCast,
    this.diceRoller,
  });

  final _SpellEntry entry;
  final CharacterData character;
  final Future<void> Function(SpellData spell, SpellCastContext cast)?
      onSpellCastContext;
  List<SpellCastContext> get castChoices => availableSpellCasts(
      spellKey(entry.spell) ?? '',
      entry.spell.level ?? 0,
      entry.sources,
      SpellSlotPools.fromCharacter(character.toJson()),
      character: character.toJson());
  SpellSourceContext? get defaultSource =>
      castChoices.firstOrNull?.source ??
      entry.sources.where((s) => s.prepared || s.alwaysPrepared).firstOrNull;
  final _SpellStats spellStats;
  final double castButtonWidth;
  final int? availableSlots;
  final Future<void> Function(SpellData spell)? onSpellCast;
  final DiceRoller? diceRoller;

  @override
  Widget build(BuildContext context) {
    final spell = entry.spell;
    final spellStats = _spellStats(character, source: defaultSource);
    final disabledBySlots =
        (spell.level ?? 0) > 0 && (availableSlots ?? 0) <= 0;
    final disabledByPreparation =
        entry.canPrepare && !entry.isPrepared && (spell.level ?? 0) > 0;
    final canCast = onSpellCastContext != null
        ? castChoices.isNotEmpty
        : onSpellCast != null &&
            !disabledBySlots &&
            !disabledByPreparation &&
            (!spellHasAttack(spell) || spellStats.canRollSpellAttack);

    return SpellCard(
      spell: spell,
      presentationContext: defaultSource == null
          ? const SpellPresentationContext()
          : characterSpellPresentationContext(character, defaultSource!,
              castLevel: castChoices.firstOrNull?.castLevel),
      trailing: KeyedSubtree(
        key: ValueKey('cast-spell-${spellKey(spell) ?? spellName(spell)}'),
        child: _SpellCastButton(
          spell: spell,
          spellStats: spellStats,
          width: _spellCastButtonWidth(context, spellStats.attackBonusLabel),
          enabled: canCast,
          onPressed: () => _castSpell(context),
        ),
      ),
    );
  }

  Future<void> _castSpell(BuildContext context) async {
    final spell = entry.spell;
    var stats = _spellStats(character, source: defaultSource);
    try {
      if (onSpellCastContext != null) {
        final cast = await chooseSpellCast(context,
            character: character, spell: spell, choices: castChoices);
        if (cast == null || !context.mounted) return;
        stats = _spellStats(character, source: cast.source);
        await onSpellCastContext!(spell, cast);
      } else {
        await onSpellCast?.call(spell);
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(humanReadableError(error))));
      }
      return;
    }
    if (!context.mounted) {
      return;
    }

    if (spellHasSave(spell)) {
      RollResultsOverlay.show(
        context,
        _spellSavingThrowMessage(spell, stats),
      );
      return;
    }

    if (spellHasAttack(spell) && stats.canRollSpellAttack) {
      final roller = diceRoller ?? DiceRoller();
      try {
        final result = roller.rollModifier(stats.attackBonusLabel);
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
    if (spellHasAttack(spell) && spellStats.canRollSpellAttack) {
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
