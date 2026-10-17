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
import '../../data/general/class/class_feature_data.dart' as _inxbtq9c;
import '../../data/general/class/subclass_feature_data.dart' as _i6bcyp7i;
import '../../data/general/feature_modifier_condition_data.dart' as _ig9xtn4u;
import '../../data/general/feature_modifier_value_data.dart' as _iby00w8q;
import '../../enums/feature_modifier_operation.dart' as _iiz9cg73;
import '../../enums/feature_modifier_target.dart' as _i4cfd6vr;

abstract class FeatureModifierData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatureModifierData._({
    this.id,
    required this.referenceKey,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    required this.target,
    required this.operation,
    required this.value,
    this.conditions,
    this.spellKey,
    this.minimumCastLevel,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureModifierData({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    required _i4cfd6vr.FeatureModifierTarget target,
    required _iiz9cg73.FeatureModifierOperation operation,
    required _iby00w8q.FeatureModifierValueData value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureModifierDataImpl;

  factory FeatureModifierData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureModifierData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String,
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
      target: _i4cfd6vr.FeatureModifierTarget.fromJson(
        (jsonSerialization['target'] as int),
      ),
      operation: _iiz9cg73.FeatureModifierOperation.fromJson(
        (jsonSerialization['operation'] as int),
      ),
      value: _ikmnmw29.Protocol()
          .deserialize<_iby00w8q.FeatureModifierValueData>(
            jsonSerialization['value'],
          ),
      conditions: jsonSerialization['conditions'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ig9xtn4u.FeatureModifierConditionData>>(
                  jsonSerialization['conditions'],
                ),
      spellKey: jsonSerialization['spellKey'] as String?,
      minimumCastLevel: jsonSerialization['minimumCastLevel'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FeatureModifierDataTable();

  static const db = FeatureModifierDataRepository._();

  @override
  int? id;

  String referenceKey;

  int? classFeatureId;

  _inxbtq9c.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? subclassFeature;

  _i4cfd6vr.FeatureModifierTarget target;

  _iiz9cg73.FeatureModifierOperation operation;

  _iby00w8q.FeatureModifierValueData value;

  List<_ig9xtn4u.FeatureModifierConditionData>? conditions;

  String? spellKey;

  int? minimumCastLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureModifierData copyWith({
    int? id,
    String? referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    _i4cfd6vr.FeatureModifierTarget? target,
    _iiz9cg73.FeatureModifierOperation? operation,
    _iby00w8q.FeatureModifierValueData? value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureModifierData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJson(),
      if (conditions != null)
        'conditions': conditions?.toJson(valueToJson: (v) => v.toJson()),
      if (spellKey != null) 'spellKey': spellKey,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureModifierData',
      if (id != null) 'id': id,
      'referenceKey': referenceKey,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      'target': target.toJson(),
      'operation': operation.toJson(),
      'value': value.toJsonForProtocol(),
      if (conditions != null)
        'conditions': conditions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (spellKey != null) 'spellKey': spellKey,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static FeatureModifierDataInclude include({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
  }) {
    return FeatureModifierDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
    );
  }

  static FeatureModifierDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    FeatureModifierDataInclude? include,
  }) {
    return FeatureModifierDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierDataImpl extends FeatureModifierData {
  _FeatureModifierDataImpl({
    int? id,
    required String referenceKey,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    required _i4cfd6vr.FeatureModifierTarget target,
    required _iiz9cg73.FeatureModifierOperation operation,
    required _iby00w8q.FeatureModifierValueData value,
    List<_ig9xtn4u.FeatureModifierConditionData>? conditions,
    String? spellKey,
    int? minimumCastLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         classFeatureId: classFeatureId,
         classFeature: classFeature,
         subclassFeatureId: subclassFeatureId,
         subclassFeature: subclassFeature,
         target: target,
         operation: operation,
         value: value,
         conditions: conditions,
         spellKey: spellKey,
         minimumCastLevel: minimumCastLevel,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureModifierData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureModifierData copyWith({
    Object? id = _Undefined,
    String? referenceKey,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    _i4cfd6vr.FeatureModifierTarget? target,
    _iiz9cg73.FeatureModifierOperation? operation,
    _iby00w8q.FeatureModifierValueData? value,
    Object? conditions = _Undefined,
    Object? spellKey = _Undefined,
    Object? minimumCastLevel = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureModifierData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey ?? this.referenceKey,
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
      target: target ?? this.target,
      operation: operation ?? this.operation,
      value: value ?? this.value.copyWith(),
      conditions: conditions is List<_ig9xtn4u.FeatureModifierConditionData>?
          ? conditions
          : this.conditions?.map((e0) => e0.copyWith()).toList(),
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      minimumCastLevel: minimumCastLevel is int?
          ? minimumCastLevel
          : this.minimumCastLevel,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureModifierDataUpdateTable
    extends _is.UpdateTable<FeatureModifierDataTable> {
  FeatureModifierDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<int, int> classFeatureId(int? value) =>
      _is.ColumnValue(table.classFeatureId, value);

  _is.ColumnValue<int, int> subclassFeatureId(int? value) =>
      _is.ColumnValue(table.subclassFeatureId, value);

  _is.ColumnValue<
    _i4cfd6vr.FeatureModifierTarget,
    _i4cfd6vr.FeatureModifierTarget
  >
  target(_i4cfd6vr.FeatureModifierTarget value) =>
      _is.ColumnValue(table.target, value);

  _is.ColumnValue<
    _iiz9cg73.FeatureModifierOperation,
    _iiz9cg73.FeatureModifierOperation
  >
  operation(_iiz9cg73.FeatureModifierOperation value) =>
      _is.ColumnValue(table.operation, value);

  _is.ColumnValue<
    _iby00w8q.FeatureModifierValueData,
    _iby00w8q.FeatureModifierValueData
  >
  value(_iby00w8q.FeatureModifierValueData value) =>
      _is.ColumnValue(table.value, value);

  _is.ColumnValue<
    List<_ig9xtn4u.FeatureModifierConditionData>,
    List<_ig9xtn4u.FeatureModifierConditionData>
  >
  conditions(List<_ig9xtn4u.FeatureModifierConditionData>? value) =>
      _is.ColumnValue(table.conditions, value);

  _is.ColumnValue<String, String> spellKey(String? value) =>
      _is.ColumnValue(table.spellKey, value);

  _is.ColumnValue<int, int> minimumCastLevel(int? value) =>
      _is.ColumnValue(table.minimumCastLevel, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class FeatureModifierDataTable extends _is.Table<int?> {
  FeatureModifierDataTable({super.tableRelation})
    : super(tableName: 'feature_modifier_data') {
    updateTable = FeatureModifierDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    classFeatureId = _is.ColumnInt('classFeatureId', this);
    subclassFeatureId = _is.ColumnInt('subclassFeatureId', this);
    target = _is.ColumnEnum('target', this, _is.EnumSerialization.byIndex);
    operation = _is.ColumnEnum(
      'operation',
      this,
      _is.EnumSerialization.byIndex,
    );
    value = _is.ColumnSerializable<_iby00w8q.FeatureModifierValueData>(
      'value',
      this,
    );
    conditions =
        _is.ColumnSerializable<List<_ig9xtn4u.FeatureModifierConditionData>>(
          'conditions',
          this,
        );
    spellKey = _is.ColumnString('spellKey', this);
    minimumCastLevel = _is.ColumnInt('minimumCastLevel', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final FeatureModifierDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnInt classFeatureId;

  _inxbtq9c.ClassFeatureDataTable? _classFeature;

  late final _is.ColumnInt subclassFeatureId;

  _i6bcyp7i.SubclassFeatureDataTable? _subclassFeature;

  late final _is.ColumnEnum<_i4cfd6vr.FeatureModifierTarget> target;

  late final _is.ColumnEnum<_iiz9cg73.FeatureModifierOperation> operation;

  late final _is.ColumnSerializable<_iby00w8q.FeatureModifierValueData> value;

  late final _is.ColumnSerializable<
    List<_ig9xtn4u.FeatureModifierConditionData>
  >
  conditions;

  late final _is.ColumnString spellKey;

  late final _is.ColumnInt minimumCastLevel;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _inxbtq9c.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _is.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureModifierData.t.classFeatureId,
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
      field: FeatureModifierData.t.subclassFeatureId,
      foreignField: _i6bcyp7i.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i6bcyp7i.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _subclassFeature!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    referenceKey,
    classFeatureId,
    subclassFeatureId,
    target,
    operation,
    value,
    conditions,
    spellKey,
    minimumCastLevel,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    return null;
  }
}

class FeatureModifierDataInclude extends _is.IncludeObject {
  FeatureModifierDataInclude._({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
  }

  _inxbtq9c.ClassFeatureDataInclude? _classFeature;

  _i6bcyp7i.SubclassFeatureDataInclude? _subclassFeature;

  @override
  Map<String, _is.Include?> get includes => {
    'classFeature': _classFeature,
    'subclassFeature': _subclassFeature,
  };

  @override
  _is.Table<int?> get table => FeatureModifierData.t;
}

class FeatureModifierDataIncludeList extends _is.IncludeList {
  FeatureModifierDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureModifierData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureModifierData.t;
}

class FeatureModifierDataRepository {
  const FeatureModifierDataRepository._();

  final attachRow = const FeatureModifierDataAttachRowRepository._();

  final detachRow = const FeatureModifierDataDetachRowRepository._();

  /// Returns a list of [FeatureModifierData]s matching the given query parameters.
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
  Future<List<FeatureModifierData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureModifierDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureModifierData] matching the given query parameters.
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
  Future<FeatureModifierData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureModifierDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureModifierData] by its [id] or null if no such row exists.
  Future<FeatureModifierData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FeatureModifierDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureModifierData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureModifierData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureModifierData]s will have their `id` fields set.
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
  Future<List<FeatureModifierData>> insert(
    _is.DatabaseSession session,
    List<FeatureModifierData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureModifierData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureModifierData] and returns the inserted row.
  ///
  /// The returned [FeatureModifierData] will have its `id` field set.
  Future<FeatureModifierData> insertRow(
    _is.DatabaseSession session,
    FeatureModifierData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureModifierData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureModifierData]s in the list and returns the resulting rows.
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
  /// The returned [FeatureModifierData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureModifierData>> upsert(
    _is.DatabaseSession session,
    List<FeatureModifierData> rows, {
    required _is.ColumnSelections<FeatureModifierDataTable> conflictColumns,
    _is.ColumnSelections<FeatureModifierDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureModifierData>(
      rows,
      conflictColumns: conflictColumns(FeatureModifierData.t),
      updateColumns: updateColumns?.call(FeatureModifierData.t),
      updateWhere: updateWhere?.call(FeatureModifierData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureModifierData] and returns the resulting row.
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
  /// The returned [FeatureModifierData] will have its `id` field set.
  Future<FeatureModifierData?> upsertRow(
    _is.DatabaseSession session,
    FeatureModifierData row, {
    required _is.ColumnSelections<FeatureModifierDataTable> conflictColumns,
    _is.ColumnSelections<FeatureModifierDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureModifierData>(
      row,
      conflictColumns: conflictColumns(FeatureModifierData.t),
      updateColumns: updateColumns?.call(FeatureModifierData.t),
      updateWhere: updateWhere?.call(FeatureModifierData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureModifierData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureModifierData>> update(
    _is.DatabaseSession session,
    List<FeatureModifierData> rows, {
    _is.ColumnSelections<FeatureModifierDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureModifierData>(
      rows,
      columns: columns?.call(FeatureModifierData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureModifierData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureModifierData> updateRow(
    _is.DatabaseSession session,
    FeatureModifierData row, {
    _is.ColumnSelections<FeatureModifierDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureModifierData>(
      row,
      columns: columns?.call(FeatureModifierData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureModifierData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureModifierData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeatureModifierDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureModifierData>(
      id,
      columnValues: columnValues(FeatureModifierData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureModifierData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureModifierData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeatureModifierDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FeatureModifierDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureModifierData>(
      columnValues: columnValues(FeatureModifierData.t.updateTable),
      where: where(FeatureModifierData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureModifierData]s in the list and returns the deleted rows.
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
  Future<List<FeatureModifierData>> delete(
    _is.DatabaseSession session,
    List<FeatureModifierData> rows, {
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureModifierData>(
      rows,
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureModifierData].
  Future<FeatureModifierData> deleteRow(
    _is.DatabaseSession session,
    FeatureModifierData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureModifierData>(
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
  Future<List<FeatureModifierData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureModifierDataTable> where,
    _is.OrderByBuilder<FeatureModifierDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureModifierDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureModifierData>(
      where: where(FeatureModifierData.t),
      orderBy: orderBy?.call(FeatureModifierData.t),
      orderByList: orderByList?.call(FeatureModifierData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureModifierDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureModifierData>(
      where: where?.call(FeatureModifierData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureModifierData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureModifierDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureModifierData>(
      where: where(FeatureModifierData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureModifierDataAttachRowRepository {
  const FeatureModifierDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureModifierData] and [ClassFeatureData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to refer to the [ClassFeatureData].
  Future<void> classFeature(
    _is.DatabaseSession session,
    FeatureModifierData featureModifierData,
    _inxbtq9c.ClassFeatureData classFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      classFeatureId: classFeature.id,
    );
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureModifierData] and [SubclassFeatureData]
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _is.DatabaseSession session,
    FeatureModifierData featureModifierData,
    _i6bcyp7i.SubclassFeatureData subclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      subclassFeatureId: subclassFeature.id,
    );
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}

class FeatureModifierDataDetachRowRepository {
  const FeatureModifierDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureModifierData] and the [ClassFeatureData] set in `classFeature`
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeature(
    _is.DatabaseSession session,
    FeatureModifierData featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureModifierData] and the [SubclassFeatureData] set in `subclassFeature`
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclassFeature(
    _is.DatabaseSession session,
    FeatureModifierData featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      subclassFeatureId: null,
    );
    await session.db.updateRow<FeatureModifierData>(
      $featureModifierData,
      columns: [FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}
