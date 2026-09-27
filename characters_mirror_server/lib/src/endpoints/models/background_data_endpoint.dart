import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'general/starting_equipment_endpoints.dart';

class BackgroundDataEndpoint extends Endpoint {
  Future<List<BackgroundData>> getAll(Session session) async {
    return await BackgroundData.db.find(session);
  }

  Future<BackgroundStepView> getStepView(
    Session session,
    int backgroundId,
  ) async {
    final backgrounds = await BackgroundData.db.find(
      session,
      where: (t) => t.id.equals(backgroundId),
      limit: 1,
    );
    if (backgrounds.isEmpty) {
      throw Exception('BackgroundData with id=$backgroundId was not found.');
    }

    final groups = await ChoiceGroupData.db.find(
      session,
      where: (t) => t.sourceBackgroundId.equals(backgroundId),
      orderBy: (t) => t.sortOrder,
    );
    final choiceGroups = <ChoiceGroupView>[];
    for (final group in groups) {
      final options = await ChoiceOptionData.db.find(
        session,
        where: (t) => t.choiceGroupId.equals(group.id),
        orderBy: (t) => t.sortOrder,
      );
      choiceGroups.add(
        ChoiceGroupView(
          group: group,
          options: options,
        ),
      );
    }

    final startingEquipmentBlocks = await startingEquipmentBlockViews(
      session,
      sourceBackgroundId: backgroundId,
    );

    return BackgroundStepView(
      background: backgrounds.first,
      choiceGroups: choiceGroups,
      skillSelectionGroups: _buildBackgroundSkillSelectionGroups(
        backgrounds.first,
      ),
      startingEquipmentBlocks: startingEquipmentBlocks,
    );
  }

  Future<BackgroundData> add(Session session, BackgroundData background) async {
    return await BackgroundData.db.insertRow(session, background);
  }

  Future<BackgroundData> upsert(
      Session session, BackgroundData background) async {
    final existing = await BackgroundData.db.find(
      session,
      where: (t) => t.id.equals(background.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      background.id = existing.first.id;
      await BackgroundData.db.updateRow(session, background);
      return background;
    } else {
      return await BackgroundData.db.insertRow(session, background);
    }
  }

  Future<void> delete(Session session, int id) async {
    await BackgroundData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

List<SkillSelectionGroupView> _buildBackgroundSkillSelectionGroups(
  BackgroundData background,
) {
  final backgroundId = background.id;
  final skillCount = background.skillCount ?? 0;
  final options = _uniqueSkills(background.availableSkills);
  if (backgroundId == null || skillCount <= 0 || options.isEmpty) {
    return const <SkillSelectionGroupView>[];
  }

  return [
    SkillSelectionGroupView(
      kind: CharacterSkillSelectionKind.backgroundSkill,
      selectionCount: skillCount,
      backgroundDataId: backgroundId,
      options: options,
    ),
  ];
}

List<Skill> _uniqueSkills(List<Skill>? skills) {
  final result = <Skill>[];
  final seen = <Skill>{};
  for (final skill in skills ?? const <Skill>[]) {
    if (seen.add(skill)) {
      result.add(skill);
    }
  }
  return result;
}
