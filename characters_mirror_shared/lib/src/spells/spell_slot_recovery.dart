import 'spell_cast_context.dart';
import 'spell_activation.dart';
import 'spell_protocol_values.dart';

List<String> spellSlotRecoveryEventTargetKeys(Map<String, dynamic> character) =>
    characterSpellSlotRecoverySources(character).isNotEmpty ||
            spellSlotRecoveryTriggers(character).isNotEmpty
        ? ['field:spellRecoveryTriggers']
        : [];

class SpellSlotRecoverySource {
  const SpellSlotRecoverySource(
      {required this.sourceType,
      required this.sourceId,
      required this.effectId,
      required this.sourceLevel,
      required this.name,
      required this.trigger,
      required this.slotSource,
      required this.policy,
      required this.resources});
  final String sourceType;
  final int sourceId;
  final int effectId;
  final int sourceLevel;
  final String name;
  final String trigger;
  final SpellSlotSource slotSource;
  final Map<String, dynamic> policy;
  final List<Map> resources;
  String get key => '$sourceType:$sourceId:$effectId';
  String get mode => policy['mode'] as String;
  String? get resourceKey => policy['resourceKey'] as String?;
  int? get budget {
    final table = spellProtocolIntMap<int>(policy['levelBudgetBySourceLevel']);
    final levels = table.keys.where((level) => level <= sourceLevel).toList()
      ..sort();
    return levels.isEmpty ? null : table[levels.last];
  }
}

List<SpellSlotRecoverySource> characterSpellSlotRecoverySources(
    Map<String, dynamic> character) {
  final result = <SpellSlotRecoverySource>[];
  for (final feature
      in ((character['derived'] as Map?)?['activeFeatures'] as List? ?? [])
          .cast<Map>()) {
    for (final effect
        in (feature['spellSlotRecoveryEffects'] as List? ?? []).cast<Map>()) {
      final policy = effect['recoveryPolicy'] as Map?;
      final target = effect['targetType'];
      if (effect['type'] != 'restore' ||
          policy == null ||
          effect['id'] is! int ||
          (target != 'spellSlots' && target != 'pactSlots')) continue;
      result.add(SpellSlotRecoverySource(
        sourceType: feature['sourceType'] as String,
        sourceId: feature['sourceId'] as int,
        effectId: effect['id'] as int,
        sourceLevel: feature['sourceClassLevel'] as int? ?? 0,
        name: feature['name'] as String? ?? '',
        trigger: effect['activationTrigger'] as String? ?? 'manual',
        slotSource: target == 'pactSlots'
            ? SpellSlotSource.pact
            : SpellSlotSource.standard,
        policy: policy.cast<String, dynamic>(),
        resources: (feature['resources'] as List? ?? []).cast<Map>(),
      ));
    }
  }
  return result;
}

Map<String, Map<String, dynamic>> spellSlotRecoveryTriggers(
        Map<String, dynamic> character) =>
    spellProtocolStringMap<dynamic>(character['spellRecoveryTriggers']).map(
        (key, value) => MapEntry(key, (value as Map).cast<String, dynamic>()));

Map<int, int> spellSlotRecoveryOptions(
    Map<String, dynamic> character, SpellSlotRecoverySource source) {
  final key = source.resourceKey;
  if (key != null && _resourceCurrent(character, source) <= 0) return {};
  final trigger = spellSlotRecoveryTriggers(character)[source.key];
  if (source.trigger != 'manual' &&
      (trigger == null || trigger['trigger'] != source.trigger)) return {};
  var maximumLevel = source.policy['maximumSlotLevel'] as int? ?? 9;
  if (source.mode == 'singleLowerLevel') {
    final castLevel = trigger?['castLevel'] as int? ?? 0;
    maximumLevel = maximumLevel < castLevel - 1 ? maximumLevel : castLevel - 1;
  }
  final pools = SpellSlotPools.fromCharacter(character);
  return {
    for (var level = 1; level <= maximumLevel && level <= 9; level++)
      if (pools.maximum(source.slotSource, level) >
              pools.available(source.slotSource, level) &&
          (source.mode != 'levelBudget' || level <= (source.budget ?? 0)))
        level: pools.maximum(source.slotSource, level) -
            pools.available(source.slotSource, level),
  };
}

