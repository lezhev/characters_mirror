import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_free_solo_autocomplete.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_editor_operations.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_labels.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterProficienciesPage extends ConsumerWidget {
  const CharacterProficienciesPage({required this.characterId, super.key});

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterState =
        ref.watch(characterSheetControllerProvider(characterId));
    final tools =
        ref.watch(toolCatalogProvider).valueOrNull ?? const <ToolData>[];
    final weapons =
        ref.watch(weaponCatalogProvider).valueOrNull ?? const <WeaponData>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Владения персонажа')),
      body: SafeArea(
        child: characterState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => const Center(
            child: Text('Не удалось загрузить персонажа.'),
          ),
          data: (character) => Padding(
            padding: const EdgeInsets.all(12),
            child: PageSizeLimiter(
              child: ListView(
                children: [
                  CharacterProficienciesEditor(
                    character: character,
                    tools: tools,
                    weapons: weapons,
                    onChanged: (next) => runCharacterSheetSave(
                      context,
                      ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveProficiencyOverrides(next),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterProficienciesEditor extends StatelessWidget {
  const CharacterProficienciesEditor({
    required this.character,
    required this.tools,
    required this.weapons,
    required this.onChanged,
    super.key,
  });

  final CharacterData character;
  final List<ToolData> tools;
  final List<WeaponData> weapons;
  final ValueChanged<CharacterData> onChanged;

  @override
  Widget build(BuildContext context) {
    final derived = character.derived;
    final toolNames = {for (final tool in tools) tool.referenceKey: tool.name};
    final weaponNames = {
      for (final weapon in weapons)
        if (weapon.referenceKey != null && weapon.name != null)
          weapon.referenceKey!: weapon.name!,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Section(
          title: 'Языки',
          values: [
            ...?derived?.languages?.map(
              (value) => _ChipValue(
                id: value.name,
                label: languageProficiencyLabel(value),
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeLanguage(
                    character,
                    value,
                  ),
                ),
              ),
            ),
            ...?derived?.customLanguages?.map(
              (value) => _ChipValue(
                id: 'custom:$value',
                label: value,
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeCustomLanguage(
                    character,
                    value,
                  ),
                ),
              ),
            ),
          ],
          isOverridden: character.manualLanguageOverrides != null,
          onReset: () => onChanged(
            CharacterProficiencyEditorOperations.resetLanguages(character),
          ),
          autocomplete: AppFreeSoloAutocomplete<Language>(
            labelText: 'Добавить язык',
            options: [
              for (final value in Language.values)
                AppFreeSoloOption(
                  value: value,
                  label: languageProficiencyLabel(value),
                ),
            ],
            isSelected: (value) => derived?.languages?.contains(value) ?? false,
            existingCustomValues: derived?.customLanguages ?? const [],
            onAddCanonical: (value) => onChanged(
              CharacterProficiencyEditorOperations.addLanguage(
                character,
                value,
              ),
            ),
            onAddCustom: (value) => onChanged(
              CharacterProficiencyEditorOperations.addCustomLanguage(
                character,
                value,
              ),
            ),
          ),
        ),
        _Section(
          title: 'Инструменты',
          values: [
            ...?derived?.toolProficiencyKeys?.map(
              (key) => _ChipValue(
                id: key,
                label: toolNames[key] ?? 'Неизвестный инструмент',
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeToolKey(
                    character,
                    key,
                  ),
                ),
              ),
            ),
            ...?derived?.customToolProficiencies?.map(
              (value) => _ChipValue(
                id: 'custom:$value',
                label: value,
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeCustomTool(
                    character,
                    value,
                  ),
                ),
              ),
            ),
          ],
          isOverridden: character.manualToolProficiencyOverrides != null,
          onReset: () => onChanged(
            CharacterProficiencyEditorOperations.resetTools(character),
          ),
          autocomplete: AppFreeSoloAutocomplete<String>(
            labelText: 'Добавить инструмент',
            options: [
              for (final tool in tools)
                AppFreeSoloOption(value: tool.referenceKey, label: tool.name),
            ],
            isSelected: (key) =>
                derived?.toolProficiencyKeys?.contains(key) ?? false,
            existingCustomValues: derived?.customToolProficiencies ?? const [],
            onAddCanonical: (key) => onChanged(
              CharacterProficiencyEditorOperations.addToolKey(character, key),
            ),
            onAddCustom: (value) => onChanged(
              CharacterProficiencyEditorOperations.addCustomTool(
                character,
                value,
              ),
            ),
          ),
        ),
        _Section(
          title: 'Оружие',
          values: [
            ...?derived?.weaponTraining?.map(
              (value) => _ChipValue(
                id: 'category:${value.name}',
                label: weaponCategoryProficiencyLabel(value),
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeWeaponCategory(
                    character,
                    value,
                  ),
                ),
              ),
            ),
            ...?derived?.weaponProficiencyKeys?.map(
              (key) => _ChipValue(
                id: key,
                label: weaponNames[key] ?? 'Неизвестное оружие',
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeWeaponKey(
                    character,
                    key,
                  ),
                ),
              ),
            ),
            ...?derived?.customWeaponProficiencies?.map(
              (value) => _ChipValue(
                id: 'custom:$value',
                label: value,
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeCustomWeapon(
                    character,
                    value,
                  ),
                ),
              ),
            ),
          ],
          isOverridden: character.manualWeaponProficiencyOverrides != null,
          onReset: () => onChanged(
            CharacterProficiencyEditorOperations.resetWeapons(character),
          ),
          children: [
            _enumAutocomplete<WeaponCategory>(
              label: 'Добавить категорию оружия',
              values: WeaponCategory.values,
              labelFor: weaponCategoryProficiencyLabel,
              selected: derived?.weaponTraining?.toSet() ?? const {},
              onAdd: (value) => onChanged(
                CharacterProficiencyEditorOperations.addWeaponCategory(
                  character,
                  value,
                ),
              ),
              onAddCustom: (label) => onChanged(
                CharacterProficiencyEditorOperations.addCustomWeapon(
                  character,
                  label,
                ),
              ),
            ),
            AppFreeSoloAutocomplete<String>(
              labelText: 'Добавить конкретное оружие',
              options: [
                for (final weapon in weapons)
                  if (weapon.referenceKey != null && weapon.name != null)
                    AppFreeSoloOption(
                      value: weapon.referenceKey!,
                      label: weapon.name!,
                    ),
              ],
              isSelected: (key) =>
                  derived?.weaponProficiencyKeys?.contains(key) ?? false,
              existingCustomValues:
                  derived?.customWeaponProficiencies ?? const [],
              onAddCanonical: (key) => onChanged(
                CharacterProficiencyEditorOperations.addWeaponKey(
                  character,
                  key,
                ),
              ),
              onAddCustom: (value) => onChanged(
                CharacterProficiencyEditorOperations.addCustomWeapon(
                  character,
                  value,
                ),
              ),
            ),
          ],
        ),
        _Section(
          title: 'Доспехи',
          values: [
            ...?derived?.armorTraining?.map(
              (value) => _ChipValue(
                id: value.name,
                label: armorCategoryProficiencyLabel(value),
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeArmorCategory(
                    character,
                    value,
                  ),
                ),
              ),
            ),
            ...?derived?.customArmorTraining?.map(
              (value) => _ChipValue(
                id: 'custom:$value',
                label: value,
                onRemove: () => onChanged(
                  CharacterProficiencyEditorOperations.removeCustomArmor(
                    character,
                    value,
                  ),
                ),
              ),
            ),
          ],
          isOverridden: character.manualArmorTrainingOverrides != null,
          onReset: () => onChanged(
            CharacterProficiencyEditorOperations.resetArmor(character),
          ),
          autocomplete: _enumAutocomplete<ArmorCategory>(
            label: 'Добавить категорию доспехов',
            values: ArmorCategory.values,
            labelFor: armorCategoryProficiencyLabel,
            selected: derived?.armorTraining?.toSet() ?? const {},
            onAdd: (value) => onChanged(
              CharacterProficiencyEditorOperations.addArmorCategory(
                character,
                value,
              ),
            ),
            onAddCustom: (label) => onChanged(
              CharacterProficiencyEditorOperations.addCustomArmor(
                character,
                label,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _enumAutocomplete<T>({
    required String label,
    required List<T> values,
    required String Function(T) labelFor,
    required Set<T> selected,
    required ValueChanged<T> onAdd,
    required ValueChanged<String> onAddCustom,
  }) =>
      AppFreeSoloAutocomplete<T>(
        labelText: label,
        options: [
          for (final value in values)
            AppFreeSoloOption(value: value, label: labelFor(value)),
        ],
        isSelected: selected.contains,
        onAddCanonical: onAdd,
        onAddCustom: onAddCustom,
      );
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.values,
    required this.isOverridden,
    required this.onReset,
    this.autocomplete,
    this.children = const [],
  });

  final String title;
  final List<_ChipValue> values;
  final bool isOverridden;
  final VoidCallback onReset;
  final Widget? autocomplete;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (isOverridden)
                    TextButton(
                        onPressed: onReset, child: const Text('Сбросить')),
                ],
              ),
              const SizedBox(height: 8),
              if (values.isEmpty)
                const Text('Не указано')
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final value in values)
                      InputChip(
                        key: ValueKey(value.id),
                        label: Text(value.label),
                        onDeleted: value.onRemove,
                      ),
                  ],
                ),
              if (children.isNotEmpty) ...[
                const SizedBox(height: 12),
                ...children,
              ],
              if (autocomplete != null) ...[
                const SizedBox(height: 12),
                autocomplete!,
              ],
            ],
          ),
        ),
      );
}

class _ChipValue {
  const _ChipValue(
      {required this.id, required this.label, required this.onRemove});

  final String id;
  final String label;
  final VoidCallback onRemove;
}
