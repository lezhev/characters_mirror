import 'package:characters_mirror_client/characters_mirror_client.dart';
import '../application/creation_spell_selection_presentation.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/choice_picker.dart';
import 'package:flutter/material.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:gap/gap.dart';

class ClassSpellSelectionSection extends StatelessWidget {
  const ClassSpellSelectionSection({
    required this.groups,
    required this.selections,
    required this.onToggleSpell,
    required this.onClearGroup,
    super.key,
  });

  final List<ClassSpellSelectionGroupView> groups;
  final List<CharacterSpellSelectionData> selections;
  final void Function(ClassSpellSelectionGroupView group, SpellData spell)
      onToggleSpell;
  final void Function(ClassSpellSelectionGroupView group) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final visibleGroups = [
      for (final group in groups)
        if (group.kind != null && (group.options?.isNotEmpty ?? false)) group,
    ];
    if (visibleGroups.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const AppSectionHeader(title: 'Заклинания'),
      const Gap(8),
      for (final group in visibleGroups)
        _SpellSelectionGroupRow(
            group: group,
            selections: selections,
            onToggleSpell: onToggleSpell,
            onClearGroup: onClearGroup),
    ]);
  }
}

class _SpellSelectionGroupRow extends StatelessWidget {
  const _SpellSelectionGroupRow(
      {required this.group,
      required this.selections,
      required this.onToggleSpell,
      required this.onClearGroup});
  final ClassSpellSelectionGroupView group;
  final List<CharacterSpellSelectionData> selections;
  final void Function(ClassSpellSelectionGroupView, SpellData) onToggleSpell;
  final void Function(ClassSpellSelectionGroupView) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final p = CreationSpellSelectionPresentation(group, selections);
    return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(p.title),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Выберите ${p.maximum}'),
          Text('Выбрано ${p.selectedKeys.length} из ${p.maximum}'),
          if (p.selectedKeys.isNotEmpty) Text(p.selectedNames),
        ]),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          final keys = await Navigator.of(context).push<List<String>>(
              MaterialPageRoute(
                  builder: (_) => ChoicePicker(
                          title: p.title,
                          minimum: p.minimum,
                          maximum: p.maximum,
                          selected: p.selectedKeys,
                          selectionAllowed: (keys) =>
                              spellSelectionsMatchFilter(
                                  p.options
                                      .where((s) => keys.contains(pickerKey(s)))
                                      .map((s) => s.toJson()),
                                  group.selectionFilter?.toJson(),
                                  kind: group.kind!.name,
                                  level: group.classLevel ?? 1),
                          options: [
                            for (final spell in p.options)
                              ChoicePickerOption(
                                  key: pickerKey(spell)!,
                                  name: spell.name ?? pickerKey(spell)!,
                                  spellLevel: spell.level,
                                  spell: spell)
                          ])));
          if (keys == null || !context.mounted) return;
          if (keys.isEmpty) {
            if (p.selectedKeys.isNotEmpty) onClearGroup(group);
            return;
          }
          // Free slots first, preserving retained spells and dependent groups.
          for (final spell in p.removedSpells(keys)) {
            onToggleSpell(group, spell);
          }
          for (final spell in p.addedSpells(keys)) {
            onToggleSpell(group, spell);
          }
        });
  }
}
