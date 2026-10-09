import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  final groups = [
    for (final level in [3, 7])
      {
        'referenceKey': 'line_$level',
        'level': level,
        'progressionKey': 'line',
        'replacementsAllowed': level == 7 ? 1 : 0,
        'options': [
          for (final key in ['a', 'b', 'c']) {'referenceKey': key}
        ]
      }
  ];
  final choices = [
    {
      'id': 'old',
      'classEntry': {'id': 'entry'},
      'groupKey': 'line_3',
      'optionKey': 'a'
    },
    {
      'id': 'other',
      'classEntry': {'id': 'entry'},
      'groupKey': 'line_3',
      'optionKey': 'b'
    }
  ];
  Map<String, dynamic> request(String key) =>
      {'groupKey': 'line_7', 'selectionId': 'old', 'optionKey': key};
  test('replacement and rollback preserve identity and original option', () {
    final updated = replaceProgressionChoices(choices, [request('c')], groups,
        classEntryId: 'entry', classLevel: 7);
    expect(updated.first['optionKey'], 'c');
    expect(updated.first['id'], 'old');
    expect(choices.first['optionKey'], 'a');
    expect(
        rollbackProgressionChoices(updated,
                classEntryId: 'entry', targetLevel: 6)
            .first['optionKey'],
        'a');
  });
  test('duplicates, excess replacements and ineligible options fail atomically',
      () {
    expect(
        () => replaceProgressionChoices(choices, [request('b')], groups,
            classEntryId: 'entry', classLevel: 7),
        throwsArgumentError);
    expect(
        () => replaceProgressionChoices(
            choices, [request('c'), request('c')], groups,
            classEntryId: 'entry', classLevel: 7),
        throwsArgumentError);
    expect(
        () => replaceProgressionChoices(choices, [request('c')], groups,
            classEntryId: 'entry',
            classLevel: 7,
            isEligible: (group, option) => false),
        throwsArgumentError);
    expect(choices.first['optionKey'], 'a');
  });
  test('legacy unbound choices acquire a stable class entry binding', () {
    final legacy = [
      for (final choice in choices) {...choice, 'classEntry': null}
    ];
    final updated = replaceProgressionChoices(legacy, [request('c')], groups,
        classEntryId: 'entry', classLevel: 7);
    expect((updated.first['classEntry'] as Map)['id'], 'entry');
    expect(updated.first['id'], 'old');
    expect(
        rollbackProgressionChoices(updated,
                classEntryId: 'entry', targetLevel: 6)
            .first['optionKey'],
        'a');
  });
  test(
      'a later-only option resolves through its recorded replacement authority',
      () {
    final scoped = [
      {
        ...groups.first,
        'id': 1,
        'options': [
          {'optionKey': 'a'}
        ]
      },
      {
        ...groups.last,
        'id': 2,
        'progressionKey': 'new_line',
        'replacementProgressionKeys': ['line'],
        'options': [
          {'optionKey': 'c'}
        ]
      },
    ];
    final updated = replaceProgressionChoices(
        choices.take(1), [request('c')], scoped,
        classEntryId: 'entry', classLevel: 7);
    final resolved = resolveProgressionChoiceOption(updated.single, scoped, [
      {'id': 10, 'choiceGroupId': 1, 'optionKey': 'a'},
      {'id': 20, 'choiceGroupId': 2, 'optionKey': 'c'},
    ]);
    expect(resolved?['id'], 20);
    expect(resolved?['choiceGroupId'], 1);
    expect(
        resolveProgressionChoiceOption(updated.single, scoped.take(1), [
          {'id': 20, 'choiceGroupId': 2, 'optionKey': 'c'},
        ]),
        isNull);
  });
}
