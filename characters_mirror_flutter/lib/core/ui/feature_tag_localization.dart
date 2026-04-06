import 'package:characters_mirror_client/characters_mirror_client.dart';

String featureTagRuLabel(FeatureTag tag) {
  switch (tag) {
    case FeatureTag.action:
      return 'Действие';
    case FeatureTag.bonusAction:
      return 'Бонусное действие';
    case FeatureTag.reaction:
      return 'Реакция';
    case FeatureTag.passive:
      return 'Пассивная';
    case FeatureTag.resource:
      return 'Ресурс';
    case FeatureTag.spellcasting:
      return 'Заклинания';
    case FeatureTag.defense:
      return 'Защита';
    case FeatureTag.mobility:
      return 'Подвижность';
    case FeatureTag.utility:
      return 'Утилита';
    case FeatureTag.social:
      return 'Социальная';
    case FeatureTag.exploration:
      return 'Исследование';
    case FeatureTag.combat:
      return 'Боевая';
  }
}
