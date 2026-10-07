import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_picker.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import '../application/level_up_overview.dart';

class LevelUpSpells extends StatelessWidget {
  const LevelUpSpells(
      {super.key,
      required this.preview,
      required this.request,
      required this.onChanged});
  final LevelUpPreview preview;
  final LevelUpRequest request;
  final void Function(CharacterSpellSelectionKind, List<int>, String?)
      onChanged;
  List<SpellData> _options(CharacterSpellSelectionKind kind) =>
      preview.classStep.spellSelectionGroups
          ?.where((g) => g.kind == kind)
          .firstOrNull
          ?.options ??
      [];

  Future<List<String>?> _pick(BuildContext context,
      CharacterSpellSelectionKind kind, int count, List<String> selected,
      {String? replacesSelectionId}) {
    final owned = {
      for (final s in preview.before.spellSelections ??
          const <CharacterSpellSelectionData>[])
        if (s.classEntry?.id == request.classEntryId &&
            s.kind == kind &&
            s.id != replacesSelectionId)
          s.spellId
    };
    return Navigator.of(context).push<List<String>>(MaterialPageRoute(
        builder: (_) => ChoicePicker(
              title: kind == CharacterSpellSelectionKind.knownCantrip
                  ? 'Заговоры'
                  : 'Заклинания',
              maximum: count,
              minimum: replacesSelectionId == null ? count : 0,
              selected: selected,
              options: [
                for (final s in _options(kind))
                  if (!owned.contains(s.id) && s.id != null)
                    ChoicePickerOption(
                        key: '${s.id}',
                        name: s.name ??
                            (s.referenceKey.isEmpty
                                ? 'Заклинание'
                                : s.referenceKey),
                        description: s.description,
                        spellLevel: s.level,
                        spell: s)
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final delta = preview.spellDelta;
    final rows = <Widget>[
      for (final (kind, count) in [
        (CharacterSpellSelectionKind.knownCantrip, delta.cantripsToAdd),
        (CharacterSpellSelectionKind.knownSpell, delta.knownSpellsToAdd),
        (
          CharacterSpellSelectionKind.spellbookSpell,
          delta.spellbookSpellsToAdd
        ),
      ])
        if (count > 0)
          Builder(builder: (_) {
            final selected = [
              for (final s in request.spells ?? const <LevelUpSpellChoice>[])
                if (s.kind == kind && s.replacesSelectionId == null)
                  '${s.spellId}'
            ];
            return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(kind == CharacterSpellSelectionKind.knownCantrip
                    ? 'Выбрать заговоры'
                    : kind == CharacterSpellSelectionKind.spellbookSpell
                        ? 'Добавить в книгу заклинаний'
                        : 'Выбрать заклинания'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selected.isEmpty
                        ? 'Выбрать $count'
                        : 'Выбрано ${selected.length} / $count'),
                    if (selected.isNotEmpty)
                      Text([
                        for (final key in selected)
                          _spellName(kind, int.parse(key))
                      ].join(', ')),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final keys = await _pick(context, kind, count, selected);
                  if (keys != null) {
                    onChanged(kind, keys.map(int.parse).toList(), null);
                  }
                });
          }),
      if (delta.knownSpellReplacements > 0)
        ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Заменить заклинание'),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Необязательно · до ${delta.knownSpellReplacements}'),
              for (final s in request.spells ?? const <LevelUpSpellChoice>[])
                if (s.replacesSelectionId != null)
                  Text(
                      '${_replacedSpellName(s.replacesSelectionId!)} → ${_spellName(s.kind, s.spellId)}'),
            ]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final old = preview.before.spellSelections
                      ?.where((s) =>
                          s.classEntry?.id == request.classEntryId &&
                          s.kind == CharacterSpellSelectionKind.knownSpell &&
                          s.id != null)
                      .toList() ??
                  [];
              final replacement = await Navigator.of(context)
                  .push<List<String>>(MaterialPageRoute(
                      builder: (_) => ChoicePicker(
                            title: 'Что заменить',
                            maximum: 1,
                            minimum: 1,
                            options: [
                              for (final s in old)
                                ChoicePickerOption(
                                    key: s.id!,
                                    name: s.spell?.name ??
                                        s.spellKey ??
                                        'Заклинание',
                                    spell: s.spell ??
                                        _options(s.kind ??
                                                CharacterSpellSelectionKind
                                                    .knownSpell)
                                            .where((spell) =>
                                                spell.id == s.spellId)
                                            .firstOrNull ??
                                        SpellData(
                                            id: s.spellId,
                                            referenceKey: s.spellKey))
                            ],
                          )));
              if (replacement == null ||
                  replacement.isEmpty ||
                  !context.mounted) {
                return;
              }
              final id = replacement.single;
              final current = request.spells
                      ?.where((s) => s.replacesSelectionId == id)
                      .map((s) => '${s.spellId}')
                      .toList() ??
                  [];
              final picked = await _pick(
                  context, CharacterSpellSelectionKind.knownSpell, 1, current,
                  replacesSelectionId: id);
              if (picked != null) {
                onChanged(CharacterSpellSelectionKind.knownSpell,
                    picked.map(int.parse).toList(), id);
              }
            }),
      for (final level in newSpellLevels(preview))
        ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Доступны заклинания $level уровня')),
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SheetOutlineCard(
            key: const ValueKey('level-up-spells'),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Заклинания',
                      style: Theme.of(context).textTheme.titleMedium),
                  for (final row in rows) ...[const Divider(), row],
                ])));
  }

  String _spellName(CharacterSpellSelectionKind kind, int id) {
    final spell = _options(kind).where((s) => s.id == id).firstOrNull;
    return spell?.name ?? spell?.referenceKey ?? 'Заклинание';
  }

  String _replacedSpellName(String selectionId) {
    final selection = preview.before.spellSelections
        ?.where((s) => s.id == selectionId)
        .firstOrNull;
    return selection?.spell?.name ?? selection?.spellKey ?? 'Заклинание';
  }
}
