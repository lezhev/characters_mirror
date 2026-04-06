import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_sheet_state.g.dart';

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository();
});

final selectedFightFeatureTagsProvider =
    StateProvider.autoDispose.family<Set<FeatureTag>, int>((ref, characterId) {
  return {
    FeatureTag.combat,
    FeatureTag.defense,
  };
});

@riverpod
Future<CharacterData> characterSheet(Ref ref, int characterId) async {
  final repository = ref.watch(characterRepositoryProvider);
  return repository.getCharacter(characterId);
}

final characterSheetControllerProvider = AsyncNotifierProvider.autoDispose
    .family<CharacterSheetController, CharacterData, int>(
  CharacterSheetController.new,
);

class CharacterSheetController
    extends AutoDisposeFamilyAsyncNotifier<CharacterData, int> {
  late final CharacterRepository _repository;
  late final int _characterId;
  int _saveRevision = 0;

  @override
  Future<CharacterData> build(int characterId) async {
    _characterId = characterId;
    _repository = ref.watch(characterRepositoryProvider);
    return _repository.getCharacter(characterId);
  }

  Future<void> reload() async {
    state =
        await AsyncValue.guard(() => _repository.getCharacter(_characterId));
  }

  Future<void> addAttack(CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks, attack];
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> updateAttack(int index, CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks[index] = attack;
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> deleteAttack(int index) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks.removeAt(index);
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> saveFeatureOverride(
    CharacterFeatureViewData feature, {
    String? name,
    String? description,
    List<FeatureTag>? tags,
  }) async {
    final current = _requireCharacter();
    final normalizedName = _normalizedText(name);
    final normalizedDescription = _normalizedText(description);
    final defaultName = _normalizedText(feature.defaultName);
    final defaultDescription = _normalizedText(feature.defaultDescription);
    final normalizedTags = _normalizedFeatureTags(
      tags ?? feature.tags,
      preserveEmpty: true,
    );
    final defaultTags = _normalizedFeatureTags(
      feature.defaultTags,
      preserveEmpty: false,
    );
    final featureOverrides = [...?current.featureOverrides];
    final overrideIndex = featureOverrides.indexWhere(
      (item) =>
          item.sourceType == feature.sourceType &&
          item.sourceId == feature.sourceId,
    );
    final matchesDefault = normalizedName == defaultName &&
        normalizedDescription == defaultDescription &&
        _featureTagsEqual(
          normalizedTags,
          defaultTags,
          preserveEmpty: false,
        );

    if (matchesDefault) {
      if (overrideIndex >= 0) {
        featureOverrides.removeAt(overrideIndex);
      }
    } else {
      final override = CharacterFeatureOverrideData(
        sourceType: feature.sourceType,
        sourceId: feature.sourceId,
        name: normalizedName,
        description: normalizedDescription,
        tags: normalizedTags,
      );
      if (overrideIndex >= 0) {
        featureOverrides[overrideIndex] = override;
      } else {
        featureOverrides.add(override);
      }
    }

    final updatedFeatures = _updateDerivedFeatureViews(
      current.derived?.activeFeatures,
      feature.sourceType,
      feature.sourceId,
      name: matchesDefault ? feature.defaultName : normalizedName,
      description:
          matchesDefault ? feature.defaultDescription : normalizedDescription,
      tags: matchesDefault ? feature.defaultTags : normalizedTags,
      isCustomized: !matchesDefault,
    );

    await _saveCharacter(
      current.copyWith(
        featureOverrides: featureOverrides,
        derived: current.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  Future<void> resetFeatureOverride(CharacterFeatureViewData feature) async {
    final current = _requireCharacter();
    final featureOverrides = [...?current.featureOverrides]..removeWhere(
        (item) =>
            item.sourceType == feature.sourceType &&
            item.sourceId == feature.sourceId,
      );
    final updatedFeatures = _updateDerivedFeatureViews(
      current.derived?.activeFeatures,
      feature.sourceType,
      feature.sourceId,
      name: feature.defaultName,
      description: feature.defaultDescription,
      tags: feature.defaultTags,
      isCustomized: false,
    );

    await _saveCharacter(
      current.copyWith(
        featureOverrides: featureOverrides,
        derived: current.derived?.copyWith(activeFeatures: updatedFeatures),
      ),
    );
  }

  CharacterData _requireCharacter() {
    final current = state.valueOrNull;
    if (current == null) {
      throw StateError('Character sheet is not loaded yet.');
    }
    return current;
  }

  Future<void> _saveCharacter(CharacterData updated) async {
    final previous = _requireCharacter();
    final revision = ++_saveRevision;
    state = AsyncValue.data(updated);

    try {
      final saved = await _repository.saveCharacter(updated);
      if (revision == _saveRevision) {
        state = AsyncValue.data(saved);
        ref.invalidate(characterSheetProvider(_characterId));
      }
    } catch (error, stackTrace) {
      if (revision == _saveRevision) {
        state = AsyncValue.data(previous);
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}

List<CharacterFeatureViewData>? _updateDerivedFeatureViews(
  List<CharacterFeatureViewData>? features,
  CharacterFeatureSourceType sourceType,
  int sourceId, {
  required String? name,
  required String? description,
  required List<FeatureTag>? tags,
  required bool isCustomized,
}) {
  if (features == null) {
    return null;
  }

  return [
    for (final feature in features)
      if (feature.sourceType == sourceType && feature.sourceId == sourceId)
        feature.copyWith(
          name: name,
          description: description,
          tags: tags,
          isCustomized: isCustomized,
        )
      else
        feature,
  ];
}

List<FeatureTag>? _normalizedFeatureTags(
  List<FeatureTag>? tags, {
  required bool preserveEmpty,
}) {
  if (tags == null) {
    return null;
  }

  final normalized = {...tags}.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  if (normalized.isEmpty && !preserveEmpty) {
    return null;
  }
  return normalized;
}

bool _featureTagsEqual(
  List<FeatureTag>? left,
  List<FeatureTag>? right, {
  required bool preserveEmpty,
}) {
  final normalizedLeft = _normalizedFeatureTags(
    left,
    preserveEmpty: preserveEmpty,
  );
  final normalizedRight = _normalizedFeatureTags(
    right,
    preserveEmpty: preserveEmpty,
  );
  if (normalizedLeft == null || normalizedRight == null) {
    return normalizedLeft == normalizedRight;
  }
  return listEquals(normalizedLeft, normalizedRight);
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
