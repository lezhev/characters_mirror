import 'spell_cast_context.dart';

/// Validates an explicit policy; legacy grants retain their original contract.
void validateSpellActivation(Map<String, dynamic> policy) {
  Never reject(String message) =>
      throw SpellCastFailure('invalid_activation', message);

  for (final field in [
    'canUseStandardSlots',
    'canUsePactSlots',
    'slotless',
    'atWill'
  ]) {
    if (policy[field] is! bool) reject('$field must be a boolean.');
  }
  final slots = policy['canUseStandardSlots'] == true ||
      policy['canUsePactSlots'] == true;
  final slotless = policy['slotless'] == true;
  final atWill = policy['atWill'] == true;
  final key = policy['resourceKey'];
  final cost = policy['resourceCost'];
  final free = policy['freeCasts'];
  final reset = policy['resetOn'];
  final resource = key != null || cost != null;
  final counter = free != null || reset != null;
  final maxCasts = policy['maxCasts'];
  final castsResetOn = policy['castsResetOn'];
  final castLimit = maxCasts != null || castsResetOn != null;

  if (resource &&
      (key is! String || key.trim().isEmpty || cost is! int || cost <= 0)) {
    reject(
        'Resource payment requires a non-empty key and positive integer cost.');
  }
  if (counter &&
      (free is! int ||
          free <= 0 ||
          !const ['shortRest', 'longRest', 'dawn', 'special']
              .contains(reset))) {
    reject('Free casts require a positive integer limit and a valid reset.');
  }
  if (castLimit &&
      (maxCasts is! int ||
          maxCasts <= 0 ||
          !const ['shortRest', 'longRest', 'dawn', 'special']
              .contains(castsResetOn))) {
    reject('Cast limits require a positive integer limit and a valid reset.');
  }
  if (atWill && (resource || counter)) {
    reject(
        'At-will casting cannot also require a resource or free-cast counter.');
  }
  if (!slotless && (atWill || resource || counter)) {
    reject('Slotless payment fields require slotless casting.');
  }
  if (slotless && !atWill && !resource && !counter) {
    reject('Slotless casting requires a payment method or at-will permission.');
  }
  if (!slotless && !slots) reject('At least one casting method is required.');
  final level = policy['castAtSpellLevel'];
  if (level != null && (level is! int || level < 0 || level > 9)) {
    reject('Cast level must be an integer from zero through nine.');
  }
  final upcast = policy['resourceUpcastPolicy'];
  if (upcast != null) {
    if (upcast is! Map ||
        !slotless ||
        !resource ||
        atWill ||
        counter ||
        slots ||
        level != null) {
      reject('Resource upcasting requires resource-only slotless casting.');
    }
    final step = upcast['resourcePerAdditionalSpellLevel'];
    final progression = upcast['maxResourceCostBySourceLevel'];
    if (step is! int ||
        step <= 0 ||
        (progression is! Map && progression is! List)) {
      reject('Resource upcasting requires a positive step and level limits.');
    }
    final rows = <MapEntry<int, int>>[];
    final entries = progression is Map
        ? progression.entries
        : progression
            .whereType<Map>()
            .map((entry) => MapEntry(entry['k'], entry['v']));
    for (final entry in entries) {
      final sourceLevel = int.tryParse('${entry.key}');
      final maxCost = entry.value;
      if (sourceLevel == null ||
          sourceLevel < 1 ||
          sourceLevel > 20 ||
          maxCost is! int ||
          maxCost < (cost as int)) {
        reject('Resource upcast level limits are invalid.');
      }
      rows.add(MapEntry(sourceLevel, maxCost));
    }
    if (rows.isEmpty ||
        (progression is List && rows.length != progression.length)) {
      reject('Resource upcast level limits are invalid.');
    }
    rows.sort((a, b) => a.key.compareTo(b.key));
    if (!rows.any((row) => row.value > (cost as int))) {
      reject('Resource upcast limits must allow at least one higher level.');
    }
    for (var index = 1; index < rows.length; index++) {
      if (rows[index].value < rows[index - 1].value) {
        reject('Resource upcast limits must not decrease by source level.');
      }
    }
  }
}
