part of '../offline_character_resolver.dart';

class _GrantedEquipmentAccumulator {
  _GrantedEquipmentAccumulator({
    required this.catalogType,
    required this.referenceKey,
    required this.displayText,
    required this.quantity,
  });

  final EquipmentCatalogType catalogType;
  final String referenceKey;
  String displayText;
  int quantity;
}

class _StartingEquipmentSourceBlock {
  const _StartingEquipmentSourceBlock({
    required this.sourceType,
    required this.sourceId,
    required this.blockView,
  });

  final ChoiceSourceType sourceType;
  final int sourceId;
  final StartingEquipmentBlockView blockView;
}

const offlineClassStepKind = 'class_step';

String offlineClassStepKey(
  int classId, {
  int selectedLevel = 1,
  int? selectedSubclassId,
  Map<String, int>? abilityScores,
}) {
  final abilityScoreKey = abilityScores == null || abilityScores.isEmpty
      ? 'none'
      : (abilityScores.entries.toList()
            ..sort((left, right) => left.key.compareTo(right.key)))
          .map((entry) => '${entry.key}=${entry.value}')
          .join(',');
  return [
    classId,
    selectedLevel,
    true,
    selectedSubclassId ?? 0,
    abilityScoreKey,
  ].join(':');
}
