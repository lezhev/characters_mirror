import 'package:characters_mirror_server/src/generated/protocol.dart';

String featureRelationIdentity(
  CharacterFeatureSourceType type,
  String referenceKey,
) =>
    '${type.name}:$referenceKey';

class FeatureRelationResolution {
  const FeatureRelationResolution({
    required this.suppressed,
    required this.enhancementsByTarget,
    required this.displayMerges,
  });

  final Set<String> suppressed;
  final Map<String, List<FeatureRelationData>> enhancementsByTarget;
  final List<FeatureRelationData> displayMerges;
}

FeatureRelationResolution resolveFeatureRelations({
  required Iterable<FeatureRelationData> relations,
  required Set<String> knownFeatures,
  required Set<String> acquiredFeatures,
}) {
  final outgoing = <String, List<String>>{};
  final replacementsByTarget = <String, List<FeatureRelationData>>{};
  final enhancementsByTarget = <String, List<FeatureRelationData>>{};
  final displayMerges = <FeatureRelationData>[];
  final unique = <String>{};

  for (final relation in relations) {
    final source = featureRelationIdentity(
      relation.sourceType,
      relation.sourceReferenceKey,
    );
    final target = featureRelationIdentity(
      relation.targetType,
      relation.targetReferenceKey,
    );
    if (source == target) {
      throw StateError('A feature relation cannot target itself.');
    }
    if (!knownFeatures.contains(source) || !knownFeatures.contains(target)) {
      throw StateError('A feature relation references an unknown feature.');
    }
    final pair = '$source>$target';
    if (!unique.add(pair)) {
      throw StateError('Duplicate feature relation: $pair.');
    }
    outgoing.putIfAbsent(source, () => []).add(target);
    switch (relation.relationType) {
      case FeatureRelationType.enhances:
        if (relation.propertyMappings?.isEmpty != false) {
          throw StateError('Enhancement relations require property mappings.');
        }
        if (relation.propertyMappings!.entries.any((mapping) =>
            mapping.key.trim().isEmpty ||
            mapping.value.trim().isEmpty ||
            mapping.key != mapping.key.trim() ||
            mapping.value != mapping.value.trim())) {
          throw StateError(
              'Property mappings must use non-empty canonical keys.');
        }
        enhancementsByTarget.putIfAbsent(target, () => []).add(relation);
        if (relation.mergeDisplay == true) displayMerges.add(relation);
        break;
      case FeatureRelationType.replaces:
        if (relation.propertyMappings?.isNotEmpty == true ||
            relation.mergeDisplay == true) {
          throw StateError(
              'Replacement relations cannot define enhancement properties.');
        }
        replacementsByTarget.putIfAbsent(target, () => []).add(relation);
        break;
    }
  }

  final visiting = <String>{};
  final visited = <String>{};
  void visit(String node) {
    if (visiting.contains(node)) {
      throw StateError('Feature relations contain a cycle.');
    }
    if (!visited.add(node)) return;
    visiting.add(node);
    for (final target in outgoing[node] ?? const <String>[]) {
      visit(target);
    }
    visiting.remove(node);
  }

  for (final node in outgoing.keys) {
    visit(node);
  }

  final activeMemo = <String, bool>{};
  bool isActive(String feature) {
    final cached = activeMemo[feature];
    if (cached != null) return cached;
    final activeSources = (replacementsByTarget[feature] ?? const [])
        .where((relation) => isActive(featureRelationIdentity(
              relation.sourceType,
              relation.sourceReferenceKey,
            )))
        .length;
    if (activeSources > 1 && acquiredFeatures.contains(feature)) {
      throw StateError('Multiple active features replace $feature.');
    }
    final active = acquiredFeatures.contains(feature) && activeSources == 0;
    activeMemo[feature] = active;
    return active;
  }

  final suppressed = <String>{};
  for (final feature in acquiredFeatures) {
    if (!isActive(feature)) suppressed.add(feature);
  }
  for (final relationsForTarget in enhancementsByTarget.values) {
    relationsForTarget.sort((a, b) {
      final priority = b.priority.compareTo(a.priority);
      if (priority != 0) return priority;
      final type = a.sourceType.name.compareTo(b.sourceType.name);
      if (type != 0) return type;
      return a.sourceReferenceKey.compareTo(b.sourceReferenceKey);
    });
  }

  return FeatureRelationResolution(
    suppressed: suppressed,
    enhancementsByTarget: enhancementsByTarget,
    displayMerges: displayMerges,
  );
}
