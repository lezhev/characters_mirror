part of '../spell_page.dart';

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
