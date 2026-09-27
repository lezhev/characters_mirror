import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

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
    final progression = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classId),
      orderBy: (t) => t.level,
    );
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
            classData: classData,
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
      subclassChoice: ClassStepSubclassChoiceView(
        requiredLevel: classData.subclassChoiceLevel,
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
        weaponTraining: isStartingClass
            ? classData.weaponTraining
            : classData.multiclassWeaponTraining,
        toolKeys: isStartingClass
            ? classData.toolTrainingKeys
            : classData.multiclassToolTrainingKeys,
      ),
      multiclassWarnings: warnings,
      progression: progression,
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
