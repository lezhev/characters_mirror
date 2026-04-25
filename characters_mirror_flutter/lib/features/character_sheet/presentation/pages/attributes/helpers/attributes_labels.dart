import 'package:characters_mirror_client/characters_mirror_client.dart';

String attributesAbilityLabel(Ability ability) {
  switch (ability) {
    case Ability.strength:
      return 'Сила';
    case Ability.dexterity:
      return 'Ловкость';
    case Ability.constitution:
      return 'Телосложение';
    case Ability.intelligence:
      return 'Интеллект';
    case Ability.wisdom:
      return 'Мудрость';
    case Ability.charisma:
      return 'Харизма';
  }
}

String shortAbilityLabel(Ability ability) {
  switch (ability) {
    case Ability.strength:
      return 'Сил';
    case Ability.dexterity:
      return 'Лов';
    case Ability.constitution:
      return 'Тел';
    case Ability.intelligence:
      return 'Инт';
    case Ability.wisdom:
      return 'Мдр';
    case Ability.charisma:
      return 'Хар';
  }
}

String skillLabel(Skill skill) {
  switch (skill) {
    case Skill.acrobatics:
      return 'Акробатика';
    case Skill.animalHandling:
      return 'Уход за животными';
    case Skill.arcana:
      return 'Магия';
    case Skill.athletics:
      return 'Атлетика';
    case Skill.deception:
      return 'Обман';
    case Skill.history:
      return 'История';
    case Skill.insight:
      return 'Проницательность';
    case Skill.intimidation:
      return 'Запугивание';
    case Skill.investigation:
      return 'Анализ';
    case Skill.medicine:
      return 'Медицина';
    case Skill.nature:
      return 'Природа';
    case Skill.perception:
      return 'Восприятие';
    case Skill.performance:
      return 'Выступление';
    case Skill.persuasion:
      return 'Убеждение';
    case Skill.religion:
      return 'Религия';
    case Skill.sleightOfHand:
      return 'Ловкость рук';
    case Skill.stealth:
      return 'Скрытность';
    case Skill.survival:
      return 'Выживание';
  }
}

String signedBonus(int value) => value >= 0 ? '+$value' : '$value';
