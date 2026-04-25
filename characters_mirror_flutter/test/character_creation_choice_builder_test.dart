import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_choice_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildGroupedChoices stores selectedLanguage for language choices', () {
    final group = ClassChoiceGroupData(
      id: 1,
      sourceBackgroundId: 3,
      type: ClassChoiceType.language,
      selectionCount: 1,
      exclusiveKey: 'background_3_language_pick',
    );
    final option = ClassChoiceOptionData(
      choiceGroupId: 1,
      optionKey: 'celestial',
      name: 'celestial',
      grantedLanguages: const [Language.celestial],
    );

    final choices = buildGroupedChoices(
      selectedOptions: {
        'background_3_language_pick': [option],
      },
      groups: [
        ClassChoiceGroupView(
          group: group,
          options: [option],
        ),
      ],
    );

    expect(choices, hasLength(1));
    expect(choices.single.selectedLanguage, Language.celestial);
    expect(choices.single.selectedText, 'celestial');
  });
}
