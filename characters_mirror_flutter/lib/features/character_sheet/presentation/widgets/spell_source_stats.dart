import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/character_spell_projection.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:flutter/material.dart';

class SpellSourceStats extends StatelessWidget {
  const SpellSourceStats({required this.character, super.key});
  final CharacterData character;
  @override
  Widget build(BuildContext context) {
    final sources = characterSpellcastingSources(character);
    if (sources.isEmpty) {
      return const SegmentedStatBar(segments: [
        SegmentedStatBarItem(label: 'Спасбросок', value: '—'),
        SegmentedStatBarItem(label: 'Атака', value: '—'),
      ]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (var i = 0; i < sources.length; i++) ...[
        if (i > 0) const SizedBox(height: 12),
        if (sources.length > 1) ...[
          Text(sources[i].label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 6),
        ],
        SegmentedStatBar(segments: [
          SegmentedStatBarItem(
              label: 'Спасбросок',
              value:
                  '${characterSpellPresentationContext(character, sources[i]).saveDc ?? '—'}'),
          SegmentedStatBarItem(
              label: 'Атака',
              value: _signed(
                  characterSpellPresentationContext(character, sources[i])
                      .attackBonus)),
        ]),
      ],
    ]);
  }
}

String _signed(int? value) => value == null
    ? '—'
    : value >= 0
        ? '+$value'
        : '$value';
