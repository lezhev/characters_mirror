import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpellPage extends ConsumerWidget {
  const SpellPage({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(humanReadableError(error)),
      ),
      data: (character) => Padding(
        padding: const EdgeInsets.all(12),
        child: PageSizeLimiter(
          child: SpellPageContent(character: character),
        ),
      ),
    );
  }
}

class SpellPageContent extends StatelessWidget {
  const SpellPageContent({
    required this.character,
    super.key,
  });

  final CharacterData character;

  @override
  Widget build(BuildContext context) {
    final derived = character.derived;
    final alwaysPreparedKeys = _normalizedKeyList(
      derived?.alwaysPreparedSpellKeys,
    );
    final selections =
        character.spellSelections ?? const <CharacterSpellSelectionData>[];
    final knownCantrips = _selectedSpellLabels(
      selections,
      CharacterSpellSelectionKind.knownCantrip,
    );
    final knownSpells = _selectedSpellLabels(
      selections,
      CharacterSpellSelectionKind.knownSpell,
    );
    final selectedKeys = {
      for (final selection in selections)
        if (_selectionSpellKey(selection) != null)
          _selectionSpellKey(selection)!,
    };
    final otherGranted = [
      for (final key in _normalizedKeyList(derived?.grantedSpellKeys))
        if (!alwaysPreparedKeys.contains(key) && !selectedKeys.contains(key))
          key,
    ];

    return ListView(
      children: [
        const AppSectionHeader(title: 'Заклинания', showDivider: false),
        const SizedBox(height: 12),
        _SpellSlotsSummary(
          spellSlots: derived?.spellSlots,
          pactSlots: derived?.pactSlots,
        ),
        if (alwaysPreparedKeys.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SpellSection(
            title: 'Всегда наготове',
            spells: alwaysPreparedKeys,
            icon: Icons.lock_open,
          ),
        ],
        if (knownCantrips.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SpellSection(
            title: 'Заговоры',
            spells: knownCantrips,
            icon: Icons.auto_awesome,
          ),
        ],
        if (knownSpells.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SpellSection(
            title: 'Известные заклинания',
            spells: knownSpells,
            icon: Icons.menu_book,
          ),
        ],
        if (otherGranted.isNotEmpty) ...[
          const SizedBox(height: 12),
          _SpellSection(
            title: 'Прочие источники',
            spells: otherGranted,
            icon: Icons.stars,
          ),
        ],
        if (alwaysPreparedKeys.isEmpty &&
            knownCantrips.isEmpty &&
            knownSpells.isEmpty &&
            otherGranted.isEmpty) ...[
          const SizedBox(height: 12),
          const AppSurfaceCard(
            padding: EdgeInsets.all(16),
            child: Text('Заклинаний пока нет'),
          ),
        ],
      ],
    );
  }
}

class _SpellSlotsSummary extends StatelessWidget {
  const _SpellSlotsSummary({
    required this.spellSlots,
    required this.pactSlots,
  });

  final Map<int, int>? spellSlots;
  final Map<int, int>? pactSlots;

  @override
  Widget build(BuildContext context) {
    final slotLabels = _slotLabels(spellSlots);
    final pactLabels = _slotLabels(pactSlots);
    if (slotLabels.isEmpty && pactLabels.isEmpty) {
      return const AppSurfaceCard(
        padding: EdgeInsets.all(16),
        child: Text('Ячеек заклинаний нет'),
      );
    }

    return AppSurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final label in slotLabels) _SlotChip(label: label),
          for (final label in pactLabels) _SlotChip(label: 'Договор: $label'),
        ],
      ),
    );
  }
}

class _SpellSection extends StatelessWidget {
  const _SpellSection({
    required this.title,
    required this.spells,
    required this.icon,
  });

  final String title;
  final List<String> spells;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppSurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title, style: textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final spell in spells) _SpellChip(label: spell),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpellChip extends StatelessWidget {
  const _SpellChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.circle, size: 10),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

List<String> _slotLabels(Map<int, int>? slots) {
  final entries = [
    for (final entry in slots?.entries ?? const Iterable.empty())
      if (entry.value > 0) entry,
  ]..sort((left, right) => left.key.compareTo(right.key));

  return [
    for (final entry in entries) '${entry.key} ур. x${entry.value}',
  ];
}

List<String> _selectedSpellLabels(
  List<CharacterSpellSelectionData> selections,
  CharacterSpellSelectionKind kind,
) {
  final labels = <String>[];
  final sorted = [...selections]..sort(
      (left, right) =>
          (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
    );
  for (final selection in sorted) {
    if (selection.kind != kind) {
      continue;
    }
    final label =
        _normalizedText(selection.spell?.name) ?? _selectionSpellKey(selection);
    if (label != null && !labels.contains(label)) {
      labels.add(label);
    }
  }
  return labels;
}

List<String> _normalizedKeyList(List<String>? values) {
  final result = <String>{};
  for (final value in values ?? const <String>[]) {
    final normalized = _normalizedText(value);
    if (normalized != null) {
      result.add(normalized);
    }
  }
  return result.toList()..sort();
}

String? _selectionSpellKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spellKey) ??
      _normalizedText(selection.spell?.referenceKey) ??
      _normalizedText(selection.spell?.name);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}
