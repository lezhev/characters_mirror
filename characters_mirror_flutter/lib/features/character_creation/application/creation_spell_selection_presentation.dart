import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/spell_selection_support.dart';

/// Maps creation catalogs to picker keys without owning or changing draft state.
class CreationSpellSelectionPresentation {
  CreationSpellSelectionPresentation(ClassSpellSelectionGroupView group,
      List<CharacterSpellSelectionData> selections)
      : title = _groupTitle(group.kind),
        maximum = group.selectionCount ?? 1,
        options = List.unmodifiable([
          for (final spell in draftSpellOptions(group, selections))
            if (pickerKey(spell) != null) spell,
        ]) {
    selectedKeys = List.unmodifiable([
      for (final spell in options)
        if (selections.any((s) =>
            s.classDataId == group.classDataId &&
            s.kind == group.kind &&
            ((spell.id != null && (s.spellId ?? s.spell?.id) == spell.id) ||
                (spell.referenceKey.isNotEmpty &&
                    (s.spellKey ?? s.spell?.referenceKey) ==
                        spell.referenceKey))))
          pickerKey(spell)!,
    ]);
  }

  final String title;
  final int maximum;
  // Creation has always allowed skipping or partial choices.
  int get minimum => 0;
  final List<SpellData> options;
  late final List<String> selectedKeys;
  String get selectedNames => [
        for (final spell in options)
          if (selectedKeys.contains(pickerKey(spell)))
            spell.name ?? pickerKey(spell)!
      ].join(', ');

  List<SpellData> removedSpells(List<String> keys) => [
        for (final spell in options)
          if (selectedKeys.contains(pickerKey(spell)) &&
              !keys.contains(pickerKey(spell)))
            spell,
      ];

  List<SpellData> addedSpells(List<String> keys) => [
        for (final key in keys)
          if (!selectedKeys.contains(key))
            for (final spell in options)
              if (pickerKey(spell) == key) spell,
      ];
}

String? pickerKey(SpellData spell) {
  final referenceKey = spell.referenceKey.trim();
  if (referenceKey.isNotEmpty) return referenceKey;
  return spell.id == null ? null : '${spell.id}';
}

String _groupTitle(CharacterSpellSelectionKind? kind) => switch (kind) {
      CharacterSpellSelectionKind.knownCantrip => 'Заговоры',
      CharacterSpellSelectionKind.knownSpell => 'Известные заклинания',
      CharacterSpellSelectionKind.spellbookSpell => 'Книга заклинаний',
      CharacterSpellSelectionKind.preparedSpell => 'Подготовленные заклинания',
      null => 'Заклинания',
    };
