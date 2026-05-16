import 'package:characters_mirror_client/characters_mirror_client.dart';

String conditionTypeLabel(ConditionType condition) {
  switch (condition) {
    case ConditionType.blinded:
      return 'Ослеплен';
    case ConditionType.charmed:
      return 'Очарован';
    case ConditionType.deafened:
      return 'Оглох';
    case ConditionType.frightened:
      return 'Испуган';
    case ConditionType.grappled:
      return 'Схвачен';
    case ConditionType.incapacitated:
      return 'Недееспособен';
    case ConditionType.invisible:
      return 'Невидим';
    case ConditionType.paralyzed:
      return 'Парализован';
    case ConditionType.petrified:
      return 'Окаменел';
    case ConditionType.poisoned:
      return 'Отравлен';
    case ConditionType.prone:
      return 'Лежит';
    case ConditionType.restrained:
      return 'Опутан';
    case ConditionType.stunned:
      return 'Ошеломлен';
    case ConditionType.unconscious:
      return 'Без сознания';
    case ConditionType.exhaustion:
      return 'Истощение';
  }
}
