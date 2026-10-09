import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_server/src/feature_display_properties.dart';
import 'package:characters_mirror_server/src/feature_resource_summary.dart';
import 'package:serverpod/serverpod.dart';
import 'package:characters_mirror_server/src/weapon_training_values.dart';
import 'package:characters_mirror_server/src/validation/rules.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';

import '../../../spells/class_spell_progression.dart';
import '../../../spells/spellcasting_source.dart';
import 'starting_equipment_endpoints.dart';

part 'class_endpoints/class_step_helpers.dart';
part 'class_endpoints/class_resource_endpoints.dart';
part 'class_endpoints/class_write_helpers.dart';

class ClassDataEndpoint extends Endpoint {
  Future<List<ClassData>> getAll(Session session) async {
    return ClassData.db.find(session);
  }

  Future<ClassData> add(Session session, ClassData classData) async {
    _stampForInsert(classData);
    return ClassData.db.insertRow(session, classData);
  }

  Future<ClassData> upsert(Session session, ClassData classData) async {
    return _upsertById(
      session,
      classData,
      findExisting: () => ClassData.db.find(
        session,
        where: (t) => t.id.equals(classData.id),
        limit: 1,
      ),
      insert: () => ClassData.db.insertRow(session, classData),
      update: () async {
        await ClassData.db.updateRow(session, classData);
        return classData;
      },
    );
  }

  Future<ClassStepView> getStepView(
    Session session,
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) async {
    final classData = await _requireById<ClassData>(
      await ClassData.db.find(
        session,
        where: (t) => t.id.equals(classId),
        limit: 1,
      ),
      'ClassData',
      classId,
    );
    final features = await ClassFeatureData.db.find(
      session,
      where: (t) => t.parentClassId.equals(classId),
      orderBy: (t) => t.level,
      include: _classFeatureInclude(),
    );
    final subclasses = await SubclassData.db.find(
      session,
      where: (t) => t.parentClassId.equals(classId),
      orderBy: (t) => t.levelRequired,
    );
    final subclassFeatures = selectedSubclassId == null
        ? const <SubclassFeatureData>[]
        : await SubclassFeatureData.db.find(
            session,
            where: (t) => t.parentSubclassId.equals(selectedSubclassId),
            orderBy: (t) => t.level,
            include: _subclassFeatureInclude(),
          );
    final selectedSubclass = subclasses
        .where((subclass) => subclass.id == selectedSubclassId)
        .firstOrNull;
    final spellcastingData =
        effectiveSpellcastingClass(classData, selectedSubclass, selectedLevel);
    final progressionRows = await ClassLevelData.db.find(
      session,
      where: (t) =>
          (t.classDataId.equals(classId) & t.subclassDataId.equals(null)) |
          (selectedSubclass == null
              ? t.id.equals(-1)
              : t.subclassDataId.equals(selectedSubclass.id)),
      orderBy: (t) => t.level,
    );
    final progression =
        effectiveSpellProgression(classData, selectedSubclass, progressionRows);
    final selectedClassLevel = _classLevelForSelection(
      progression,
      selectedLevel,
    );
    final groups = await ChoiceGroupData.db.find(session);
    final currentFeatureIds = features
        .where((feature) => feature.level <= selectedLevel)
        .map((feature) => feature.id)
        .whereType<int>()
        .toSet();
    final currentSubclassFeatureIds = subclassFeatures
        .where((feature) => feature.level <= selectedLevel)
        .map((feature) => feature.id)
        .whereType<int>()
        .toSet();
    final featureModifiers = <FeatureModifierData>[
      if (currentFeatureIds.isNotEmpty)
        ...await FeatureModifierData.db.find(
          session,
          where: (t) => t.classFeatureId.inSet(currentFeatureIds),
          orderBy: (t) => t.referenceKey,
        ),
      if (currentSubclassFeatureIds.isNotEmpty)
        ...await FeatureModifierData.db.find(
          session,
          where: (t) => t.subclassFeatureId.inSet(currentSubclassFeatureIds),
          orderBy: (t) => t.referenceKey,
        ),
    ];

    final currentGroups = <ChoiceGroupView>[];
    for (final group in groups.where((group) {
      final byClass = group.sourceClassId == classId;
      final byFeature = group.sourceFeatureId != null &&
          currentFeatureIds.contains(group.sourceFeatureId);
      final bySubclass = selectedSubclassId != null &&
          group.sourceSubclassId == selectedSubclassId;
      final bySubclassFeature = group.sourceSubclassFeatureId != null &&
          currentSubclassFeatureIds.contains(group.sourceSubclassFeatureId);
      final unlocked = (group.level ?? 1) <= selectedLevel;
      return unlocked &&
          (byClass || byFeature || bySubclass || bySubclassFeature);
    })) {
      final options = await ChoiceOptionData.db.find(
        session,
        where: (t) => t.choiceGroupId.equals(group.id),
        orderBy: (t) => t.sortOrder,
      );
      currentGroups.add(
        ChoiceGroupView(
          group: group,
          options: options,
        ),
      );
    }
    final startingEquipmentBlocks = isStartingClass
        ? await startingEquipmentBlockViews(session, sourceClassId: classId)
        : const <StartingEquipmentBlockView>[];
    final skillSelectionGroups = isStartingClass
        ? _buildClassSkillSelectionGroups(classData)
        : const <SkillSelectionGroupView>[];
    final spellSelectionGroups = isStartingClass && selectedClassLevel != null
        ? await _buildSpellSelectionGroups(
            session,
            classId: classId,
            selectedSubclassId: selectedSubclassId,
            classData: spellcastingData,
            selectedLevel: selectedLevel,
            classLevel: selectedClassLevel,
            abilityScores: abilityScores,
          )
        : const <ClassSpellSelectionGroupView>[];

    final warnings = <String>[];
    if (!isStartingClass) {
      warnings.add(
        'Saving throw proficiencies come only from the starting class.',
      );
      if (classData.multiclassPrerequisites?.isNotEmpty == true) {
        final requirements = classData.multiclassPrerequisites!.entries
            .map((entry) => '${entry.key} ${entry.value}+')
            .join(', ');
        warnings.add('Multiclass prerequisite: $requirements.');
      }
    }

    final weaponTrainingValues = isStartingClass
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;

    return ClassStepView(
      classData: classData,
      selectedLevel: selectedLevel,
      currentLevelFeatures: features
          .where((feature) => feature.level <= selectedLevel)
          .map(_normalizeClassFeature)
          .toList(),
      futureLevelFeatures: features
          .where((feature) => feature.level > selectedLevel)
          .map(_normalizeClassFeature)
          .toList(),
      currentSubclassFeatures: subclassFeatures
          .where((feature) => feature.level <= selectedLevel)
          .map(_normalizeSubclassFeature)
          .toList(),
      futureSubclassFeatures: subclassFeatures
          .where((feature) => feature.level > selectedLevel)
          .map(_normalizeSubclassFeature)
          .toList(),
      currentLevelFeatureViews: await _classStepFeatureViews(
        session,
        features.where((feature) => feature.level <= selectedLevel),
        sourceLevel: selectedLevel,
        abilityModifiers: _abilityModifiersForScores(abilityScores),
      ),
      futureLevelFeatureViews: await _classStepFeatureViews(
        session,
        features.where((feature) => feature.level > selectedLevel),
        sourceLevel: selectedLevel,
        abilityModifiers: _abilityModifiersForScores(abilityScores),
      ),
      currentSubclassFeatureViews: await _subclassStepFeatureViews(
        session,
        subclassFeatures.where((feature) => feature.level <= selectedLevel),
        sourceLevel: selectedLevel,
        abilityModifiers: _abilityModifiersForScores(abilityScores),
      ),
      futureSubclassFeatureViews: await _subclassStepFeatureViews(
        session,
        subclassFeatures.where((feature) => feature.level > selectedLevel),
        sourceLevel: selectedLevel,
        abilityModifiers: _abilityModifiersForScores(abilityScores),
      ),
      subclassChoice: ClassStepSubclassChoiceView(
        requiredLevel: classData.subclassChoiceLevel,
        sourceFeatureId: features.any((f) =>
                f.id == classData.subclassChoiceFeatureId &&
                f.level == classData.subclassChoiceLevel)
            ? classData.subclassChoiceFeatureId
            : null,
        subclasses: subclasses,
      ),
      choiceGroups: currentGroups,
      skillSelectionGroups: skillSelectionGroups,
      spellSelectionGroups: spellSelectionGroups,
      startingEquipmentBlocks: startingEquipmentBlocks,
      startingProficiencies: ProficiencyBundleView(
        savingThrows: classData.savingThrowProficiencies,
        skills: classData.availableSkills,
        armorTraining: isStartingClass
            ? classData.armorTraining
            : classData.multiclassArmorTraining,
        weaponTraining:
            weaponCategoriesFromTrainingValues(weaponTrainingValues),
        weaponProficiencyKeys:
            weaponKeysFromTrainingValues(weaponTrainingValues),
        toolKeys: isStartingClass
            ? classData.toolTrainingKeys
            : classData.multiclassToolTrainingKeys,
      ),
      multiclassWarnings: warnings,
      progression: progression,
      featureModifiers: featureModifiers,
    );
  }

