import 'package:characters_mirror_server/src/feature_relations.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  const base = 'classFeature:wild_shape';
  const moon = 'subclassFeature:moon_forms';
  const other = 'subclassFeature:other_forms';

  FeatureRelationData relation(
    String source,
    String target,
    FeatureRelationType type, {
    int priority = 0,
    Map<String, String>? mappings,
  }) {
    final sourceParts = source.split(':');
    final targetParts = target.split(':');
    return FeatureRelationData(
      sourceType: CharacterFeatureSourceType.values.byName(sourceParts.first),
      sourceReferenceKey: sourceParts.last,
      targetType: CharacterFeatureSourceType.values.byName(targetParts.first),
      targetReferenceKey: targetParts.last,
      relationType: type,
      priority: priority,
      propertyMappings: mappings,
    );
  }

  test('ordinary features are unchanged when there are no relations', () {
    final resolution = resolveFeatureRelations(
      relations: const [],
      knownFeatures: {base},
      acquiredFeatures: {base},
    );

    expect(resolution.suppressed, isEmpty);
    expect(resolution.enhancementsByTarget, isEmpty);
  });

  test('replacements only suppress a target while the source is acquired', () {
    final enhancement = relation(
      moon,
      base,
      FeatureRelationType.replaces,
    );
    final inactive = resolveFeatureRelations(
      relations: [enhancement],
      knownFeatures: {base, moon},
      acquiredFeatures: {base},
    );
    final active = resolveFeatureRelations(
      relations: [enhancement],
      knownFeatures: {base, moon},
      acquiredFeatures: {base, moon},
    );

    expect(inactive.suppressed, isEmpty);
    expect(active.suppressed, {base});
  });

  test('enhancements retain mappings and sort competing sources by priority',
      () {
    final relations = [
      relation(moon, base, FeatureRelationType.enhances,
          priority: 1, mappings: {'max_forms': 'max_cr'}),
      relation(other, base, FeatureRelationType.enhances,
          priority: 3, mappings: {'max_forms': 'max_cr'}),
    ];
    final resolved = resolveFeatureRelations(
      relations: relations,
      knownFeatures: {base, moon, other},
      acquiredFeatures: {base, moon, other},
    );

    expect(resolved.enhancementsByTarget[base], [relations[1], relations[0]]);
    expect(resolved.suppressed, isEmpty);
  });

  test('self references, unknown references, and cycles are rejected', () {
    expect(
      () => resolveFeatureRelations(
        relations: [relation(base, base, FeatureRelationType.replaces)],
        knownFeatures: {base},
        acquiredFeatures: {base},
      ),
      throwsStateError,
    );
    expect(
      () => resolveFeatureRelations(
        relations: [relation(moon, base, FeatureRelationType.replaces)],
        knownFeatures: {base},
        acquiredFeatures: {base, moon},
      ),
      throwsStateError,
    );
    expect(
      () => resolveFeatureRelations(
        relations: [
          relation(moon, base, FeatureRelationType.replaces),
          relation(base, moon, FeatureRelationType.replaces),
        ],
        knownFeatures: {base, moon},
        acquiredFeatures: {base, moon},
      ),
      throwsStateError,
    );
  });

  test('one feature pair cannot both enhance and replace', () {
    expect(
      () => resolveFeatureRelations(
        relations: [
          relation(moon, base, FeatureRelationType.enhances,
              mappings: {'max_forms': 'max_cr'}),
          relation(moon, base, FeatureRelationType.replaces),
        ],
        knownFeatures: {base, moon},
        acquiredFeatures: {base, moon},
      ),
      throwsStateError,
    );
  });

  test('multiple active replacements of one target are rejected', () {
    expect(
      () => resolveFeatureRelations(
        relations: [
          relation(moon, base, FeatureRelationType.replaces),
          relation(other, base, FeatureRelationType.replaces),
        ],
        knownFeatures: {base, moon, other},
        acquiredFeatures: {base, moon, other},
      ),
      throwsStateError,
    );
  });

  test('a replaced feature does not activate its own replacements', () {
    final base = 'classFeature:base';
    final replacement = 'subclassFeature:replacement';
    final nested = 'raceFeature:nested';
    final resolved = resolveFeatureRelations(
      relations: [
        relation(replacement, base, FeatureRelationType.replaces),
        relation(nested, replacement, FeatureRelationType.replaces),
      ],
      knownFeatures: {base, replacement, nested},
      acquiredFeatures: {base, replacement, nested},
    );

    expect(resolved.suppressed, {replacement});
  });
}
