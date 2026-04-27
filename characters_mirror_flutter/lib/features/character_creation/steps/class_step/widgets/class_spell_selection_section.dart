import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:flutter/material.dart';
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
    if (visibleGroups.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Заклинания', showDivider: false),
        const Gap(8),
        for (var index = 0; index < visibleGroups.length; index++) ...[
          _SpellSelectionGroupCard(
            group: visibleGroups[index],
            selections: selections,
            onToggleSpell: onToggleSpell,
            onClearGroup: onClearGroup,
          ),
          if (index < visibleGroups.length - 1) const Gap(10),
        ],
      ],
    );
  }
}

class _SpellSelectionGroupCard extends StatelessWidget {
  const _SpellSelectionGroupCard({
    required this.group,
    required this.selections,
    required this.onToggleSpell,
    required this.onClearGroup,
  });

  final ClassSpellSelectionGroupView group;
  final List<CharacterSpellSelectionData> selections;
  final void Function(ClassSpellSelectionGroupView group, SpellData spell)
      onToggleSpell;
  final void Function(ClassSpellSelectionGroupView group) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final selectedKeys = {
      for (final selection in selections)
        if (selection.classDataId == group.classDataId &&
            selection.kind == group.kind &&
            _selectionSpellKey(selection) != null)
          _selectionSpellKey(selection)!,
    };
    final limit = group.selectionCount ?? 1;
    final items = [
      for (final spell in group.options ?? const <SpellData>[])
        if (_spellKey(spell) != null)
          CreationChoiceSelectorItem(
            id: _spellKey(spell)!,
            title: spell.name ?? _spellKey(spell)!,
            subtitle: spell.schoolValue?.name,
            isSelected: selectedKeys.contains(_spellKey(spell)),
            onTap: () => onToggleSpell(group, spell),
          ),
    ];

    return CreationChoiceSelector.multi(
      title: _groupTitle(group.kind),
      description: 'Выберите $limit',
      switchKey: '${group.classDataId}_${group.kind?.name}',
      selectionLimit: limit,
      onClear: selectedKeys.isEmpty ? null : () => onClearGroup(group),
      autoScrollOnExpand: false,
      items: items,
    );
  }
}

String _groupTitle(CharacterSpellSelectionKind? kind) {
  switch (kind) {
    case CharacterSpellSelectionKind.knownCantrip:
      return 'Заговоры';
    case CharacterSpellSelectionKind.knownSpell:
      return 'Известные заклинания';
    case null:
      return 'Заклинания';
  }
}

String? _selectionSpellKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spellKey) ?? _spellKey(selection.spell);
}

String? _spellKey(SpellData? spell) {
  return _normalizedText(spell?.referenceKey) ?? _normalizedText(spell?.name);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
