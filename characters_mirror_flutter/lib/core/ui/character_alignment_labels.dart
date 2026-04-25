import 'package:characters_mirror_client/characters_mirror_client.dart';

String characterAlignmentLabel(CharacterAlignment value) {
  switch (value) {
    case CharacterAlignment.lawfulGood:
      return 'П-Д';
    case CharacterAlignment.neutralGood:
      return 'Добрый';
    case CharacterAlignment.chaoticGood:
      return 'Х-Д';
    case CharacterAlignment.lawfulNeutral:
      return 'Принципиальный';
    case CharacterAlignment.trueNeutral:
      return 'Нейтральный';
    case CharacterAlignment.chaoticNeutral:
      return 'Хаотичный';
    case CharacterAlignment.lawfulEvil:
      return 'П-З';
    case CharacterAlignment.neutralEvil:
      return 'Злой';
    case CharacterAlignment.chaoticEvil:
      return 'Х-З';
    case CharacterAlignment.unaligned:
      return 'Без мировоззрения';
  }
}
