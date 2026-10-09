import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/core/character_spells/character_spell_projection.dart';
import 'package:flutter/material.dart';
import 'spell_presentation_view.dart';

Future<SpellCastContext?> chooseSpellCast(BuildContext context,
    {required CharacterData character,
    required SpellData spell,
    required List<SpellCastContext> choices}) {
  // Sources with identical casting semantics need no extra visual choice.
  final seen = <String>{};
  final distinct = choices
      .where((c) => seen.add(
          '${c.castingAbility}:${c.slotSource.name}:${c.castLevel}:${c.payment}:${c.payment == 'resource' || c.payment == 'free' ? c.source.sourceKey : ''}'))
      .toList();
  if (distinct.length == 1) return Future.value(distinct.single);
  if (distinct.isEmpty) return Future.value(null);
  return showDialog<SpellCastContext>(
      context: context,
      builder: (_) => _SpellCastDialog(
          character: character, spell: spell, choices: distinct));
}

class _SpellCastDialog extends StatefulWidget {
  const _SpellCastDialog(
      {required this.character, required this.spell, required this.choices});
  final CharacterData character;
  final SpellData spell;
  final List<SpellCastContext> choices;
  @override
  State<_SpellCastDialog> createState() => _SpellCastDialogState();
}

class _SpellCastDialogState extends State<_SpellCastDialog> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final cast = widget.choices[selected];
    final p = const SpellPresentationResolver().resolve(widget.spell.toJson(),
        context: characterSpellPresentationContext(
            widget.character, cast.source,
            castLevel: cast.castLevel));
    return AlertDialog(
        title: Text(p.name),
        content: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              RadioGroup<int>(
                  groupValue: selected,
                  onChanged: (value) => setState(() => selected = value!),
                  child: Column(children: [
                    for (var i = 0; i < widget.choices.length; i++)
                      RadioListTile<int>(
                          key: ValueKey('spell-cast-choice-$i'),
                          value: i,
                          contentPadding: EdgeInsets.zero,
                          title: Text(_choiceLabel(widget.choices[i]))),
                  ])),
              const Divider(),
              SpellPresentationView(presentation: p),
            ])),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена')),
          FilledButton(
              onPressed: () => Navigator.pop(context, cast),
              child: const Text('Наложить')),
        ]);
  }
}

String _choiceLabel(SpellCastContext cast) =>
    '${cast.source.label}${cast.castingAbility == null ? '' : ' · ${_abilities[cast.castingAbility] ?? cast.castingAbility}'} · '
    '${switch (cast.slotSource) {
      SpellSlotSource.none => switch (cast.payment) {
          'resource' =>
            '${cast.source.activation?['resourceKey']} · ${cast.resourceCost ?? cast.source.activation?['resourceCost']} · ур. ${cast.castLevel}',
          'free' =>
            'Без ячейки · ${cast.source.activation?['freeCasts'] ?? cast.source.freeCastsFormula} / ${cast.source.activation?['resetOn'] ?? cast.source.freeCastsPerRest}',
          'atWill' => 'Без ячейки',
          _ => 'Заговор',
        },
      SpellSlotSource.standard => 'Ячейка ${cast.castLevel} уровня',
      SpellSlotSource.pact => 'Магия договора · ${cast.castLevel} уровень',
    }}';
const _abilities = {
  'strength': 'STR',
  'dexterity': 'DEX',
  'constitution': 'CON',
  'intelligence': 'INT',
  'wisdom': 'WIS',
  'charisma': 'CHA'
};
