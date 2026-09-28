import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveFeatureDisplayProperties', () {
    test('resolves a static property', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'mode',
            label: 'Режим',
            valueKind: FeatureDisplayPropertyValueKind.staticValue,
            staticValue: 'Всегда',
          ),
        ],
        sourceLevel: 1,
      );

      expect(result.single.value, 'Всегда');
    });

    test('progression selects the greatest breakpoint not above source level',
        () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'damage',
            label: 'Урон',
            valueKind: FeatureDisplayPropertyValueKind.progression,
            progression: {1: '+2', 9: '+3', 16: '+4'},
          ),
        ],
        sourceLevel: 12,
      );

      expect(result.single.value, '+3');
    });

    test('progression below the first breakpoint resolves to no property', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'die',
            label: 'Кость',
            valueKind: FeatureDisplayPropertyValueKind.progression,
            progression: {5: 'к8', 10: 'к10'},
          ),
        ],
        sourceLevel: 1,
      );

      expect(result, isEmpty);
    });

    test('sorts resolved properties by sortOrder', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'late',
            label: 'Позже',
            valueKind: FeatureDisplayPropertyValueKind.staticValue,
            staticValue: '2',
            sortOrder: 20,
          ),
          FeatureDisplayPropertyDefinition(
            key: 'early',
            label: 'Раньше',
            valueKind: FeatureDisplayPropertyValueKind.staticValue,
            staticValue: '1',
            sortOrder: 10,
          ),
        ],
        sourceLevel: 1,
      );

      expect(result.map((property) => property.key), ['early', 'late']);
    });

    test('feature without definitions resolves to an empty list', () {
      expect(
        resolveFeatureDisplayProperties(definitions: const [], sourceLevel: 1),
        isEmpty,
      );
    });

    test('formula uses its source class level rather than character level', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'fighter_level',
            label: 'Уровень класса',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: 'classLevel',
          ),
        ],
        sourceLevel: 5,
        characterLevel: 12,
      );

      expect(result.single.value, '5');
    });

    test('subclass formula uses the supplied subclass context level', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'subclass_level',
            label: 'Уровень подкласса',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: 'subclassLevel',
          ),
        ],
        sourceLevel: 5,
        subclassLevel: 7,
      );

      expect(result.single.value, '7');
    });

    test('formula renders dice expression without rolling it', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'healing',
            label: 'Лечение',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: '1d10 + classLevel',
          ),
        ],
        sourceLevel: 5,
      );

      expect(result.single.value, '1к10 + 5');
    });

    test('formula evaluates ceil and ability modifier with safe operands', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'recovery',
            label: 'Восстановление',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: 'ceil(classLevel / 2)',
          ),
          FeatureDisplayPropertyDefinition(
            key: 'ability',
            label: 'Модификатор',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: 'abilityModifier(wisdom)',
          ),
        ],
        sourceLevel: 5,
        abilityModifiers: const {'wisdom': 3},
      );

      expect(result.map((property) => property.value), ['3', '3']);
    });

    test('formula rejects unsupported identifiers and syntax', () {
      final result = resolveFeatureDisplayProperties(
        definitions: const [
          FeatureDisplayPropertyDefinition(
            key: 'bad',
            label: 'Некорректно',
            valueKind: FeatureDisplayPropertyValueKind.formula,
            formula: 'classLevel + arbitraryFunction(2)',
          ),
        ],
        sourceLevel: 5,
      );

      expect(result, isEmpty);
    });
  });
}