  Future<ClassSpellDeltaView> getSpellDelta(
    Session session,
    int classId,
    int fromLevel,
    int toLevel,
    Map<String, int> abilityScores, {
    int? selectedSubclassId,
  }) async {
    if (fromLevel < 1 ||
        toLevel <= fromLevel ||
        toLevel > 20 ||
        abilityScores.length > Ability.values.length ||
        abilityScores.entries.any((entry) =>
            !Ability.values.any((ability) => ability.name == entry.key))) {
      throw ArgumentError('Invalid class levels or ability scores.');
    }
    Rules.smallCollection('abilityScores', abilityScores);
    for (final entry in abilityScores.entries) {
      Rules.boundedInt('abilityScores.${entry.key}', entry.value,
          min: 1, max: 30);
    }
    final data = await ClassData.db.findById(session, classId);
    if (data == null) throw StateError('ClassData not found.');
    final subclass = selectedSubclassId == null
        ? null
        : await SubclassData.db.findById(session, selectedSubclassId);
    if (selectedSubclassId != null &&
        (subclass == null || subclass.parentClassId != classId)) {
      throw ArgumentError('Subclass does not belong to this class.');
    }
    final rows = effectiveSpellProgression(
        data,
        subclass,
        await ClassLevelData.db.find(session,
            where: (t) =>
                ((t.classDataId.equals(classId) &
                        t.subclassDataId.equals(null)) |
                    (subclass == null
                        ? t.id.equals(-1)
                        : t.subclassDataId.equals(subclass.id))) &
                t.level.inSet({fromLevel, toLevel})));
    final before = rows.where((row) => row.level == fromLevel).firstOrNull;
    final after = rows.where((row) => row.level == toLevel).firstOrNull;
    if (before == null || after == null) {
      throw StateError('Class progression row not found.');
    }
    return buildClassSpellDelta(
        effectiveSpellcastingClass(data, subclass, toLevel), before, after,
        abilityScores: abilityScores);
  }

  Future<void> delete(Session session, int id) async {
    await ClassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
