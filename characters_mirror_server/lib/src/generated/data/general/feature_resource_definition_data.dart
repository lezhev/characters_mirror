/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../data/general/class/class_feature_data.dart' as _i2;
import '../../data/general/class/subclass_feature_data.dart' as _i3;
import '../../data/general/race/race_feature_data.dart' as _i4;
import '../../enums/feature_resource_kind.dart' as _i5;
import '../../enums/feature_resource_max_rule.dart' as _i6;
import '../../enums/ability.dart' as _i7;
import '../../enums/rest_type.dart' as _i8;
import '../../enums/feature_resource_trigger.dart' as _i9;
import '../../enums/feature_resource_progression_key.dart' as _i10;
import '../../data/general/feature_resource_progression_value_data.dart'
    as _i11;

abstract class FeatureResourceDefinitionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureResourceDefinitionData._({
    this.id,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    this.raceFeatureId,
    this.raceFeature,
    required this.key,
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
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required String key,
    String? name,
    required _i5.FeatureResourceKind kind,
    required _i6.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _i7.Ability? maxAbility,
    _i8.RestType? resetOn,
    _i9.FeatureResourceTrigger? activationTrigger,
    _i8.RestType? usageResetOn,
    _i10.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i11.FeatureResourceProgressionValueData>? progressionValues,
  }) = _FeatureResourceDefinitionDataImpl;

  factory FeatureResourceDefinitionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureResourceDefinitionData(
      id: jsonSerialization['id'] as int?,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['classFeature'] as Map<String, dynamic>)),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeature'] as Map<String, dynamic>)),
      raceFeatureId: jsonSerialization['raceFeatureId'] as int?,
      raceFeature: jsonSerialization['raceFeature'] == null
          ? null
          : _i4.RaceFeatureData.fromJson(
              (jsonSerialization['raceFeature'] as Map<String, dynamic>)),
      key: jsonSerialization['key'] as String,
      name: jsonSerialization['name'] as String?,
      kind: _i5.FeatureResourceKind.fromJson(
          (jsonSerialization['kind'] as String)),
      maxRule: _i6.FeatureResourceMaxRule.fromJson(
          (jsonSerialization['maxRule'] as String)),
      maxValue: jsonSerialization['maxValue'] as int?,
      maxAbility: jsonSerialization['maxAbility'] == null
          ? null
          : _i7.Ability.fromJson((jsonSerialization['maxAbility'] as String)),
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i8.RestType.fromJson((jsonSerialization['resetOn'] as String)),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _i9.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String)),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i8.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String)),
      progressionKey: jsonSerialization['progressionKey'] == null
          ? null
          : _i10.FeatureResourceProgressionKey.fromJson(
              (jsonSerialization['progressionKey'] as String)),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
      progressionValues: (jsonSerialization['progressionValues'] as List?)
          ?.map((e) => _i11.FeatureResourceProgressionValueData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = FeatureResourceDefinitionDataTable();

  static const db = FeatureResourceDefinitionDataRepository._();

  @override
  int? id;

  int? classFeatureId;

  _i2.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i3.SubclassFeatureData? subclassFeature;

  int? raceFeatureId;

  _i4.RaceFeatureData? raceFeature;

  String key;

  String? name;

  _i5.FeatureResourceKind kind;

  _i6.FeatureResourceMaxRule maxRule;

  int? maxValue;

  _i7.Ability? maxAbility;

  _i8.RestType? resetOn;

  _i9.FeatureResourceTrigger? activationTrigger;

  _i8.RestType? usageResetOn;

  _i10.FeatureResourceProgressionKey? progressionKey;

  int? becomesUnlimitedAtLevel;

  List<_i11.FeatureResourceProgressionValueData>? progressionValues;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureResourceDefinitionData copyWith({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    String? key,
    String? name,
    _i5.FeatureResourceKind? kind,
    _i6.FeatureResourceMaxRule? maxRule,
    int? maxValue,
    _i7.Ability? maxAbility,
    _i8.RestType? resetOn,
    _i9.FeatureResourceTrigger? activationTrigger,
    _i8.RestType? usageResetOn,
    _i10.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i11.FeatureResourceProgressionValueData>? progressionValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJson(),
      'key': key,
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
        'progressionValues':
            progressionValues?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
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
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static FeatureResourceDefinitionDataInclude include({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
    _i4.RaceFeatureDataInclude? raceFeature,
    _i11.FeatureResourceProgressionValueDataIncludeList? progressionValues,
  }) {
    return FeatureResourceDefinitionDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
      raceFeature: raceFeature,
      progressionValues: progressionValues,
    );
  }

  static FeatureResourceDefinitionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    FeatureResourceDefinitionDataInclude? include,
  }) {
    return FeatureResourceDefinitionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceDefinitionDataImpl extends FeatureResourceDefinitionData {
  _FeatureResourceDefinitionDataImpl({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required String key,
    String? name,
    required _i5.FeatureResourceKind kind,
    required _i6.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _i7.Ability? maxAbility,
    _i8.RestType? resetOn,
    _i9.FeatureResourceTrigger? activationTrigger,
    _i8.RestType? usageResetOn,
    _i10.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i11.FeatureResourceProgressionValueData>? progressionValues,
  }) : super._(
          id: id,
          classFeatureId: classFeatureId,
          classFeature: classFeature,
          subclassFeatureId: subclassFeatureId,
          subclassFeature: subclassFeature,
          raceFeatureId: raceFeatureId,
          raceFeature: raceFeature,
          key: key,
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
  @_i1.useResult
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
    Object? name = _Undefined,
    _i5.FeatureResourceKind? kind,
    _i6.FeatureResourceMaxRule? maxRule,
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
      classFeatureId:
          classFeatureId is int? ? classFeatureId : this.classFeatureId,
      classFeature: classFeature is _i2.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i3.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      raceFeatureId: raceFeatureId is int? ? raceFeatureId : this.raceFeatureId,
      raceFeature: raceFeature is _i4.RaceFeatureData?
          ? raceFeature
          : this.raceFeature?.copyWith(),
      key: key ?? this.key,
      name: name is String? ? name : this.name,
      kind: kind ?? this.kind,
      maxRule: maxRule ?? this.maxRule,
      maxValue: maxValue is int? ? maxValue : this.maxValue,
      maxAbility: maxAbility is _i7.Ability? ? maxAbility : this.maxAbility,
      resetOn: resetOn is _i8.RestType? ? resetOn : this.resetOn,
      activationTrigger: activationTrigger is _i9.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn:
          usageResetOn is _i8.RestType? ? usageResetOn : this.usageResetOn,
      progressionKey: progressionKey is _i10.FeatureResourceProgressionKey?
          ? progressionKey
          : this.progressionKey,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
      progressionValues:
          progressionValues is List<_i11.FeatureResourceProgressionValueData>?
              ? progressionValues
              : this.progressionValues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class FeatureResourceDefinitionDataTable extends _i1.Table<int?> {
  FeatureResourceDefinitionDataTable({super.tableRelation})
      : super(tableName: 'feature_resource_definition_data') {
    classFeatureId = _i1.ColumnInt(
      'classFeatureId',
      this,
    );
    subclassFeatureId = _i1.ColumnInt(
      'subclassFeatureId',
      this,
    );
    raceFeatureId = _i1.ColumnInt(
      'raceFeatureId',
      this,
    );
    key = _i1.ColumnString(
      'key',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    maxRule = _i1.ColumnEnum(
      'maxRule',
      this,
      _i1.EnumSerialization.byName,
    );
    maxValue = _i1.ColumnInt(
      'maxValue',
      this,
    );
    maxAbility = _i1.ColumnEnum(
      'maxAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    resetOn = _i1.ColumnEnum(
      'resetOn',
      this,
      _i1.EnumSerialization.byName,
    );
    activationTrigger = _i1.ColumnEnum(
      'activationTrigger',
      this,
      _i1.EnumSerialization.byName,
    );
    usageResetOn = _i1.ColumnEnum(
      'usageResetOn',
      this,
      _i1.EnumSerialization.byName,
    );
    progressionKey = _i1.ColumnEnum(
      'progressionKey',
      this,
      _i1.EnumSerialization.byName,
    );
    becomesUnlimitedAtLevel = _i1.ColumnInt(
      'becomesUnlimitedAtLevel',
      this,
    );
  }

  late final _i1.ColumnInt classFeatureId;

  _i2.ClassFeatureDataTable? _classFeature;

  late final _i1.ColumnInt subclassFeatureId;

  _i3.SubclassFeatureDataTable? _subclassFeature;

  late final _i1.ColumnInt raceFeatureId;

  _i4.RaceFeatureDataTable? _raceFeature;

  late final _i1.ColumnString key;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i5.FeatureResourceKind> kind;

  late final _i1.ColumnEnum<_i6.FeatureResourceMaxRule> maxRule;

  late final _i1.ColumnInt maxValue;

  late final _i1.ColumnEnum<_i7.Ability> maxAbility;

  late final _i1.ColumnEnum<_i8.RestType> resetOn;

  late final _i1.ColumnEnum<_i9.FeatureResourceTrigger> activationTrigger;

  late final _i1.ColumnEnum<_i8.RestType> usageResetOn;

  late final _i1.ColumnEnum<_i10.FeatureResourceProgressionKey> progressionKey;

  late final _i1.ColumnInt becomesUnlimitedAtLevel;

  _i11.FeatureResourceProgressionValueDataTable? ___progressionValues;

  _i1.ManyRelation<_i11.FeatureResourceProgressionValueDataTable>?
      _progressionValues;

  _i2.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _i1.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureResourceDefinitionData.t.classFeatureId,
      foreignField: _i2.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _classFeature!;
  }

  _i3.SubclassFeatureDataTable get subclassFeature {
    if (_subclassFeature != null) return _subclassFeature!;
    _subclassFeature = _i1.createRelationTable(
      relationFieldName: 'subclassFeature',
      field: FeatureResourceDefinitionData.t.subclassFeatureId,
      foreignField: _i3.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _subclassFeature!;
  }

  _i4.RaceFeatureDataTable get raceFeature {
    if (_raceFeature != null) return _raceFeature!;
    _raceFeature = _i1.createRelationTable(
      relationFieldName: 'raceFeature',
      field: FeatureResourceDefinitionData.t.raceFeatureId,
      foreignField: _i4.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _raceFeature!;
  }

  _i11.FeatureResourceProgressionValueDataTable get __progressionValues {
    if (___progressionValues != null) return ___progressionValues!;
    ___progressionValues = _i1.createRelationTable(
      relationFieldName: '__progressionValues',
      field: FeatureResourceDefinitionData.t.id,
      foreignField:
          _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.FeatureResourceProgressionValueDataTable(
              tableRelation: foreignTableRelation),
    );
    return ___progressionValues!;
  }

  _i1.ManyRelation<_i11.FeatureResourceProgressionValueDataTable>
      get progressionValues {
    if (_progressionValues != null) return _progressionValues!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'progressionValues',
      field: FeatureResourceDefinitionData.t.id,
      foreignField:
          _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i11.FeatureResourceProgressionValueDataTable(
              tableRelation: foreignTableRelation),
    );
    _progressionValues =
        _i1.ManyRelation<_i11.FeatureResourceProgressionValueDataTable>(
      tableWithRelations: relationTable,
      table: _i11.FeatureResourceProgressionValueDataTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _progressionValues!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        classFeatureId,
        subclassFeatureId,
        raceFeatureId,
        key,
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
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    if (relationField == 'raceFeature') {
      return raceFeature;
    }
    if (relationField == 'progressionValues') {
      return __progressionValues;
    }
    return null;
  }
}

class FeatureResourceDefinitionDataInclude extends _i1.IncludeObject {
  FeatureResourceDefinitionDataInclude._({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
    _i4.RaceFeatureDataInclude? raceFeature,
    _i11.FeatureResourceProgressionValueDataIncludeList? progressionValues,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
    _raceFeature = raceFeature;
    _progressionValues = progressionValues;
  }

  _i2.ClassFeatureDataInclude? _classFeature;

  _i3.SubclassFeatureDataInclude? _subclassFeature;

  _i4.RaceFeatureDataInclude? _raceFeature;

  _i11.FeatureResourceProgressionValueDataIncludeList? _progressionValues;

  @override
  Map<String, _i1.Include?> get includes => {
        'classFeature': _classFeature,
        'subclassFeature': _subclassFeature,
        'raceFeature': _raceFeature,
        'progressionValues': _progressionValues,
      };

  @override
  _i1.Table<int?> get table => FeatureResourceDefinitionData.t;
}

class FeatureResourceDefinitionDataIncludeList extends _i1.IncludeList {
  FeatureResourceDefinitionDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceDefinitionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureResourceDefinitionData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
  }) async {
    return session.db.find<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceDefinitionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceDefinitionDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
  }) async {
    return session.db.findFirstRow<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      orderBy: orderBy?.call(FeatureResourceDefinitionData.t),
      orderByList: orderByList?.call(FeatureResourceDefinitionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FeatureResourceDefinitionData] by its [id] or null if no such row exists.
  Future<FeatureResourceDefinitionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FeatureResourceDefinitionDataInclude? include,
  }) async {
    return session.db.findById<FeatureResourceDefinitionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FeatureResourceDefinitionData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceDefinitionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureResourceDefinitionData>> insert(
    _i1.Session session,
    List<FeatureResourceDefinitionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureResourceDefinitionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureResourceDefinitionData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceDefinitionData] will have its `id` field set.
  Future<FeatureResourceDefinitionData> insertRow(
    _i1.Session session,
    FeatureResourceDefinitionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceDefinitionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceDefinitionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureResourceDefinitionData>> update(
    _i1.Session session,
    List<FeatureResourceDefinitionData> rows, {
    _i1.ColumnSelections<FeatureResourceDefinitionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureResourceDefinitionData>(
      rows,
      columns: columns?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceDefinitionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceDefinitionData> updateRow(
    _i1.Session session,
    FeatureResourceDefinitionData row, {
    _i1.ColumnSelections<FeatureResourceDefinitionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceDefinitionData>(
      row,
      columns: columns?.call(FeatureResourceDefinitionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureResourceDefinitionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureResourceDefinitionData>> delete(
    _i1.Session session,
    List<FeatureResourceDefinitionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureResourceDefinitionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureResourceDefinitionData].
  Future<FeatureResourceDefinitionData> deleteRow(
    _i1.Session session,
    FeatureResourceDefinitionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceDefinitionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureResourceDefinitionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureResourceDefinitionData>(
      where: where(FeatureResourceDefinitionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceDefinitionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceDefinitionData>(
      where: where?.call(FeatureResourceDefinitionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FeatureResourceDefinitionDataAttachRepository {
  const FeatureResourceDefinitionDataAttachRepository._();

  /// Creates a relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]s
  /// by setting each [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to this [FeatureResourceDefinitionData].
  Future<void> progressionValues(
    _i1.Session session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    List<_i11.FeatureResourceProgressionValueData>
        featureResourceProgressionValueData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData
            .map((e) => e.copyWith(
                resourceDefinitionId: featureResourceDefinitionData.id))
            .toList();
    await session.db.update<_i11.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId
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
    _i1.Session session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i2.ClassFeatureData classFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureResourceDefinitionData =
        featureResourceDefinitionData.copyWith(classFeatureId: classFeature.id);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [SubclassFeatureData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _i1.Session session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i3.SubclassFeatureData subclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
        subclassFeatureId: subclassFeature.id);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceDefinitionData] and [RaceFeatureData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `raceFeatureId` to refer to the [RaceFeatureData].
  Future<void> raceFeature(
    _i1.Session session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i4.RaceFeatureData raceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (raceFeature.id == null) {
      throw ArgumentError.notNull('raceFeature.id');
    }

    var $featureResourceDefinitionData =
        featureResourceDefinitionData.copyWith(raceFeatureId: raceFeature.id);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to refer to this [FeatureResourceDefinitionData].
  Future<void> progressionValues(
    _i1.Session session,
    FeatureResourceDefinitionData featureResourceDefinitionData,
    _i11.FeatureResourceProgressionValueData
        featureResourceProgressionValueData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
            resourceDefinitionId: featureResourceDefinitionData.id);
    await session.db.updateRow<_i11.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId
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
    _i1.Session session,
    List<_i11.FeatureResourceProgressionValueData>
        featureResourceProgressionValueData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData
            .map((e) => e.copyWith(resourceDefinitionId: null))
            .toList();
    await session.db.update<_i11.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId
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
    _i1.Session session,
    FeatureResourceDefinitionData featureresourcedefinitiondata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourcedefinitiondata.id == null) {
      throw ArgumentError.notNull('featureresourcedefinitiondata.id');
    }

    var $featureresourcedefinitiondata =
        featureresourcedefinitiondata.copyWith(classFeatureId: null);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureresourcedefinitiondata,
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
    _i1.Session session,
    FeatureResourceDefinitionData featureresourcedefinitiondata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourcedefinitiondata.id == null) {
      throw ArgumentError.notNull('featureresourcedefinitiondata.id');
    }

    var $featureresourcedefinitiondata =
        featureresourcedefinitiondata.copyWith(subclassFeatureId: null);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureresourcedefinitiondata,
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
    _i1.Session session,
    FeatureResourceDefinitionData featureresourcedefinitiondata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourcedefinitiondata.id == null) {
      throw ArgumentError.notNull('featureresourcedefinitiondata.id');
    }

    var $featureresourcedefinitiondata =
        featureresourcedefinitiondata.copyWith(raceFeatureId: null);
    await session.db.updateRow<FeatureResourceDefinitionData>(
      $featureresourcedefinitiondata,
      columns: [FeatureResourceDefinitionData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceDefinitionData] and the given [FeatureResourceProgressionValueData]
  /// by setting the [FeatureResourceProgressionValueData]'s foreign key `resourceDefinitionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> progressionValues(
    _i1.Session session,
    _i11.FeatureResourceProgressionValueData
        featureResourceProgressionValueData, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceProgressionValueData.id == null) {
      throw ArgumentError.notNull('featureResourceProgressionValueData.id');
    }

    var $featureResourceProgressionValueData =
        featureResourceProgressionValueData.copyWith(
            resourceDefinitionId: null);
    await session.db.updateRow<_i11.FeatureResourceProgressionValueData>(
      $featureResourceProgressionValueData,
      columns: [
        _i11.FeatureResourceProgressionValueData.t.resourceDefinitionId
      ],
      transaction: transaction,
    );
  }
}
