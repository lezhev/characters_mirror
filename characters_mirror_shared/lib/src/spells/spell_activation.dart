import 'spell_source_context.dart';
import 'spell_cast_context.dart';
import 'spell_activation_validation.dart';

/// Explicit grant policy. Absent policies retain the original class-slot rules.
Map<String, dynamic> spellActivationPolicy(SpellSourceContext source) {
  if (source.activation != null) {
    validateSpellActivation(source.activation!);
    return source.activation!;
  }
  final free = int.tryParse(source.freeCastsFormula ?? '');
  return {
    'canUseStandardSlots': source.canUseSlots,
    'canUsePactSlots': source.canUseSlots,
    'slotless': free != null,
    'freeCasts': free,
    'resetOn': source.freeCastsPerRest,
    'castAtSpellLevel': source.castAtSpellLevel,
  };
}

List<Map<String, dynamic>> _features(Map<String, dynamic> character) =>
    ((character['derived'] as Map?)?['activeFeatures'] as List? ?? [])
        .whereType<Map>()
        .map((r) => r.cast<String, dynamic>())
        .toList();

int spellActivationResourceAvailable(
    Map<String, dynamic> character, SpellSourceContext source) {
  final policy = spellActivationPolicy(source);
  final resource = _features(character)
      .where((f) =>
          f['sourceType'] == source.resourceSourceType &&
          f['sourceId'] == source.resourceSourceId)
      .expand((f) => f['resources'] as List? ?? [])
      .whereType<Map>()
      .where((r) => r['key'] == policy['resourceKey'])
      .firstOrNull;
  if (resource == null) return 0;
  if (resource['isUnlimited'] == true) return 2147483647;
  final maximum = resource['max'] as int? ?? 0;
  final state = (character['resourceStates'] as List? ?? [])
      .whereType<Map>()
      .where((s) =>
          s['sourceType'] == source.resourceSourceType &&
          s['sourceId'] == source.resourceSourceId &&
          s['resourceKey'] == policy['resourceKey'])
      .firstOrNull;
  return (state?['current'] as int? ?? maximum).clamp(0, maximum);
}

Map<String, dynamic> spellActivationPaymentPatch(
    Map<String, dynamic> character, SpellCastContext cast) {
  final policy = spellActivationPolicy(cast.source);
  if (cast.payment == 'free') {
    final uses = Map<String, dynamic>.from(
        character['spellActivationUses'] as Map? ?? {});
    uses[cast.source.sourceKey] =
        (uses[cast.source.sourceKey] as int? ?? 0) + 1;
    return {'spellActivationUses': uses};
  }
  if (cast.payment != 'resource') return {};
  final states = [
    for (final row in character['resourceStates'] as List? ?? [])
      Map<String, dynamic>.from(row as Map)
  ];
  final index = states.indexWhere((s) =>
      s['sourceType'] == cast.source.resourceSourceType &&
      s['sourceId'] == cast.source.resourceSourceId &&
      s['resourceKey'] == policy['resourceKey']);
  final state = <String, dynamic>{
    'sourceType': cast.source.resourceSourceType,
    'sourceId': cast.source.resourceSourceId,
    'resourceKey': policy['resourceKey'],
    'current': spellActivationResourceAvailable(character, cast.source) -
        (cast.resourceCost ?? policy['resourceCost'] as int),
  };
  // Unlimited resources do not materialize a finite counter.
  if (spellActivationResourceAvailable(character, cast.source) == 2147483647)
    return {};
  if (index < 0) {
    states.add(state);
  } else {
    states[index] = state;
  }
  return {'resourceStates': states};
}

Map<String, dynamic> spellActivationCastLimitPatch(
    Map<String, dynamic> character, SpellCastContext cast) {
  final policy = spellActivationPolicy(cast.source);
  if (policy['maxCasts'] == null) return {};
  final uses =
      Map<String, dynamic>.from(character['spellActivationUses'] as Map? ?? {});
  final key = spellActivationCastLimitCounterKey(cast.source.sourceKey);
  uses[key] = (uses[key] as int? ?? 0) + 1;
  return {'spellActivationUses': uses};
}

Map<String, dynamic> spellActivationRestPatch(
    Map<String, dynamic> character, String restType) {
  final uses =
      Map<String, dynamic>.from(character['spellActivationUses'] as Map? ?? {});
  var changed = false;
  for (final entry
      in (character['derived'] as Map?)?['resolvedSpells'] as List? ?? []) {
    for (final json in (entry as Map)['sources'] as List? ?? []) {
      final source =
          SpellSourceContext.fromJson(Map<String, dynamic>.from(json as Map));
      final reset = spellActivationPolicy(source)['resetOn'];
      if (reset == restType || restType == 'longRest' && reset == 'shortRest') {
        changed = uses.remove(source.sourceKey) != null || changed;
      }
      final policy = spellActivationPolicy(source);
      final castReset = policy['castsResetOn'];
      if (castReset == restType ||
          restType == 'longRest' && castReset == 'shortRest') {
        changed = uses.remove(
                  spellActivationCastLimitCounterKey(source.sourceKey),
                ) !=
                null ||
            changed;
      }
    }
  }
  return changed ? {'spellActivationUses': uses.isEmpty ? null : uses} : {};
}

List<String> spellActivationRestTargets(
    Map<String, dynamic> character, String restType) {
  final result = <String>{};
  for (final entry
      in (character['derived'] as Map?)?['resolvedSpells'] as List? ?? []) {
    for (final json in (entry as Map)['sources'] as List? ?? []) {
      final source =
          SpellSourceContext.fromJson(Map<String, dynamic>.from(json as Map));
      final policy = spellActivationPolicy(source);
      if (policy['resetOn'] == restType ||
          restType == 'longRest' && policy['resetOn'] == 'shortRest') {
        if ((policy['freeCasts'] as int? ?? 0) > 0) {
          result
              .add('map:spellActivationUses:${_targetPart(source.sourceKey)}');
        }
      }
      if (policy['castsResetOn'] == restType ||
          restType == 'longRest' && policy['castsResetOn'] == 'shortRest') {
        if (policy['maxCasts'] is int) {
          result.add(
              'map:spellActivationUses:${_targetPart(spellActivationCastLimitCounterKey(source.sourceKey))}');
        }
      }
    }
  }
  return result.toList()..sort();
}

List<String> spellActivationActionTargets(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  if (action['spellKey'] == null)
    return spellSlotActionTargetKeys(character, action);
  // Validation also proves the target comes from a canonical source.
  final patch = applySpellCast(character, action);
  final targets = spellSlotActionTargetKeys(character, action);
  if (patch.containsKey('spellActivationUses')) {
    final uses = patch['spellActivationUses'] as Map;
    for (final key in uses.keys) {
      final old = (character['spellActivationUses'] as Map?)?[key];
      if (old != uses[key]) {
        targets.add('map:spellActivationUses:${_targetPart('$key')}');
      }
    }
  }
  if (patch.containsKey('resourceStates')) {
    for (final state in patch['resourceStates'] as List) {
      final old = (character['resourceStates'] as List? ?? [])
          .whereType<Map>()
          .where((s) =>
              s['sourceType'] == state['sourceType'] &&
              s['sourceId'] == state['sourceId'] &&
              s['resourceKey'] == state['resourceKey'])
          .firstOrNull;
      if (old?['current'] != state['current']) {
        targets.add(
            'resource:${state['sourceType']}:${state['sourceId']}:${_targetPart(state['resourceKey'] as String)}');
      }
    }
  }
  return targets;
}

String _targetPart(String value) =>
    value.replaceAll('%', '%25').replaceAll(':', '%3A');
