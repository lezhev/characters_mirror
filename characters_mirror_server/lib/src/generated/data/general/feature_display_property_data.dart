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
import '../../enums/feature_display_property_value_kind.dart' as _imi7l93k;

abstract class FeatureDisplayPropertyData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatureDisplayPropertyData._({
    this.id,
    this.sourceClassFeatureId,
    this.sourceClassFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    required this.key,
    required this.label,
    required this.valueKind,
    this.staticValue,
    this.progression,
    this.formula,
    this.sortOrder,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureDisplayPropertyData({
    int? id,
    int? sourceClassFeatureId,
    _inxbtq9c.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _imi7l93k.FeatureDisplayPropertyValueKind valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureDisplayPropertyDataImpl;

  factory FeatureDisplayPropertyData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureDisplayPropertyData(
      id: jsonSerialization['id'] as int?,
      sourceClassFeatureId: jsonSerialization['sourceClassFeatureId'] as int?,
      sourceClassFeature: jsonSerialization['sourceClassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['sourceClassFeature'],
            ),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['sourceSubclassFeature'],
            ),
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      valueKind: _imi7l93k.FeatureDisplayPropertyValueKind.fromJson(
        (jsonSerialization['valueKind'] as String),
      ),
      staticValue: jsonSerialization['staticValue'] as String?,
      progression: jsonSerialization['progression'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, String>>(
              jsonSerialization['progression'],
            ),
      formula: jsonSerialization['formula'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
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

  static final t = FeatureDisplayPropertyDataTable();

  static const db = FeatureDisplayPropertyDataRepository._();

  @override
  int? id;

  int? sourceClassFeatureId;

  _inxbtq9c.ClassFeatureData? sourceClassFeature;

  int? sourceSubclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature;

  String key;

  String label;

  _imi7l93k.FeatureDisplayPropertyValueKind valueKind;

  String? staticValue;

  Map<int, String>? progression;

  String? formula;

  int? sortOrder;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureDisplayPropertyData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureDisplayPropertyData copyWith({
    int? id,
    int? sourceClassFeatureId,
    _inxbtq9c.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    String? key,
    String? label,
    _imi7l93k.FeatureDisplayPropertyValueKind? valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureDisplayPropertyData',
      if (id != null) 'id': id,
      if (sourceClassFeatureId != null)
        'sourceClassFeatureId': sourceClassFeatureId,
      if (sourceClassFeature != null)
        'sourceClassFeature': sourceClassFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      'key': key,
      'label': label,
      'valueKind': valueKind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (formula != null) 'formula': formula,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureDisplayPropertyData',
      if (id != null) 'id': id,
      if (sourceClassFeatureId != null)
        'sourceClassFeatureId': sourceClassFeatureId,
      if (sourceClassFeature != null)
        'sourceClassFeature': sourceClassFeature?.toJsonForProtocol(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJsonForProtocol(),
      'key': key,
      'label': label,
      'valueKind': valueKind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (formula != null) 'formula': formula,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static FeatureDisplayPropertyDataInclude include({
    _inxbtq9c.ClassFeatureDataInclude? sourceClassFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    return FeatureDisplayPropertyDataInclude._(
      sourceClassFeature: sourceClassFeature,
      sourceSubclassFeature: sourceSubclassFeature,
    );
  }

  static FeatureDisplayPropertyDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    FeatureDisplayPropertyDataInclude? include,
  }) {
    return FeatureDisplayPropertyDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureDisplayPropertyDataImpl extends FeatureDisplayPropertyData {
  _FeatureDisplayPropertyDataImpl({
    int? id,
    int? sourceClassFeatureId,
    _inxbtq9c.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _imi7l93k.FeatureDisplayPropertyValueKind valueKind,
    String? staticValue,
    Map<int, String>? progression,
    String? formula,
    int? sortOrder,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceClassFeatureId: sourceClassFeatureId,
         sourceClassFeature: sourceClassFeature,
         sourceSubclassFeatureId: sourceSubclassFeatureId,
         sourceSubclassFeature: sourceSubclassFeature,
         key: key,
         label: label,
         valueKind: valueKind,
         staticValue: staticValue,
         progression: progression,
         formula: formula,
         sortOrder: sortOrder,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FeatureDisplayPropertyData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureDisplayPropertyData copyWith({
    Object? id = _Undefined,
    Object? sourceClassFeatureId = _Undefined,
    Object? sourceClassFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    String? key,
    String? label,
    _imi7l93k.FeatureDisplayPropertyValueKind? valueKind,
    Object? staticValue = _Undefined,
    Object? progression = _Undefined,
    Object? formula = _Undefined,
    Object? sortOrder = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureDisplayPropertyData(
      id: id is int? ? id : this.id,
      sourceClassFeatureId: sourceClassFeatureId is int?
          ? sourceClassFeatureId
          : this.sourceClassFeatureId,
      sourceClassFeature: sourceClassFeature is _inxbtq9c.ClassFeatureData?
          ? sourceClassFeature
          : this.sourceClassFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature:
          sourceSubclassFeature is _i6bcyp7i.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      key: key ?? this.key,
      label: label ?? this.label,
      valueKind: valueKind ?? this.valueKind,
      staticValue: staticValue is String? ? staticValue : this.staticValue,
      progression: progression is Map<int, String>?
          ? progression
          : this.progression?.map((key0, value0) => MapEntry(key0, value0)),
      formula: formula is String? ? formula : this.formula,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureDisplayPropertyDataUpdateTable
    extends _is.UpdateTable<FeatureDisplayPropertyDataTable> {
  FeatureDisplayPropertyDataUpdateTable(super.table);

  _is.ColumnValue<int, int> sourceClassFeatureId(int? value) =>
      _is.ColumnValue(table.sourceClassFeatureId, value);

  _is.ColumnValue<int, int> sourceSubclassFeatureId(int? value) =>
      _is.ColumnValue(table.sourceSubclassFeatureId, value);

  _is.ColumnValue<String, String> key(String value) =>
      _is.ColumnValue(table.key, value);

  _is.ColumnValue<String, String> label(String value) =>
      _is.ColumnValue(table.label, value);

  _is.ColumnValue<
    _imi7l93k.FeatureDisplayPropertyValueKind,
    _imi7l93k.FeatureDisplayPropertyValueKind
  >
  valueKind(_imi7l93k.FeatureDisplayPropertyValueKind value) =>
      _is.ColumnValue(table.valueKind, value);

  _is.ColumnValue<String, String> staticValue(String? value) =>
      _is.ColumnValue(table.staticValue, value);

  _is.ColumnValue<Map<int, String>, Map<int, String>> progression(
    Map<int, String>? value,
  ) => _is.ColumnValue(table.progression, value);

  _is.ColumnValue<String, String> formula(String? value) =>
      _is.ColumnValue(table.formula, value);

  _is.ColumnValue<int, int> sortOrder(int? value) =>
      _is.ColumnValue(table.sortOrder, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class FeatureDisplayPropertyDataTable extends _is.Table<int?> {
  FeatureDisplayPropertyDataTable({super.tableRelation})
    : super(tableName: 'feature_display_property_data') {
    updateTable = FeatureDisplayPropertyDataUpdateTable(this);
    sourceClassFeatureId = _is.ColumnInt('sourceClassFeatureId', this);
    sourceSubclassFeatureId = _is.ColumnInt('sourceSubclassFeatureId', this);
    key = _is.ColumnString('key', this);
    label = _is.ColumnString('label', this);
    valueKind = _is.ColumnEnum('valueKind', this, _is.EnumSerialization.byName);
    staticValue = _is.ColumnString('staticValue', this);
    progression = _is.ColumnSerializable<Map<int, String>>('progression', this);
    formula = _is.ColumnString('formula', this);
    sortOrder = _is.ColumnInt('sortOrder', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final FeatureDisplayPropertyDataUpdateTable updateTable;

  late final _is.ColumnInt sourceClassFeatureId;

  _inxbtq9c.ClassFeatureDataTable? _sourceClassFeature;

  late final _is.ColumnInt sourceSubclassFeatureId;

  _i6bcyp7i.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _is.ColumnString key;

  late final _is.ColumnString label;

  late final _is.ColumnEnum<_imi7l93k.FeatureDisplayPropertyValueKind>
  valueKind;

  late final _is.ColumnString staticValue;

  late final _is.ColumnSerializable<Map<int, String>> progression;

  late final _is.ColumnString formula;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _inxbtq9c.ClassFeatureDataTable get sourceClassFeature {
    if (_sourceClassFeature != null) return _sourceClassFeature!;
    _sourceClassFeature = _is.createRelationTable(
      relationFieldName: 'sourceClassFeature',
      field: FeatureDisplayPropertyData.t.sourceClassFeatureId,
      foreignField: _inxbtq9c.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inxbtq9c.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClassFeature!;
  }

  _i6bcyp7i.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _is.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: FeatureDisplayPropertyData.t.sourceSubclassFeatureId,
      foreignField: _i6bcyp7i.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i6bcyp7i.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _sourceSubclassFeature!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    sourceClassFeatureId,
    sourceSubclassFeatureId,
    key,
    label,
    valueKind,
    staticValue,
    progression,
    formula,
    sortOrder,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'sourceClassFeature') {
      return sourceClassFeature;
    }
    if (relationField == 'sourceSubclassFeature') {
      return sourceSubclassFeature;
    }
    return null;
  }
}

class FeatureDisplayPropertyDataInclude extends _is.IncludeObject {
  FeatureDisplayPropertyDataInclude._({
    _inxbtq9c.ClassFeatureDataInclude? sourceClassFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    _sourceClassFeature = sourceClassFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
  }

  _inxbtq9c.ClassFeatureDataInclude? _sourceClassFeature;

  _i6bcyp7i.SubclassFeatureDataInclude? _sourceSubclassFeature;

  @override
  Map<String, _is.Include?> get includes => {
    'sourceClassFeature': _sourceClassFeature,
    'sourceSubclassFeature': _sourceSubclassFeature,
  };

  @override
  _is.Table<int?> get table => FeatureDisplayPropertyData.t;
}

class FeatureDisplayPropertyDataIncludeList extends _is.IncludeList {
  FeatureDisplayPropertyDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureDisplayPropertyData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureDisplayPropertyData.t;
}

class FeatureDisplayPropertyDataRepository {
  const FeatureDisplayPropertyDataRepository._();

  final attachRow = const FeatureDisplayPropertyDataAttachRowRepository._();

  final detachRow = const FeatureDisplayPropertyDataDetachRowRepository._();

  /// Returns a list of [FeatureDisplayPropertyData]s matching the given query parameters.
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
  Future<List<FeatureDisplayPropertyData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatureDisplayPropertyData] matching the given query parameters.
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
  Future<FeatureDisplayPropertyData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureDisplayPropertyData] by its [id] or null if no such row exists.
  Future<FeatureDisplayPropertyData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureDisplayPropertyData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureDisplayPropertyData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureDisplayPropertyData]s will have their `id` fields set.
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
  Future<List<FeatureDisplayPropertyData>> insert(
    _is.DatabaseSession session,
    List<FeatureDisplayPropertyData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureDisplayPropertyData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureDisplayPropertyData] and returns the inserted row.
  ///
  /// The returned [FeatureDisplayPropertyData] will have its `id` field set.
  Future<FeatureDisplayPropertyData> insertRow(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureDisplayPropertyData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureDisplayPropertyData]s in the list and returns the resulting rows.
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
  /// The returned [FeatureDisplayPropertyData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureDisplayPropertyData>> upsert(
    _is.DatabaseSession session,
    List<FeatureDisplayPropertyData> rows, {
    required _is.ColumnSelections<FeatureDisplayPropertyDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureDisplayPropertyDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureDisplayPropertyData>(
      rows,
      conflictColumns: conflictColumns(FeatureDisplayPropertyData.t),
      updateColumns: updateColumns?.call(FeatureDisplayPropertyData.t),
      updateWhere: updateWhere?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureDisplayPropertyData] and returns the resulting row.
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
  /// The returned [FeatureDisplayPropertyData] will have its `id` field set.
  Future<FeatureDisplayPropertyData?> upsertRow(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData row, {
    required _is.ColumnSelections<FeatureDisplayPropertyDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureDisplayPropertyDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureDisplayPropertyData>(
      row,
      conflictColumns: conflictColumns(FeatureDisplayPropertyData.t),
      updateColumns: updateColumns?.call(FeatureDisplayPropertyData.t),
      updateWhere: updateWhere?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureDisplayPropertyData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureDisplayPropertyData>> update(
    _is.DatabaseSession session,
    List<FeatureDisplayPropertyData> rows, {
    _is.ColumnSelections<FeatureDisplayPropertyDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureDisplayPropertyData>(
      rows,
      columns: columns?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureDisplayPropertyData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureDisplayPropertyData> updateRow(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData row, {
    _is.ColumnSelections<FeatureDisplayPropertyDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureDisplayPropertyData>(
      row,
      columns: columns?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureDisplayPropertyData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureDisplayPropertyData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeatureDisplayPropertyDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureDisplayPropertyData>(
      id,
      columnValues: columnValues(FeatureDisplayPropertyData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureDisplayPropertyData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureDisplayPropertyData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeatureDisplayPropertyDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureDisplayPropertyData>(
      columnValues: columnValues(FeatureDisplayPropertyData.t.updateTable),
      where: where(FeatureDisplayPropertyData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureDisplayPropertyData]s in the list and returns the deleted rows.
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
  Future<List<FeatureDisplayPropertyData>> delete(
    _is.DatabaseSession session,
    List<FeatureDisplayPropertyData> rows, {
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureDisplayPropertyData>(
      rows,
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureDisplayPropertyData].
  Future<FeatureDisplayPropertyData> deleteRow(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureDisplayPropertyData>(
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
  Future<List<FeatureDisplayPropertyData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable> where,
    _is.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureDisplayPropertyData>(
      where: where(FeatureDisplayPropertyData.t),
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureDisplayPropertyData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureDisplayPropertyDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureDisplayPropertyData>(
      where: where(FeatureDisplayPropertyData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureDisplayPropertyDataAttachRowRepository {
  const FeatureDisplayPropertyDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureDisplayPropertyData] and [ClassFeatureData]
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceClassFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceClassFeature(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData featureDisplayPropertyData,
    _inxbtq9c.ClassFeatureData sourceClassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }
    if (sourceClassFeature.id == null) {
      throw ArgumentError.notNull('sourceClassFeature.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
      sourceClassFeatureId: sourceClassFeature.id,
    );
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featureDisplayPropertyData,
      columns: [FeatureDisplayPropertyData.t.sourceClassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureDisplayPropertyData] and [SubclassFeatureData]
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData featureDisplayPropertyData,
    _i6bcyp7i.SubclassFeatureData sourceSubclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
      sourceSubclassFeatureId: sourceSubclassFeature.id,
    );
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featureDisplayPropertyData,
      columns: [FeatureDisplayPropertyData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }
}

class FeatureDisplayPropertyDataDetachRowRepository {
  const FeatureDisplayPropertyDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureDisplayPropertyData] and the [ClassFeatureData] set in `sourceClassFeature`
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceClassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClassFeature(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData featureDisplayPropertyData, {
    _is.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
      sourceClassFeatureId: null,
    );
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featureDisplayPropertyData,
      columns: [FeatureDisplayPropertyData.t.sourceClassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureDisplayPropertyData] and the [SubclassFeatureData] set in `sourceSubclassFeature`
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceSubclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceSubclassFeature(
    _is.DatabaseSession session,
    FeatureDisplayPropertyData featureDisplayPropertyData, {
    _is.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
      sourceSubclassFeatureId: null,
    );
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featureDisplayPropertyData,
      columns: [FeatureDisplayPropertyData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }
}
