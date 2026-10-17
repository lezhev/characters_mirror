import 'dm_statblock_context.dart';
import 'dm_statblock_labels.dart';
import 'dm_statblock_models.dart';
import 'dm_statblock_values.dart';

bool dmMeaningfulBonus(Object? value) =>
    dmHasValue(value) && dmNumber(value) != 0;

List<DmStatLine> dmProficiencyLines(DmStatContext context) {
  final result = <DmStatLine>[];
  for (final entry in dmAbilityLabels.entries) {
    final ability = dmMap(context.creature.abilities[entry.key]);
    final extra = dmMap(ability['bonuses'])['save'];
    final check = dmMap(ability['bonuses'])['check'];
    if (dmMeaningfulBonus(check)) {
      result.add(
          DmStatLine('Проверки ${entry.value}: доп. бонус', dmText(check)));
    }
    if (dmMeaningfulBonus(ability['saveProficiency']) ||
        dmMeaningfulBonus(extra)) {
      final total = context.saveTotal(entry.key);
      result.add(DmStatLine('Спасбросок ${entry.value}', dmSigned(total)));
      if (dmMeaningfulBonus(extra) && total == null) {
        result.add(DmStatLine('Доп. бонус ${entry.value}', dmText(extra)));
      }
    }
  }
  final global = dmMap(context.global['abilities']);
  for (final entry in {
    'save': 'Все спасброски: доп. бонус',
    'check': 'Проверки: доп. бонус',
    'skill': 'Навыки: доп. бонус'
  }.entries) {
    if (dmMeaningfulBonus(global[entry.key])) {
      result.add(DmStatLine(entry.value, dmText(global[entry.key])));
    }
  }
  for (final entry in dmMap(context.creature.otherStats['skills']).entries) {
    final label = dmSkillLabels[entry.key];
    if (label == null) continue;
    final skill = dmMap(entry.value),
        bonuses = dmMap(dmMap(entry.value)['bonuses']);
    final check = bonuses['check'], passive = bonuses['passive'];
    final total = context.skillTotal(skill);
    final exported = dmNumber(skill['total']);
    final customTotal = dmMeaningfulBonus(skill['total']) &&
        exported != null &&
        exported != total;
    final totalFormula = dmMeaningfulBonus(skill['total']) && exported == null;
    final ability = dmText(skill['ability']);
    final specialAbility = dmAbilityLabels.containsKey(ability) &&
        _standardSkillAbilities[entry.key] != ability;
    if (!dmMeaningfulBonus(skill['value']) &&
        !dmMeaningfulBonus(check) &&
        !dmMeaningfulBonus(passive) &&
        !customTotal &&
        !totalFormula &&
        !specialAbility) {
      continue;
    }
    result.add(DmStatLine(
        label,
        dmSigned(totalFormula
            ? null
            : customTotal
                ? exported
                : total)));
    if (totalFormula) {
      result.add(DmStatLine('$label: особый итог', dmText(skill['total'])));
    }
    if (specialAbility) {
      result
          .add(DmStatLine('$label: характеристика', dmAbilityLabels[ability]!));
    }
    if (dmMeaningfulBonus(check) && total == null) {
      result.add(DmStatLine('$label: доп. бонус', dmText(check)));
    }
    if (dmMeaningfulBonus(passive)) {
      result.add(DmStatLine('$label: пассивный бонус', dmText(passive)));
    }
  }
  return result;
}

const _standardSkillAbilities = {
  'acr': 'dex',
  'ani': 'wis',
  'arc': 'int',
  'ath': 'str',
  'dec': 'cha',
  'his': 'int',
  'ins': 'wis',
  'itm': 'cha',
  'inv': 'int',
  'med': 'wis',
  'nat': 'int',
  'prc': 'wis',
  'prf': 'cha',
  'per': 'cha',
  'rel': 'int',
  'slt': 'dex',
  'ste': 'dex',
  'sur': 'wis'
};

/// Visual rows remain separate from the logical, individually named bonuses.
List<DmStatLine> dmCompactProficiencies(List<DmStatLine> lines) {
  final saves = <String>[], skills = <String>[], details = <DmStatLine>[];
  for (final line in lines) {
    if (line.label.startsWith('Спасбросок ')) {
      saves.add('${line.label.substring('Спасбросок '.length)} ${line.value}');
    } else if (dmSkillLabels.values.contains(line.label)) {
      skills.add('${line.label} ${line.value}');
    } else {
      details.add(line);
    }
  }
  return [
    if (saves.isNotEmpty) DmStatLine('Спасброски', saves.join(', ')),
    if (skills.isNotEmpty) DmStatLine('Навыки', skills.join(', ')),
    ...details
  ];
}
