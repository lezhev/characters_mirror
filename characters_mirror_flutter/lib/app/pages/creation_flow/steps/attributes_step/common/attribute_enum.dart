enum Attribute {
  strength,
  dexterity,
  constitution,
  intelligence,
  wisdom,
  charisma,
}

extension AttributeExtension on Attribute {
  String getTitle() {
    switch (this) {
      case Attribute.strength:
        return 'Сила';
      case Attribute.dexterity:
        return 'Ловкость';
      case Attribute.constitution:
        return 'Телосложение';
      case Attribute.intelligence:
        return 'Интеллект';
      case Attribute.wisdom:
        return 'Мудрость';
      case Attribute.charisma:
        return 'Харизма';
    }
  }
}
