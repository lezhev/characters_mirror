import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/spell_details_dialog.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SpellsStep extends ConsumerWidget {
  const SpellsStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(classStateProvider);

    return state.when(
      data: (data) {
        final groups = _visibleGroups(data.stepView?.spellSelectionGroups);
        if (groups.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) {
              return;
            }
            ref
                .read(characterCreationProvider.notifier)
                .goToStep(context, Step.personal);
          });
        }

        return CreationStepScaffold(
          route: 'personal',
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
          onStepTap: (target) async => _syncAndGo(
            context: context,
            ref: ref,
            target: target,
          ),
          onPressedNext: () => _syncAndGo(
            context: context,
            ref: ref,
            target: Step.personal,
          ),
          body: ClassSpellSelectionSection(
            groups: groups,
            selections: data.selectedSpellSelections,
            onToggleSpell:
                ref.read(classStateProvider.notifier).toggleSpellSelection,
            onClearGroup:
                ref.read(classStateProvider.notifier).clearSpellSelectionGroup,
          ),
        );
      },
      error: (e, s) {
        return CreationStepScaffold(
          route: 'personal',
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
          onStepTap: (target) async {
            ref.read(characterCreationProvider.notifier).goToStep(
                  context,
                  target,
                );
          },
          onPressedNext: () {
            ref
                .read(characterCreationProvider.notifier)
                .goToStep(context, Step.personal);
          },
          body: errorWidget(
            e: e,
            s: s,
            refresh: () => ref.refresh(classStateProvider),
            context: context,
          ),
        );
      },
      loading: () => CreationStepScaffold(
        route: 'personal',
        onBack: () {
          ref.read(characterCreationProvider.notifier).reset();
          context.go('/characters');
        },
        onStepTap: (target) async {
          ref.read(characterCreationProvider.notifier).goToStep(
                context,
                target,
              );
        },
        onPressedNext: () {
          ref
              .read(characterCreationProvider.notifier)
              .goToStep(context, Step.personal);
        },
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _syncAndGo({
    required BuildContext context,
    required WidgetRef ref,
    required Step target,
  }) {
    ref.read(classStateProvider.notifier).syncSpellSelectionsToCreationDraft();
    ref.read(characterCreationProvider.notifier).goToStep(context, target);
  }
}

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
    if (groups.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppSectionHeader(title: 'Заклинания'),
        const Gap(8),
        for (var index = 0; index < groups.length; index++) ...[
          _SpellSelectionGroupCard(
            group: groups[index],
            selections: selections,
            onToggleSpell: onToggleSpell,
            onClearGroup: onClearGroup,
          ),
          if (index < groups.length - 1) const Gap(12),
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
    final theme = Theme.of(context);
    final selectedKeys = _selectedKeys(group, selections);
    final limit = group.selectionCount ?? 1;
    final options = [
      for (final spell in group.options ?? const <SpellData>[])
        if (_spellKey(spell) != null) spell,
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _groupTitle(group.kind),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  'Выбрано ${selectedKeys.length} из $limit',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                if (selectedKeys.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => onClearGroup(group),
                    child: const Text('Очистить'),
                  ),
                ],
              ],
            ),
            const Gap(8),
            for (final spell in options) ...[
              _SpellSelectionTile(
                spell: spell,
                selected: selectedKeys.contains(_spellKey(spell)),
                onTap: () => onToggleSpell(group, spell),
              ),
              if (spell != options.last) const Divider(height: 1),
            ],
          ],
        ),
      ),
    );
  }
}

class _SpellSelectionTile extends StatelessWidget {
  const _SpellSelectionTile({
    required this.spell,
    required this.selected,
    required this.onTap,
  });

  final SpellData spell;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        selected ? Icons.check_circle : Icons.circle_outlined,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(spellName(spell)),
      onTap: onTap,
      trailing: IconButton(
        tooltip: 'Информация',
        icon: const Icon(Icons.info_outline),
        onPressed: () => showSpellDetailsDialog(context, spell),
      ),
    );
  }
}

List<ClassSpellSelectionGroupView> _visibleGroups(
  List<ClassSpellSelectionGroupView>? groups,
) {
  return [
    for (final group in groups ?? const <ClassSpellSelectionGroupView>[])
      if (group.kind != null && (group.options?.isNotEmpty ?? false)) group,
  ];
}

Set<String> _selectedKeys(
  ClassSpellSelectionGroupView group,
  List<CharacterSpellSelectionData> selections,
) {
  return {
    for (final selection in selections)
      if (selection.classDataId == group.classDataId &&
          selection.kind == group.kind &&
          _selectionSpellKey(selection) != null)
        _selectionSpellKey(selection)!,
  };
}

String _groupTitle(CharacterSpellSelectionKind? kind) {
  switch (kind) {
    case CharacterSpellSelectionKind.knownCantrip:
      return 'Заговоры';
    case CharacterSpellSelectionKind.knownSpell:
      return 'Известные заклинания';
    case CharacterSpellSelectionKind.preparedSpell:
      return 'Подготовленные заклинания';
    case null:
      return 'Заклинания';
  }
}

String? _selectionSpellKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spellKey) ?? spellKey(selection.spell);
}

String? _spellKey(SpellData spell) {
  return spellKey(spell);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
