import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'choice_group_presentation.dart';

ChoiceGroupPresentation subclassChoicePresentation(
        List<SubclassData> subclasses, int? selectedId) =>
    ChoiceGroupPresentation.fromView(
        ChoiceGroupView(
            group: ChoiceGroupData(
                referenceKey: 'subclass',
                name: 'Подкласс',
                selectionCount: 1,
                minimumSelectionCount: 1),
            options: [
              for (final s in subclasses)
                if (s.id != null)
                  ChoiceOptionData(
                      choiceGroupId: 0,
                      optionKey: '${s.id}',
                      name: subclassDisplayName(s.subclassName, s.name) ??
                          'Подкласс',
                      shortDescription: s.shortDescription)
            ]),
        selectedId == null ? [] : ['$selectedId'],
        mode: ChoicePresentationMode.picker);
