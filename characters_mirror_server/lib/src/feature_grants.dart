import 'generated/protocol.dart';

/// Collect only currently unlocked features; manual overrides are applied later.
({
  List<Skill> grantedSkills,
  List<Skill> grantedExpertiseSkills,
  List<Language> grantedLanguages,
  List<ArmorCategory> grantedArmorTraining,
  List<WeaponCategory> grantedWeaponTraining,
  List<String> grantedToolKeys,
  List<String> grantedExpertiseToolKeys,
  List<String> grantedSpellKeys,
}) collectFixedFeatureGrants(
  Iterable<ClassFeatureData> classFeatures,
  Iterable<SubclassFeatureData> subclassFeatures,
) =>
    (
      grantedSkills: [
        for (final feature in classFeatures) ...?feature.grantedSkills,
        for (final feature in subclassFeatures) ...?feature.grantedSkills,
      ],
      grantedExpertiseSkills: [
        for (final feature in classFeatures) ...?feature.grantedExpertiseSkills,
        for (final feature in subclassFeatures)
          ...?feature.grantedExpertiseSkills,
      ],
      grantedLanguages: [
        for (final feature in classFeatures) ...?feature.grantedLanguages,
        for (final feature in subclassFeatures) ...?feature.grantedLanguages,
      ],
      grantedArmorTraining: [
        for (final feature in classFeatures) ...?feature.grantedArmorTraining,
        for (final feature in subclassFeatures)
          ...?feature.grantedArmorTraining,
      ],
      grantedWeaponTraining: [
        for (final feature in classFeatures) ...?feature.grantedWeaponTraining,
        for (final feature in subclassFeatures)
          ...?feature.grantedWeaponTraining,
      ],
      grantedToolKeys: [
        for (final feature in classFeatures) ...?feature.grantedToolKeys,
        for (final feature in subclassFeatures) ...?feature.grantedToolKeys,
      ],
      grantedExpertiseToolKeys: [
        for (final feature in classFeatures)
          ...?feature.grantedExpertiseToolKeys,
        for (final feature in subclassFeatures)
          ...?feature.grantedExpertiseToolKeys,
      ],
      grantedSpellKeys: [
        for (final feature in classFeatures) ...?feature.grantedSpellKeys,
        for (final feature in subclassFeatures) ...?feature.grantedSpellKeys,
      ],
    );
