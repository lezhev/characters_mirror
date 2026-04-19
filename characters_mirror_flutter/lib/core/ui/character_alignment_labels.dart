import 'package:characters_mirror_client/characters_mirror_client.dart';

String characterAlignmentLabel(CharacterAlignment value) {
  switch (value) {
    case CharacterAlignment.lawfulGood:
      return 'Законопослушный добрый';
    case CharacterAlignment.neutralGood:
      return 'Нейтральный добрый';
    case CharacterAlignment.chaoticGood:
      return 'Хаотичный добрый';
    case CharacterAlignment.lawfulNeutral:
      return 'Законопослушный нейтральный';
    case CharacterAlignment.trueNeutral:
      return 'Истинно нейтральный';
    case CharacterAlignment.chaoticNeutral:
      return 'Хаотичный нейтральный';
    case CharacterAlignment.lawfulEvil:
      return 'Законопослушный злой';
    case CharacterAlignment.neutralEvil:
      return 'Нейтральный злой';
    case CharacterAlignment.chaoticEvil:
      return 'Хаотичный злой';
    case CharacterAlignment.unaligned:
      return 'Без мировоззрения';
  }
}
