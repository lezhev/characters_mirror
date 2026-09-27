import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildGroupedChoices stores stable group and option identities', () {
    final group = ChoiceGroupData(
      referenceKey: 'acolyte_extra_language',
      id: 1,
      sourceBackgroundId: 3,
      type: ChoiceType.language,
      selectionCount: 1,
      exclusiveKey: 'background_3_language_pick',
    );
    final option = ChoiceOptionData(
      choiceGroupId: 1,
      optionKey: 'celestial',
      name: 'celestial',
      grantedLanguages: const [Language.celestial],
    );

    final choices = buildGroupedChoices(
      selectedOptions: {
        'acolyte_extra_language': [option],
      },
      groups: [
        ChoiceGroupView(
          group: group,
          options: [option],
        ),
      ],
    );

    expect(choices, hasLength(1));
    expect(choices.single.groupKey, 'acolyte_extra_language');
    expect(choices.single.optionKey, 'celestial');
    expect(choices.single.selectionIndex, 0);
  });
}
