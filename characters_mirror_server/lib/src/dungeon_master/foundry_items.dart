import 'foundry_description.dart';
import 'foundry_json_reader.dart';

FoundryJson foundryItem(FoundryJson item, int index, FoundryJsonReader reader) {
  final path = 'items[$index]';
  final system = reader.object(item['system'], '$path.system');
  final activation = reader.object(system['activation'], '$path.activation');
  final damage = reader.object(system['damage'], '$path.damage');
  final save = reader.object(system['save'], '$path.save');
  final attack = reader.object(system['attack'], '$path.attack');
  final type = reader.text(item['type'], '$path.type') ?? 'unknown';
  if (!{'weapon', 'feat', 'spell', 'equipment', 'consumable'}.contains(type)) {
    reader.diagnostics
        .add('$path: неизвестный тип предмета $type; данные сохранены.');
  }
  final description = reader.text(
      reader.object(system['description'], '$path.description')['value'],
      '$path.description.value',
      long: true);
  final formula = reader.text(system['formula'], '$path.formula');
  final parts = damage['parts'];
  if (parts != null &&
      (parts is! List ||
          parts.any((part) =>
              part is! List || part.length < 2 || part[0] is! String))) {
    reader.diagnostics.add(
        '$path.damage.parts: неизвестный формат урона; исходные значения сохранены.');
  }
  // Formulas are data, including @mod and @item.level, never executable code.
  return {
    'sourceItemId': reader.text(item['_id'], '$path._id'),
    'name': reader.text(item['name'], '$path.name') ?? 'Без названия',
    'itemType': type,
    'activationType': reader.text(activation['type'], '$path.activation.type'),
    'activationCost': activation['cost'],
    'activationCondition':
        reader.text(activation['condition'], '$path.activation.condition'),
    'description': foundryDescriptionText(description ?? ''),
    'damageParts': parts ?? <Object?>[],
    'versatileDamage':
        reader.text(damage['versatile'], '$path.damage.versatile'),
    'formula': formula,
    'attackBonus': system['attackBonus'] ?? attack['bonus'],
    if (system['attack'] != null) 'attackSettings': attack,
    'attackAbility': system['ability'],
    'actionType': system['actionType'],
    'saveAbility': reader.text(save['ability'], '$path.save.ability'),
    'saveDc': reader.nonNegative(save['dc'], '$path.save.dc'),
    'saveScaling': save['scaling'],
    'range': reader.object(system['range'], '$path.range'),
    'target': reader.object(system['target'], '$path.target'),
    'uses': reader.object(system['uses'], '$path.uses'),
    'recharge': reader.object(system['recharge'], '$path.recharge'),
    'consume': reader.object(system['consume'], '$path.consume'),
    'spellLevel': reader.nonNegative(system['level'], '$path.level'),
    'spellProperties': type == 'spell'
        ? {
            for (final key in [
              'school',
              'components',
              'materials',
              'preparation',
              'scaling',
              'duration',
              'source'
            ])
              if (system.containsKey(key)) key: system[key],
          }
        : null,
    'equipmentProperties': {
      'equipped': system['equipped'],
      'armor': system['armor'],
      'properties': system['properties'],
      'quantity': system['quantity']
    },
    'sourceSystem': system,
    'effects': item['effects'],
  };
}
