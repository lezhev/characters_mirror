import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SkillSelectionSection extends StatelessWidget {
  const SkillSelectionSection({
    required this.groups,
    required this.selections,
    required this.onToggleSkill,
    required this.onClearGroup,
    super.key,
  });

  final List<SkillSelectionGroupView> groups;
  final List<CharacterSkillSelectionData> selections;
  final void Function(SkillSelectionGroupView group, Skill skill) onToggleSkill;
  final void Function(SkillSelectionGroupView group) onClearGroup;

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
        const AppSectionHeader(title: 'Навыки', showDivider: false),
        const Gap(8),
        for (var index = 0; index < visibleGroups.length; index++) ...[
          _SkillSelectionGroupCard(
            group: visibleGroups[index],
            selections: selections,
            onToggleSkill: onToggleSkill,
            onClearGroup: onClearGroup,
          ),
          if (index < visibleGroups.length - 1) const Gap(10),
        ],
      ],
    );
  }
}

class _SkillSelectionGroupCard extends StatelessWidget {
  const _SkillSelectionGroupCard({
    required this.group,
    required this.selections,
    required this.onToggleSkill,
    required this.onClearGroup,
  });

  final SkillSelectionGroupView group;
  final List<CharacterSkillSelectionData> selections;
  final void Function(SkillSelectionGroupView group, Skill skill) onToggleSkill;
  final void Function(SkillSelectionGroupView group) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final selectedSkills = {
      for (final selection in selections)
        if (_matchesGroup(selection, group) && selection.skill != null)
          selection.skill!,
    };
    final limit = group.selectionCount ?? 1;
    final options = [...?group.options]..sort(
        (left, right) => skillLabel(left).compareTo(skillLabel(right)),
      );
    final items = [
      for (final skill in options)
        CreationChoiceSelectorItem(
          id: skill.name,
          title: skillLabel(skill),
          isSelected: selectedSkills.contains(skill),
          onTap: () => onToggleSkill(group, skill),
        ),
    ];

    return CreationChoiceSelector.multi(
      title: _groupTitle(group.kind),
      description: 'Выберите $limit',
      switchKey:
          '${group.classDataId ?? group.backgroundDataId}_${group.kind?.name}',
      selectionLimit: limit,
      onClear: selectedSkills.isEmpty ? null : () => onClearGroup(group),
      autoScrollOnExpand: false,
      items: items,
    );
  }
}

bool _matchesGroup(
  CharacterSkillSelectionData selection,
  SkillSelectionGroupView group,
) {
  return selection.kind == group.kind &&
      (group.classDataId == null ||
          selection.classDataId == group.classDataId) &&
      (group.backgroundDataId == null ||
          selection.backgroundDataId == group.backgroundDataId);
}

String _groupTitle(CharacterSkillSelectionKind? kind) {
  switch (kind) {
    case CharacterSkillSelectionKind.classSkill:
      return 'Навыки класса';
    case CharacterSkillSelectionKind.backgroundSkill:
      return 'Навыки предыстории';
    case null:
      return 'Навыки';
  }
}
