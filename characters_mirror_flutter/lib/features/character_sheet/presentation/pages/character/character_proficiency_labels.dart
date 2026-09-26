import 'package:characters_mirror_client/characters_mirror_client.dart';

String languageProficiencyLabel(Language language) => switch (language) {
      Language.common => 'Общий',
      Language.dwarvish => 'Дварфийский',
      Language.elvish => 'Эльфийский',
      Language.giant => 'Великаний',
      Language.gnomish => 'Гномий',
      Language.goblin => 'Гоблинский',
      Language.halfling => 'Полуросликов',
      Language.orc => 'Орочий',
      Language.abyssal => 'Бездны',
      Language.celestial => 'Небесный',
      Language.draconic => 'Драконий',
      Language.deepSpeech => 'Глубинная речь',
      Language.infernal => 'Инфернальный',
      Language.primordial => 'Первичный',
      Language.sylvan => 'Сильван',
      Language.undercommon => 'Подземный',
    };

String weaponCategoryProficiencyLabel(WeaponCategory category) =>
    switch (category) {
      WeaponCategory.simpleMelee => 'Простое рукопашное оружие',
      WeaponCategory.simpleRanged => 'Простое дальнобойное оружие',
      WeaponCategory.martialMelee => 'Воинское рукопашное оружие',
      WeaponCategory.martialRanged => 'Воинское дальнобойное оружие',
    };

String armorCategoryProficiencyLabel(ArmorCategory category) =>
    switch (category) {
      ArmorCategory.light => 'Лёгкие доспехи',
      ArmorCategory.medium => 'Средние доспехи',
      ArmorCategory.heavy => 'Тяжёлые доспехи',
      ArmorCategory.shield => 'Щиты',
    };
