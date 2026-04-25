import 'package:characters_mirror_client/characters_mirror_client.dart';

String languageLabel(Language language) {
  switch (language) {
    case Language.common:
      return 'Общий';
    case Language.dwarvish:
      return 'Дварфийский';
    case Language.elvish:
      return 'Эльфийский';
    case Language.giant:
      return 'Великанский';
    case Language.gnomish:
      return 'Гномий';
    case Language.goblin:
      return 'Гоблинский';
    case Language.halfling:
      return 'Полуросликов';
    case Language.orc:
      return 'Орочий';
    case Language.abyssal:
      return 'Бездны';
    case Language.celestial:
      return 'Небесный';
    case Language.draconic:
      return 'Драконий';
    case Language.deepSpeech:
      return 'Глубинная речь';
    case Language.infernal:
      return 'Инфернальный';
    case Language.primordial:
      return 'Первичный';
    case Language.sylvan:
      return 'Сильван';
    case Language.undercommon:
      return 'Подземный';
  }
}