Map<String, dynamic> applySpellSlotRecovery(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  final source = characterSpellSlotRecoverySources(character)
      .where((source) =>
          source.sourceType == action['sourceType'] &&
          source.sourceId == action['sourceId'] &&
          source.effectId == action['recoveryEffectId'])
      .firstOrNull;
  if (source == null)
    throw const SpellCastFailure(
        'target_not_found', 'Recovery source is unavailable.');
  if (action['slotSource'] != source.slotSource.name ||
      action['resourceKey'] != source.resourceKey) {
    throw const SpellCastFailure('invalid_action',
        'Recovery pool or resource does not match its policy.');
  }
  final triggers = spellSlotRecoveryTriggers(character);
  final trigger = triggers[source.key];
  if (source.trigger != 'manual' &&
      (trigger == null ||
          trigger['trigger'] != source.trigger ||
          trigger['sourceActionId'] != action['recoveryTriggerId'])) {
    throw const SpellCastFailure(
        'invalid_trigger', 'Recovery requires a completed triggering action.');
  }
  final options = spellSlotRecoveryOptions(character, source);
  var selected = spellProtocolIntMap<int>(action['slotsToRestore']);
  if (source.mode == 'all') {
    if (selected.isNotEmpty)
      throw const SpellCastFailure(
          'invalid_action', 'Full recovery does not accept a selection.');
    selected = options;
  }
  if (selected.isEmpty ||
      selected.entries.any((entry) =>
          entry.value <= 0 || entry.value > (options[entry.key] ?? 0))) {
    throw const SpellCastFailure('resource_bounds',
        'Recovery selection exceeds the spent slots or policy limits.');
  }
  final cost = selected.entries
      .fold<int>(0, (sum, entry) => sum + entry.key * entry.value);
  switch (source.mode) {
    case 'levelBudget':
      if (source.budget == null || cost > source.budget!) {
        throw const SpellCastFailure(
            'resource_bounds', 'Recovery exceeds its source-level budget.');
      }
    case 'singleLowerLevel':
      if (selected.values.fold<int>(0, (sum, count) => sum + count) != 1 ||
          (trigger?['castLevel'] as int? ?? 0) <
              (source.policy['minimumCastLevel'] as int? ?? 2)) {
        throw const SpellCastFailure('invalid_action',
            'Recovery requires one lower-level slot after a qualifying cast.');
      }
    case 'all':
      break;
    default:
      throw const SpellCastFailure(
          'invalid_action', 'Unsupported recovery policy.');
  }
  var updated = {...character};
  for (final entry in selected.entries) {
    updated.addAll(SpellSlotPools.fromCharacter(updated)
        .adjusted(source.slotSource, entry.key, entry.value));
  }
  final states =
      (character['resourceStates'] as List? ?? []).cast<Map>().toList();
  if (source.resourceKey != null) {
    final current = _resourceCurrent(character, source);
    if (current <= 0)
      throw const SpellCastFailure(
          'insufficient_resource', 'Recovery resource is exhausted.');
    states.removeWhere((state) =>
        state['sourceType'] == source.sourceType &&
        state['sourceId'] == source.sourceId &&
        state['resourceKey'] == source.resourceKey);
    states.add({
      'sourceType': source.sourceType,
      'sourceId': source.sourceId,
      'resourceKey': source.resourceKey,
      'current': current - 1
    });
  }
  triggers.remove(source.key);
  return {
    'currentSpellSlots': updated['currentSpellSlots'],
    'currentPactSlots': updated['currentPactSlots'],
    'resourceStates': states,
    'spellRecoveryTriggers': triggers.isEmpty ? null : triggers,
  };
}

int _resourceCurrent(
    Map<String, dynamic> character, SpellSlotRecoverySource source) {
  final resource = source.resources
      .where((resource) => resource['key'] == source.resourceKey)
      .firstOrNull;
  if (resource == null || resource['isUnlimited'] == true) return 0;
  final state = (character['resourceStates'] as List? ?? [])
      .cast<Map>()
      .where((state) =>
          state['sourceType'] == source.sourceType &&
          state['sourceId'] == source.sourceId &&
          state['resourceKey'] == source.resourceKey)
      .firstOrNull;
  // An absent state represents a full resource, including after rest replay.
  return (state?['current'] as int? ?? resource['max'] as int? ?? 0)
      .clamp(0, resource['max'] as int? ?? 0);
}

Map<String, dynamic> spellSlotRecoveryEventPatch(Map<String, dynamic> character,
    {required String event,
    required String sourceActionId,
    Map<String, dynamic>? castAction}) {
  final sources = characterSpellSlotRecoverySources(character);
  final active = sources.map((source) => source.key).toSet();
  final triggers = spellSlotRecoveryTriggers(character)
    ..removeWhere((key, value) =>
        !active.contains(key) ||
        event == 'longRest' ||
        ((event == 'spellCast' || event == 'dawn') &&
            value['trigger'] == 'shortRest') ||
        (event == 'spellCast' && value['trigger'] == 'spellCast'));
  for (final source in sources.where((source) => source.trigger == event)) {
    int? castLevel;
    if (event == 'spellCast') {
      castLevel = castAction?['level'] as int?;
      final spell =
          ((character['derived'] as Map?)?['resolvedSpells'] as List? ?? [])
              .cast<Map>()
              .where((entry) => entry['spellKey'] == castAction?['spellKey'])
              .firstOrNull?['spell'] as Map?;
      if (castLevel == null ||
          castLevel < (source.policy['minimumCastLevel'] as int? ?? 0) ||
          castAction?['slotSource'] == 'none' ||
          spell == null ||
          (source.policy['spellSchool'] != null &&
              spell['schoolValue'] != source.policy['spellSchool'])) continue;
    }
    triggers[source.key] = {
      'sourceActionId': sourceActionId,
      'trigger': event,
      if (castLevel != null) 'castLevel': castLevel
    };
  }
  return {
    'spellRecoveryTriggers': triggers.isEmpty ? null : triggers,
    if (event != 'spellCast') ...spellActivationRestPatch(character, event),
  };
}

List<String> spellSlotRecoveryActionTargetKeys(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  final source = characterSpellSlotRecoverySources(character)
      .where((source) =>
          source.sourceType == action['sourceType'] &&
          source.sourceId == action['sourceId'] &&
          source.effectId == action['recoveryEffectId'])
      .firstOrNull;
  if (source == null) return ['field:spellRecoveryTriggers'];
  final levels = source.mode == 'all'
      ? spellSlotRecoveryOptions(character, source).keys
      : spellProtocolIntMap<int>(action['slotsToRestore']).keys;
  return [
    'field:spellRecoveryTriggers',
    for (final level in levels)
      ...spellSlotActionTargetKeys(
          character, {'slotSource': source.slotSource.name, 'level': level}),
    if (source.resourceKey != null)
      'resource:${source.sourceType}:${source.sourceId}:${source.resourceKey}',
  ].toSet().toList()
    ..sort();
}
