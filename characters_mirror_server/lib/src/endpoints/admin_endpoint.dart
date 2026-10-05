import 'dart:convert';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('admin')};

  Future<List<UserInfo>> getAllUsers(Session session) async {
    return await UserInfo.db.find(session);
  }

  Future<void> setAdminRole(Session session, int userId, bool isAdmin) async {
    if (isAdmin) {
      await Users.updateUserScopes(session, userId, {Scope('admin')});
    } else {
      await Users.updateUserScopes(session, userId, <Scope>{});
    }
  }

  /// Imports declarative choice options by stable group and option keys.
  /// Existing rows are replaced by key; omitted requirements are preserved.
  Future<int> importChoiceOptions(Session session, String json) async {
    final decoded = jsonDecode(json);
    if (decoded is! Map<String, dynamic> || decoded['options'] is! List) {
      throw ArgumentError('Expected an object with an options array.');
    }
    return session.db.transaction((transaction) async {
      var imported = 0;
      for (final raw in decoded['options'] as List) {
        if (raw is! Map<String, dynamic>) {
          throw ArgumentError('Each option must be an object.');
        }
        final groupKey = raw['groupKey'];
        if (groupKey is! String || groupKey.trim().isEmpty) {
          throw ArgumentError('Each option requires a groupKey.');
        }
        final optionJson = raw['option'] is Map<String, dynamic>
            ? Map<String, dynamic>.from(raw['option'] as Map<String, dynamic>)
            : Map<String, dynamic>.from(raw)
          ..remove('groupKey')
          ..remove('requirements');
        final group = await ChoiceGroupData.db.findFirstRow(
          session,
          where: (t) => t.referenceKey.equals(groupKey.trim()),
          transaction: transaction,
        );
        if (group?.id == null) {
          throw ArgumentError('Unknown choice group key "$groupKey".');
        }
        final requirements = raw['requirements'];
        if (requirements != null) {
          if (requirements is! List) {
            throw ArgumentError('requirements must be an array.');
          }
          for (final requirement in requirements) {
            _validateChoiceRequirement(requirement);
          }
        }
        final option = ChoiceOptionData.fromJson({
          ...optionJson,
          'choiceGroupId': group!.id,
          'choiceGroup': null,
          if (requirements != null) 'requirements': requirements,
        });
        if (option.optionKey.trim().isEmpty) {
          throw ArgumentError('option.optionKey must not be empty.');
        }
        final existing = await ChoiceOptionData.db.findFirstRow(
          session,
          where: (t) =>
              t.choiceGroupId.equals(group.id!) &
              t.optionKey.equals(option.optionKey),
          transaction: transaction,
        );
        if (existing == null) {
          await ChoiceOptionData.db.insertRow(
            session,
            option,
            transaction: transaction,
          );
        } else {
          await ChoiceOptionData.db.updateRow(
              session,
              option.copyWith(
                id: existing.id,
                requirements: raw.containsKey('requirements')
                    ? option.requirements
                    : existing.requirements,
              ),
              transaction: transaction);
        }
        imported++;
      }
      return imported;
    });
  }

  /// Imports data-driven modifiers by stable feature and modifier keys.
  Future<int> importFeatureModifiers(Session session, String json) async {
    final decoded = jsonDecode(json);
    if (decoded is! Map<String, dynamic> || decoded['modifiers'] is! List) {
      throw ArgumentError('Expected an object with a modifiers array.');
    }
    return session.db.transaction((transaction) async {
      var imported = 0;
      for (final raw in decoded['modifiers'] as List) {
        if (raw is! Map<String, dynamic>) {
          throw ArgumentError('Each modifier must be an object.');
        }
        final referenceKey = raw['referenceKey'];
        final sourceFeatureKey = raw['sourceFeatureKey'];
        if (referenceKey is! String ||
            referenceKey.trim().isEmpty ||
            sourceFeatureKey is! String ||
            sourceFeatureKey.trim().isEmpty) {
          throw ArgumentError(
            'Each modifier requires referenceKey and sourceFeatureKey.',
          );
        }
        final classFeatures = await ClassFeatureData.db.find(
          session,
          where: (t) => t.referenceKey.equals(sourceFeatureKey),
          transaction: transaction,
        );
        final subclassFeatures = await SubclassFeatureData.db.find(
          session,
          where: (t) => t.referenceKey.equals(sourceFeatureKey),
          transaction: transaction,
        );
        if (classFeatures.length + subclassFeatures.length != 1) {
          throw ArgumentError(
            'sourceFeatureKey "$sourceFeatureKey" must resolve to exactly one feature.',
          );
        }
        final target = _featureModifierEnum<FeatureModifierTarget>(
          raw['target'],
          FeatureModifierTarget.values,
          'target',
        );
        final operation = _featureModifierEnum<FeatureModifierOperation>(
          raw['operation'],
          FeatureModifierOperation.values,
          'operation',
        );
        final value = _parseFeatureModifierValue(raw['value']);
        final conditions = _parseFeatureModifierConditions(raw['conditions']);
        final modifier = FeatureModifierData(
          referenceKey: referenceKey.trim(),
          classFeatureId: classFeatures.firstOrNull?.id,
          subclassFeatureId: subclassFeatures.firstOrNull?.id,
          target: target,
          operation: operation,
          value: value,
          conditions: conditions,
          source: raw['source'] as String?,
          version: raw['version'] as int?,
          createdAt: DateTime.now().toUtc(),
          updatedAt: DateTime.now().toUtc(),
        );
        final existing = await FeatureModifierData.db.findFirstRow(
          session,
          where: (t) => t.referenceKey.equals(referenceKey.trim()),
          transaction: transaction,
        );
        if (existing == null) {
          await FeatureModifierData.db.insertRow(
            session,
            modifier,
            transaction: transaction,
          );
        } else {
          await FeatureModifierData.db.updateRow(
            session,
            modifier.copyWith(id: existing.id),
            transaction: transaction,
          );
        }
        imported++;
      }
      return imported;
    });
  }

  T _featureModifierEnum<T extends Enum>(
    Object? raw,
    List<T> values,
    String field,
  ) {
    if (raw is! String) throw ArgumentError('$field must be a string.');
    for (final value in values) {
      if (value.name == raw) return value;
    }
    throw ArgumentError('Unknown $field "$raw".');
  }

  FeatureModifierValueData _parseFeatureModifierValue(Object? raw) {
    if (raw is! Map<String, dynamic>) {
      throw ArgumentError('value must be an object.');
    }
    final kind = _featureModifierEnum<FeatureModifierValueKind>(
      raw['kind'],
      FeatureModifierValueKind.values,
      'value.kind',
    );
    Map<int, int>? progression;
    if (raw['progression'] != null) {
      final rawProgression = raw['progression'];
      if (rawProgression is! Map) {
        throw ArgumentError('value.progression must be an object.');
      }
      progression = {};
      for (final entry in rawProgression.entries) {
        final level = int.tryParse(entry.key.toString());
        if (level == null || level < 1 || entry.value is! int) {
          throw ArgumentError(
              'value.progression must map positive levels to integers.');
        }
        progression[level] = entry.value as int;
      }
    }
    final rounding = raw['rounding'] == null
        ? null
        : _featureModifierEnum<FeatureModifierRounding>(
            raw['rounding'],
            FeatureModifierRounding.values,
            'value.rounding',
          );
    final value = FeatureModifierValueData(
      kind: kind,
      staticValue: raw['staticValue'] as int?,
      progression: progression,
      numerator: raw['numerator'] as int?,
      denominator: raw['denominator'] as int?,
      rounding: rounding,
    );
    final valid = switch (kind) {
      FeatureModifierValueKind.staticValue => value.staticValue != null,
      FeatureModifierValueKind.classLevelProgression =>
        value.progression?.isNotEmpty == true,
      FeatureModifierValueKind.proficiencyBonusFraction =>
        value.numerator != null &&
            value.numerator! >= 0 &&
            value.denominator != null &&
            value.denominator! > 0 &&
            value.rounding != null,
    };
    if (!valid) throw ArgumentError('value fields do not match kind "$kind".');
    return value;
  }

  List<FeatureModifierConditionData> _parseFeatureModifierConditions(
    Object? raw,
  ) {
    if (raw == null) return const [];
    if (raw is! List) throw ArgumentError('conditions must be an array.');
    return [
      for (final condition in raw)
        if (condition is Map<String, dynamic>)
          FeatureModifierConditionData(
            type: _featureModifierEnum<FeatureModifierConditionType>(
              condition['type'],
              FeatureModifierConditionType.values,
              'condition.type',
            ),
          )
        else
          throw ArgumentError('Each condition must be an object.'),
    ];
  }

  void _validateChoiceRequirement(Object? raw) {
    if (raw is! Map<String, dynamic> || raw['type'] is! String) {
      throw ArgumentError('Each requirement must include a type.');
    }
    final type = ChoiceRequirementType.fromJson(raw['type'] as String);
    final valid = switch (type) {
      ChoiceRequirementType.minimumClassLevel =>
        raw['classKey'] is String && _validLevel(raw['value']),
      ChoiceRequirementType.minimumCharacterLevel => _validLevel(raw['value']),
      ChoiceRequirementType.abilityScore =>
        raw['ability'] is String && _validLevel(raw['value']),
      ChoiceRequirementType.knownSpell ||
      ChoiceRequirementType.knownCantrip ||
      ChoiceRequirementType.feature =>
        raw['referenceKey'] is String &&
            (raw['referenceKey'] as String).trim().isNotEmpty,
      ChoiceRequirementType.selectedChoiceOption =>
        raw['choiceGroupKey'] is String &&
            raw['optionKey'] is String &&
            (raw['choiceGroupKey'] as String).trim().isNotEmpty &&
            (raw['optionKey'] as String).trim().isNotEmpty,
    };
    if (!valid) {
      throw ArgumentError('Requirement "$type" has invalid or missing fields.');
    }
  }

  bool _validLevel(Object? raw) => raw is int && raw >= 1 && raw <= 30;
}
