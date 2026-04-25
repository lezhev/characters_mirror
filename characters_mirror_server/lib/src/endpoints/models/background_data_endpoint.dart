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

    final groups = await ClassChoiceGroupData.db.find(
      session,
      where: (t) => t.sourceBackgroundId.equals(backgroundId),
      orderBy: (t) => t.id,
    );
    final choiceGroups = <ClassChoiceGroupView>[];
    for (final group in groups) {
      final options = await ClassChoiceOptionData.db.find(
        session,
        where: (t) => t.choiceGroupId.equals(group.id),
      );
      choiceGroups.add(
        ClassChoiceGroupView(
          group: group,
          options: options,
        ),
      );
    }
    final languageChoiceGroup =
        _buildLanguageChoiceGroup(backgrounds.first);
    if (languageChoiceGroup != null &&
        !_hasLanguageChoiceGroup(choiceGroups)) {
      choiceGroups.add(languageChoiceGroup);
    }

    final startingEquipmentBlocks = await loadStartingEquipmentBlockViews(
      session,
      sourceBackgroundId: backgroundId,
    );

    return BackgroundStepView(
      background: backgrounds.first,
      choiceGroups: choiceGroups,
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

bool _hasLanguageChoiceGroup(List<ClassChoiceGroupView> groups) {
  return groups.any((view) => view.group?.type == ClassChoiceType.language);
}

ClassChoiceGroupView? _buildLanguageChoiceGroup(BackgroundData background) {
  final languageCount = background.languageCount ?? 0;
  final backgroundId = background.id;
  if (languageCount <= 0 || backgroundId == null) {
    return null;
  }

  final groupId = -backgroundId;
  return ClassChoiceGroupView(
    group: ClassChoiceGroupData(
      id: groupId,
      name: 'Языки',
      description: 'Выберите языки, которые дает предыстория.',
      sourceBackgroundId: backgroundId,
      type: ClassChoiceType.language,
      selectionCount: languageCount,
      exclusiveKey: 'background_${backgroundId}_language_pick',
      allowDuplicates: false,
    ),
    options: [
      for (final language in Language.values)
        ClassChoiceOptionData(
          choiceGroupId: groupId,
          optionKey: language.name,
          name: language.name,
          grantedLanguages: [language],
        ),
    ],
  );
}
