part of '../spell_page.dart';

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
  List<ClassLevelData> _classLevels = const [];

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
                                  data.preparationClassIds[spellKey(spell)],
                                ),
                                onPrepareSpell: (spell) => _setSpellPrepared(
                                  spell,
                                  true,
                                  data.preparationClassIds[spellKey(spell)],
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
    _classLevels = classLevels;
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
          _character,
          spell,
          classDataId,
          classLevel: spellLevelForEntry(
              spellEntryForClass(_character, classDataId), _classLevels),
        ),
      );
      _dataFuture = _loadData();
    });
  }

  Future<void> _forgetSpell(SpellData spell) async {
    await widget.onSpellForgotten?.call(spell);
    final key = spellKey(spell);
    setState(() {
      final selections = forgetSpellSelections(
          _character, spell, _primarySpellClassId(_character));
      _character = _character.copyWith(
        spellSelections: selections,
        preparedSpellKeys: [
          for (final preparedKey in _effectivePreparedKeys(_character))
            if (preparedKey != key ||
                selections
                    .any((selection) => _spellSelectionKey(selection) == key))
              preparedKey,
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
    final selections = prepareSpellSelections(
        _character, spell, classDataId, prepared,
        classLevel: spellLevelForEntry(
            spellEntryForClass(_character, classDataId), _classLevels));
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
        spellSelections: selections,
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
                inputFormatters: [nonNegativeIntFormatter()],
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
                inputFormatters: [boundedIntFormatter()],
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
