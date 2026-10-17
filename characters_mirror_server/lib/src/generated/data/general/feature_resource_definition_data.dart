/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../data/general/choice_option_data.dart' as _iu6wj5qy;
import '../../data/general/class/class_feature_data.dart' as _inxbtq9c;
import '../../data/general/class/subclass_feature_data.dart' as _i6bcyp7i;
import '../../data/general/feature_resource_progression_value_data.dart'
    as _i40dz5tv;
import '../../data/general/race/race_feature_data.dart' as _iga2jap7;
import '../../enums/ability.dart' as _if5gaqs5;
import '../../enums/feature_resource_kind.dart' as _idk2deej;
import '../../enums/feature_resource_max_rule.dart' as _i8eknyg7;
import '../../enums/feature_resource_progression_key.dart' as _int4z9wn;
import '../../enums/feature_resource_trigger.dart' as _id68h68o;
import '../../enums/rest_type.dart' as _i67lztjp;

abstract class FeatureResourceDefinitionData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatureResourceDefinitionData._({
    this.id,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    this.raceFeatureId,
    this.raceFeature,
    required this.key,
    this.choiceOptionId,
    this.choiceOption,
    this.name,
    required this.kind,
    required this.maxRule,
    this.maxValue,
    this.maxAbility,
    this.resetOn,
    this.activationTrigger,
    this.usageResetOn,
    this.progressionKey,
    this.becomesUnlimitedAtLevel,
    this.progressionValues,
  });

  factory FeatureResourceDefinitionData({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    required _idk2deej.FeatureResourceKind kind,
    required _i8eknyg7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
  }) = _FeatureResourceDefinitionDataImpl;

  factory FeatureResourceDefinitionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureResourceDefinitionData(
      id: jsonSerialization['id'] as int?,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['classFeature'],
            ),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['subclassFeature'],
            ),
      raceFeatureId: jsonSerialization['raceFeatureId'] as int?,
      raceFeature: jsonSerialization['raceFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iga2jap7.RaceFeatureData>(
              jsonSerialization['raceFeature'],
            ),
      key: jsonSerialization['key'] as String,
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iu6wj5qy.ChoiceOptionData>(
              jsonSerialization['choiceOption'],
            ),
      name: jsonSerialization['name'] as String?,
      kind: _idk2deej.FeatureResourceKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      maxRule: _i8eknyg7.FeatureResourceMaxRule.fromJson(
        (jsonSerialization['maxRule'] as String),
      ),
      maxValue: jsonSerialization['maxValue'] as int?,
      maxAbility: jsonSerialization['maxAbility'] == null
          ? null
          : _if5gaqs5.Ability.fromJson(
              (jsonSerialization['maxAbility'] as String),
            ),
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i67lztjp.RestType.fromJson(
              (jsonSerialization['resetOn'] as String),
            ),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _id68h68o.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String),
            ),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i67lztjp.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String),
            ),
      progressionKey: jsonSerialization['progressionKey'] == null
          ? null
          : _int4z9wn.FeatureResourceProgressionKey.fromJson(
              (jsonSerialization['progressionKey'] as String),
            ),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
      progressionValues: jsonSerialization['progressionValues'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              List<_i40dz5tv.FeatureResourceProgressionValueData>
            >(jsonSerialization['progressionValues']),
    );
  }

  static final t = FeatureResourceDefinitionDataTable();

  static const db = FeatureResourceDefinitionDataRepository._();

  @override
  int? id;

  int? classFeatureId;

  _inxbtq9c.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? subclassFeature;

  int? raceFeatureId;

  _iga2jap7.RaceFeatureData? raceFeature;

  String key;

  int? choiceOptionId;

  _iu6wj5qy.ChoiceOptionData? choiceOption;

  String? name;

  _idk2deej.FeatureResourceKind kind;

  _i8eknyg7.FeatureResourceMaxRule maxRule;

  int? maxValue;

  _if5gaqs5.Ability? maxAbility;

  _i67lztjp.RestType? resetOn;

  _id68h68o.FeatureResourceTrigger? activationTrigger;

  _i67lztjp.RestType? usageResetOn;

  _int4z9wn.FeatureResourceProgressionKey? progressionKey;

  int? becomesUnlimitedAtLevel;

  List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureResourceDefinitionData copyWith({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    String? key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    _idk2deej.FeatureResourceKind? kind,
    _i8eknyg7.FeatureResourceMaxRule? maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureResourceDefinitionData',
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJson(),
      'key': key,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null) 'choiceOption': choiceOption?.toJson(),
      if (name != null) 'name': name,
      'kind': kind.toJson(),
      'maxRule': maxRule.toJson(),
      if (maxValue != null) 'maxValue': maxValue,
      if (maxAbility != null) 'maxAbility': maxAbility?.toJson(),
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (progressionKey != null) 'progressionKey': progressionKey?.toJson(),
      if (becomesUnlimitedAtLevel != null)
        'becomesUnlimitedAtLevel': becomesUnlimitedAtLevel,
      if (progressionValues != null)
        'progressionValues': progressionValues?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureResourceDefinitionData',
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJsonForProtocol(),
      'key': key,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null)
        'choiceOption': choiceOption?.toJsonForProtocol(),
      if (name != null) 'name': name,
      'kind': kind.toJson(),
      'maxRule': maxRule.toJson(),
      if (maxValue != null) 'maxValue': maxValue,
      if (maxAbility != null) 'maxAbility': maxAbility?.toJson(),
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (progressionKey != null) 'progressionKey': progressionKey?.toJson(),
      if (becomesUnlimitedAtLevel != null)
        'becomesUnlimitedAtLevel': becomesUnlimitedAtLevel,
      if (progressionValues != null)
        'progressionValues': progressionValues?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static FeatureResourceDefinitionDataInclude include({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
    _iga2jap7.RaceFeatureDataInclude? raceFeature,
    _iu6wj5qy.ChoiceOptionDataInclude? choiceOption,
    _i40dz5tv.FeatureResourceProgressionValueDataIncludeList? progressionValues,
  }) {
    return FeatureResourceDefinitionDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
      raceFeature: raceFeature,
      choiceOption: choiceOption,
      progressionValues: progressionValues,
    );
  }

  static FeatureResourceDefinitionDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    FeatureResourceDefinitionDataInclude? include,
  }) {
    return FeatureResourceDefinitionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceDefinitionDataImpl extends FeatureResourceDefinitionData {
  _FeatureResourceDefinitionDataImpl({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    required _idk2deej.FeatureResourceKind kind,
    required _i8eknyg7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
  }) : super._(
         id: id,
         classFeatureId: classFeatureId,
         classFeature: classFeature,
         subclassFeatureId: subclassFeatureId,
         subclassFeature: subclassFeature,
         raceFeatureId: raceFeatureId,
         raceFeature: raceFeature,
         key: key,
         choiceOptionId: choiceOptionId,
         choiceOption: choiceOption,
         name: name,
         kind: kind,
         maxRule: maxRule,
         maxValue: maxValue,
         maxAbility: maxAbility,
         resetOn: resetOn,
         activationTrigger: activationTrigger,
         usageResetOn: usageResetOn,
         progressionKey: progressionKey,
         becomesUnlimitedAtLevel: becomesUnlimitedAtLevel,
         progressionValues: progressionValues,
       );

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureResourceDefinitionData copyWith({
    Object? id = _Undefined,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? raceFeatureId = _Undefined,
    Object? raceFeature = _Undefined,
    String? key,
    Object? choiceOptionId = _Undefined,
    Object? choiceOption = _Undefined,
    Object? name = _Undefined,
    _idk2deej.FeatureResourceKind? kind,
    _i8eknyg7.FeatureResourceMaxRule? maxRule,
    Object? maxValue = _Undefined,
    Object? maxAbility = _Undefined,
    Object? resetOn = _Undefined,
    Object? activationTrigger = _Undefined,
    Object? usageResetOn = _Undefined,
    Object? progressionKey = _Undefined,
    Object? becomesUnlimitedAtLevel = _Undefined,
    Object? progressionValues = _Undefined,
  }) {
    return FeatureResourceDefinitionData(
      id: id is int? ? id : this.id,
      classFeatureId: classFeatureId is int?
          ? classFeatureId
          : this.classFeatureId,
      classFeature: classFeature is _inxbtq9c.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i6bcyp7i.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      raceFeatureId: raceFeatureId is int? ? raceFeatureId : this.raceFeatureId,
      raceFeature: raceFeature is _iga2jap7.RaceFeatureData?
          ? raceFeature
          : this.raceFeature?.copyWith(),
      key: key ?? this.key,
      choiceOptionId: choiceOptionId is int?
          ? choiceOptionId
          : this.choiceOptionId,
      choiceOption: choiceOption is _iu6wj5qy.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      name: name is String? ? name : this.name,
      kind: kind ?? this.kind,
      maxRule: maxRule ?? this.maxRule,
      maxValue: maxValue is int? ? maxValue : this.maxValue,
      maxAbility: maxAbility is _if5gaqs5.Ability?
          ? maxAbility
          : this.maxAbility,
      resetOn: resetOn is _i67lztjp.RestType? ? resetOn : this.resetOn,
      activationTrigger: activationTrigger is _id68h68o.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn: usageResetOn is _i67lztjp.RestType?
          ? usageResetOn
          : this.usageResetOn,
      progressionKey: progressionKey is _int4z9wn.FeatureResourceProgressionKey?
          ? progressionKey
          : this.progressionKey,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
      progressionValues:
          progressionValues
              is List<_i40dz5tv.FeatureResourceProgressionValueData>?
          ? progressionValues
          : this.progressionValues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class FeatureResourceDefinitionDataUpdateTable
    extends _is.UpdateTable<FeatureResourceDefinitionDataTable> {
  FeatureResourceDefinitionDataUpdateTable(super.table);

  _is.ColumnValue<int, int> classFeatureId(int? value) =>
      _is.ColumnValue(table.classFeatureId, value);

  _is.ColumnValue<int, int> subclassFeatureId(int? value) =>
      _is.ColumnValue(table.subclassFeatureId, value);

  _is.ColumnValue<int, int> raceFeatureId(int? value) =>
      _is.ColumnValue(table.raceFeatureId, value);

  _is.ColumnValue<String, String> key(String value) =>
      _is.ColumnValue(table.key, value);

  _is.ColumnValue<int, int> choiceOptionId(int? value) =>
      _is.ColumnValue(table.choiceOptionId, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<_idk2deej.FeatureResourceKind, _idk2deej.FeatureResourceKind>
  kind(_idk2deej.FeatureResourceKind value) =>
      _is.ColumnValue(table.kind, value);

  _is.ColumnValue<
    _i8eknyg7.FeatureResourceMaxRule,
    _i8eknyg7.FeatureResourceMaxRule
  >
  maxRule(_i8eknyg7.FeatureResourceMaxRule value) =>
      _is.ColumnValue(table.maxRule, value);

  _is.ColumnValue<int, int> maxValue(int? value) =>
      _is.ColumnValue(table.maxValue, value);

  _is.ColumnValue<_if5gaqs5.Ability, _if5gaqs5.Ability> maxAbility(
    _if5gaqs5.Ability? value,
  ) => _is.ColumnValue(table.maxAbility, value);

  _is.ColumnValue<_i67lztjp.RestType, _i67lztjp.RestType> resetOn(
    _i67lztjp.RestType? value,
  ) => _is.ColumnValue(table.resetOn, value);

  _is.ColumnValue<
    _id68h68o.FeatureResourceTrigger,
    _id68h68o.FeatureResourceTrigger
  >
  activationTrigger(_id68h68o.FeatureResourceTrigger? value) =>
      _is.ColumnValue(table.activationTrigger, value);

  _is.ColumnValue<_i67lztjp.RestType, _i67lztjp.RestType> usageResetOn(
    _i67lztjp.RestType? value,
  ) => _is.ColumnValue(table.usageResetOn, value);

  _is.ColumnValue<
    _int4z9wn.FeatureResourceProgressionKey,
    _int4z9wn.FeatureResourceProgressionKey
  >
  progressionKey(_int4z9wn.FeatureResourceProgressionKey? value) =>
      _is.ColumnValue(table.progressionKey, value);

  _is.ColumnValue<int, int> becomesUnlimitedAtLevel(int? value) =>
      _is.ColumnValue(table.becomesUnlimitedAtLevel, value);
}

class FeatureResourceDefinitionDataTable extends _is.Table<int?> {
  FeatureResourceDefinitionDataTable({super.tableRelation})
    : super(tableName: 'feature_resource_definition_data') {
    updateTable = FeatureResourceDefinitionDataUpdateTable(this);
    classFeatureId = _is.ColumnInt('classFeatureId', this);
    subclassFeatureId = _is.ColumnInt('subclassFeatureId', this);
    raceFeatureId = _is.ColumnInt('raceFeatureId', this);
    key = _is.ColumnString('key', this);
    choiceOptionId = _is.ColumnInt('choiceOptionId', this);
    name = _is.ColumnString('name', this);
    kind = _is.ColumnEnum('kind', this, _is.EnumSerialization.byName);
    maxRule = _is.ColumnEnum('maxRule', this, _is.EnumSerialization.byName);
    maxValue = _is.ColumnInt('maxValue', this);
    maxAbility = _is.ColumnEnum(
      'maxAbility',
      this,
      _is.EnumSerialization.byName,
    );
    resetOn = _is.ColumnEnum('resetOn', this, _is.EnumSerialization.byName);
    activationTrigger = _is.ColumnEnum(
      'activationTrigger',
      this,
      _is.EnumSerialization.byName,
    );
    usageResetOn = _is.ColumnEnum(
      'usageResetOn',
      this,
      _is.EnumSerialization.byName,
    );
    progressionKey = _is.ColumnEnum(
      'progressionKey',
      this,
      _is.EnumSerialization.byName,
    );
    becomesUnlimitedAtLevel = _is.ColumnInt('becomesUnlimitedAtLevel', this);
  }

  late final FeatureResourceDefinitionDataUpdateTable updateTable;

  late final _is.ColumnInt classFeatureId;

  _inxbtq9c.ClassFeatureDataTable? _classFeature;

  late final _is.ColumnInt subclassFeatureId;

  _i6bcyp7i.SubclassFeatureDataTable? _subclassFeature;

  late final _is.ColumnInt raceFeatureId;

  _iga2jap7.RaceFeatureDataTable? _raceFeature;

  late final _is.ColumnString key;

  late final _is.ColumnInt choiceOptionId;

  _iu6wj5qy.ChoiceOptionDataTable? _choiceOption;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_idk2deej.FeatureResourceKind> kind;

  late final _is.ColumnEnum<_i8eknyg7.FeatureResourceMaxRule> maxRule;

  late final _is.ColumnInt maxValue;

  late final _is.ColumnEnum<_if5gaqs5.Ability> maxAbility;

  late final _is.ColumnEnum<_i67lztjp.RestType> resetOn;

  late final _is.ColumnEnum<_id68h68o.FeatureResourceTrigger> activationTrigger;

  late final _is.ColumnEnum<_i67lztjp.RestType> usageResetOn;

  late final _is.ColumnEnum<_int4z9wn.FeatureResourceProgressionKey>
  progressionKey;

  late final _is.ColumnInt becomesUnlimitedAtLevel;

  _i40dz5tv.FeatureResourceProgressionValueDataTable? ___progressionValues;

  _is.ManyRelation<_i40dz5tv.FeatureResourceProgressionValueDataTable>?
  _progressionValues;

  _inxbtq9c.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _is.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureResourceDefinitionData.t.classFeatureId,
      foreignField: _inxbtq9c.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inxbtq9c.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _classFeature!;
  }

  _i6bcyp7i.SubclassFeatureDataTable get subclassFeature {
    if (_subclassFeature != null) return _subclassFeature!;
    _subclassFeature = _is.createRelationTable(
      relationFieldName: 'subclassFeature',
      field: FeatureResourceDefinitionData.t.subclassFeatureId,
      foreignField: _i6bcyp7i.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i6bcyp7i.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _subclassFeature!;
  }

  _iga2jap7.RaceFeatureDataTable get raceFeature {
    if (_raceFeature != null) return _raceFeature!;
    _raceFeature = _is.createRelationTable(
      relationFieldName: 'raceFeature',
      field: FeatureResourceDefinitionData.t.raceFeatureId,
      foreignField: _iga2jap7.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iga2jap7.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _raceFeature!;
  }

  _iu6wj5qy.ChoiceOptionDataTable get choiceOption {
    if (_choiceOption != null) return _choiceOption!;
    _choiceOption = _is.createRelationTable(
      relationFieldName: 'choiceOption',
      field: FeatureResourceDefinitionData.t.choiceOptionId,
      foreignField: _iu6wj5qy.ChoiceOptionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu6wj5qy.ChoiceOptionDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceOption!;
  }

  _i40dz5tv.FeatureResourceProgressionValueDataTable get __progressionValues {
    if (___progressionValues != null) return ___progressionValues!;
    ___progressionValues = _is.createRelationTable(
      relationFieldName: '__progressionValues',
      field: FeatureResourceDefinitionData.t.id,
      foreignField:
          _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i40dz5tv.FeatureResourceProgressionValueDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___progressionValues!;
  }

  _is.ManyRelation<_i40dz5tv.FeatureResourceProgressionValueDataTable>
  get progressionValues {
    if (_progressionValues != null) return _progressionValues!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'progressionValues',
      field: FeatureResourceDefinitionData.t.id,
      foreignField:
          _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i40dz5tv.FeatureResourceProgressionValueDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _progressionValues =
        _is.ManyRelation<_i40dz5tv.FeatureResourceProgressionValueDataTable>(
          tableWithRelations: relationTable,
          table: _i40dz5tv.FeatureResourceProgressionValueDataTable(
            tableRelation: relationTable.tableRelation!.lastRelation,
          ),
        );
    return _progressionValues!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    classFeatureId,
    subclassFeatureId,
    raceFeatureId,
    key,
    choiceOptionId,
    name,
    kind,
    maxRule,
    maxValue,
    maxAbility,
    resetOn,
    activationTrigger,
    usageResetOn,
    progressionKey,
    becomesUnlimitedAtLevel,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    if (relationField == 'raceFeature') {
      return raceFeature;
    }
    if (relationField == 'choiceOption') {
      return choiceOption;
    }
    if (relationField == 'progressionValues') {
      return __progressionValues;
    }
    return null;
  }
}

class FeatureResourceDefinitionDataInclude extends _is.IncludeObject {
  FeatureResourceDefinitionDataInclude._({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
    _iga2jap7.RaceFeatureDataInclude? raceFeature,
    _iu6wj5qy.ChoiceOptionDataInclude? choiceOption,
    _i40dz5tv.FeatureResourceProgressionValueDataIncludeList? progressionValues,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
    _raceFeature = raceFeature;
    _choiceOption = choiceOption;
    _progressionValues = progressionValues;
  }

  _inxbtq9c.ClassFeatureDataInclude? _classFeature;

  _i6bcyp7i.SubclassFeatureDataInclude? _subclassFeature;

  _iga2jap7.RaceFeatureDataInclude? _raceFeature;

  _iu6wj5qy.ChoiceOptionDataInclude? _choiceOption;

  _i40dz5tv.FeatureResourceProgressionValueDataIncludeList? _progressionValues;

  @override
  Map<String, _is.Include?> get includes => {
    'classFeature': _classFeature,
    'subclassFeature': _subclassFeature,
    'raceFeature': _raceFeature,
    'choiceOption': _choiceOption,
    'progressionValues': _progressionValues,
  };

  @override
  _is.Table<int?> get table => FeatureResourceDefinitionData.t;
}

class FeatureResourceDefinitionDataIncludeList extends _is.IncludeList {
  FeatureResourceDefinitionDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceDefinitionData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureResourceDefinitionData.t;
}

class FeatureResourceDefinitionDataRepository {
  const FeatureResourceDefinitionDataRepository._();

  final attach = const FeatureResourceDefinitionDataAttachRepository._();

  final attachRow = const FeatureResourceDefinitionDataAttachRowRepository._();

  final detach = const FeatureResourceDefinitionDataDetachRepository._();

  final detachRow = const FeatureResourceDefinitionDataDetachRowRepository._();

  /// Returns a list of [FeatureResourceDefinitionData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FeatureResourceDefinitionData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureResourceDefinitionData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FeatureResourceDefinitionData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureResourceDefinitionData] by its [id] or null if no such row exists.
  Future<FeatureResourceDefinitionData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureResourceDefinitionData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureResourceDefinitionData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceDefinitionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> insert(
    _is.DatabaseSession session,
    List<FeatureResourceDefinitionData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureResourceDefinitionData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureResourceDefinitionData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceDefinitionData] will have its `id` field set.
  Future<FeatureResourceDefinitionData> insertRow(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceDefinitionData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureResourceDefinitionData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [FeatureResourceDefinitionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> upsert(
    _is.DatabaseSession session,
    List<FeatureResourceDefinitionData> rows, {
    required _is.ColumnSelections<FeatureResourceDefinitionDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceDefinitionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureResourceDefinitionData>(
      rows,
      conflictColumns: conflictColumns(FeatureResourceDefinitionData.t),
      updateColumns: updateColumns?.call(FeatureResourceDefinitionData.t),
      updateWhere: updateWhere?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureResourceDefinitionData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [FeatureResourceDefinitionData] will have its `id` field set.
  Future<FeatureResourceDefinitionData?> upsertRow(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData row, {
    required _is.ColumnSelections<FeatureResourceDefinitionDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceDefinitionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureResourceDefinitionData>(
      row,
      conflictColumns: conflictColumns(FeatureResourceDefinitionData.t),
      updateColumns: updateColumns?.call(FeatureResourceDefinitionData.t),
      updateWhere: updateWhere?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceDefinitionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> update(
    _is.DatabaseSession session,
    List<FeatureResourceDefinitionData> rows, {
    _is.ColumnSelections<FeatureResourceDefinitionDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureResourceDefinitionData>(
      rows,
      columns: columns?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureResourceDefinitionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceDefinitionData> updateRow(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData row, {
    _is.ColumnSelections<FeatureResourceDefinitionDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceDefinitionData>(
      row,
      columns: columns?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceDefinitionData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureResourceDefinitionData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      FeatureResourceDefinitionDataUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureResourceDefinitionData>(
      id,
      columnValues: columnValues(FeatureResourceDefinitionData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceDefinitionData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      FeatureResourceDefinitionDataUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureResourceDefinitionData>(
      columnValues: columnValues(FeatureResourceDefinitionData.t.updateTable),
      where: where(FeatureResourceDefinitionData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureResourceDefinitionData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> delete(
    _is.DatabaseSession session,
    List<FeatureResourceDefinitionData> rows, {
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureResourceDefinitionData>(
      rows,
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureResourceDefinitionData].
  Future<FeatureResourceDefinitionData> deleteRow(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceDefinitionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceDefinitionData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>
    where,
    _is.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureResourceDefinitionData>(
      where: where(FeatureResourceDefinitionData.t),
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureResourceDefinitionData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureResourceDefinitionData>(
      where: where(FeatureResourceDefinitionData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureResourceDefinitionDataAttachRepository {
  const FeatureResourceDefinitionDataAttachRepository._();

  /// Creates a relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]s
  /// by setting each [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to this [FeatureResourceDefinitionData].
  Future<void> progressionValues(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    List<_i40dz5tv.FeatureResourceProgressionValueData>
    featureResourceProgressionValueData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData
            .map(
              (e) => e.copyWith(
                resourceDefinitionId: featureResourceDefinitionData.id,
              ),
            )
            .toList();
    await session.db.update<_i40dz5tv.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      ],
      transaction: transaction,
    );
  }
}

class FeatureResourceDefinitionDataAttachRowRepository {
  const FeatureResourceDefinitionDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [ClassFeatureData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to refer to the [ClassFeatureData].
  Future<void> classFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _inxbtq9c.ClassFeatureData classFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      classFeatureId: classFeature.id,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [SubclassFeatureData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i6bcyp7i.SubclassFeatureData subclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      subclassFeatureId: subclassFeature.id,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [RaceFeatureData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to refer to the [RaceFeatureData].
  Future<void> raceFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _iga2jap7.RaceFeatureData raceFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (raceFeature.id == null) {
      throw ArgumentError.notNull('raceFeature.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      raceFeatureId: raceFeature.id,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [ChoiceOptionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `choiceOptionId` to refer to the [ChoiceOptionData].
  Future<void> choiceOption(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _iu6wj5qy.ChoiceOptionData choiceOption, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (choiceOption.id == null) {
      throw ArgumentError.notNull('choiceOption.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      choiceOptionId: choiceOption.id,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.choiceOptionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to this [FeatureResourceDefinitionData].
  Future<void> progressionValues(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i40dz5tv.FeatureResourceProgressionValueData
    featureResourceProgressionValueData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
          resourceDefinitionId: featureResourceDefinitionData.id,
        );
    await session.db.updateRow<_i40dz5tv.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      ],
      transaction: transaction,
    );
  }
}

class FeatureResourceDefinitionDataDetachRepository {
  const FeatureResourceDefinitionDataDetachRepository._();

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> progressionValues(
    _is.DatabaseSession session,
    List<_i40dz5tv.FeatureResourceProgressionValueData>
    featureResourceProgressionValueData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData
            .map((e) => e.copyWith(resourceDefinitionId: null))
            .toList();
    await session.db.update<_i40dz5tv.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      ],
      transaction: transaction,
    );
  }
}

class FeatureResourceDefinitionDataDetachRowRepository {
  const FeatureResourceDefinitionDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the [ClassFeatureData] set in `classFeature`
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the [SubclassFeatureData] set in `subclassFeature`
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclassFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      subclassFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the [RaceFeatureData] set in `raceFeature`
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> raceFeature(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      raceFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the [ChoiceOptionData] set in `choiceOption`
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `choiceOptionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> choiceOption(
    _is.DatabaseSession session,
    FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      choiceOptionId: null,
    );
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.choiceOptionId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> progressionValues(
    _is.DatabaseSession session,
    _i40dz5tv.FeatureResourceProgressionValueData
    featureResourceProgressionValueData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
          resourceDefinitionId: null,
        );
    await session.db.updateRow<_i40dz5tv.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i40dz5tv.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      ],
      transaction: transaction,
    );
  }
}
