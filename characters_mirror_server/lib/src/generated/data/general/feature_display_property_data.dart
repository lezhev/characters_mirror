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
import '../../enums/feature_display_property_value_kind.dart' as _i4;

abstract class FeatureDisplayPropertyData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _i4.FeatureDisplayPropertyValueKind valueKind,
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
      Map<String, dynamic> jsonSerialization) {
    return FeatureDisplayPropertyData(
      id: jsonSerialization['id'] as int?,
      sourceClassFeatureId: jsonSerialization['sourceClassFeatureId'] as int?,
      sourceClassFeature: jsonSerialization['sourceClassFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['sourceClassFeature']
                  as Map<String, dynamic>)),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['sourceSubclassFeature']
                  as Map<String, dynamic>)),
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      valueKind: _i4.FeatureDisplayPropertyValueKind.fromJson(
          (jsonSerialization['valueKind'] as String)),
      staticValue: jsonSerialization['staticValue'] as String?,
      progression: (jsonSerialization['progression'] as List?)
          ?.fold<Map<int, String>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as String}),
      formula: jsonSerialization['formula'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = FeatureDisplayPropertyDataTable();

  static const db = FeatureDisplayPropertyDataRepository._();

  @override
  int? id;

  int? sourceClassFeatureId;

  _i2.ClassFeatureData? sourceClassFeature;

  int? sourceSubclassFeatureId;

  _i3.SubclassFeatureData? sourceSubclassFeature;

  String key;

  String label;

  _i4.FeatureDisplayPropertyValueKind valueKind;

  String? staticValue;

  Map<int, String>? progression;

  String? formula;

  int? sortOrder;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureDisplayPropertyData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureDisplayPropertyData copyWith({
    int? id,
    int? sourceClassFeatureId,
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    String? key,
    String? label,
    _i4.FeatureDisplayPropertyValueKind? valueKind,
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
    _i2.ClassFeatureDataInclude? sourceClassFeature,
    _i3.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    return FeatureDisplayPropertyDataInclude._(
      sourceClassFeature: sourceClassFeature,
      sourceSubclassFeature: sourceSubclassFeature,
    );
  }

  static FeatureDisplayPropertyDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    FeatureDisplayPropertyDataInclude? include,
  }) {
    return FeatureDisplayPropertyDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureDisplayPropertyDataImpl extends FeatureDisplayPropertyData {
  _FeatureDisplayPropertyDataImpl({
    int? id,
    int? sourceClassFeatureId,
    _i2.ClassFeatureData? sourceClassFeature,
    int? sourceSubclassFeatureId,
    _i3.SubclassFeatureData? sourceSubclassFeature,
    required String key,
    required String label,
    required _i4.FeatureDisplayPropertyValueKind valueKind,
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
  @_i1.useResult
  @override
  FeatureDisplayPropertyData copyWith({
    Object? id = _Undefined,
    Object? sourceClassFeatureId = _Undefined,
    Object? sourceClassFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    String? key,
    String? label,
    _i4.FeatureDisplayPropertyValueKind? valueKind,
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
      sourceClassFeature: sourceClassFeature is _i2.ClassFeatureData?
          ? sourceClassFeature
          : this.sourceClassFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature: sourceSubclassFeature is _i3.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      key: key ?? this.key,
      label: label ?? this.label,
      valueKind: valueKind ?? this.valueKind,
      staticValue: staticValue is String? ? staticValue : this.staticValue,
      progression: progression is Map<int, String>?
          ? progression
          : this.progression?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      formula: formula is String? ? formula : this.formula,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureDisplayPropertyDataTable extends _i1.Table<int?> {
  FeatureDisplayPropertyDataTable({super.tableRelation})
      : super(tableName: 'feature_display_property_data') {
    sourceClassFeatureId = _i1.ColumnInt(
      'sourceClassFeatureId',
      this,
    );
    sourceSubclassFeatureId = _i1.ColumnInt(
      'sourceSubclassFeatureId',
      this,
    );
    key = _i1.ColumnString(
      'key',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    valueKind = _i1.ColumnEnum(
      'valueKind',
      this,
      _i1.EnumSerialization.byName,
    );
    staticValue = _i1.ColumnString(
      'staticValue',
      this,
    );
    progression = _i1.ColumnSerializable(
      'progression',
      this,
    );
    formula = _i1.ColumnString(
      'formula',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt sourceClassFeatureId;

  _i2.ClassFeatureDataTable? _sourceClassFeature;

  late final _i1.ColumnInt sourceSubclassFeatureId;

  _i3.SubclassFeatureDataTable? _sourceSubclassFeature;

  late final _i1.ColumnString key;

  late final _i1.ColumnString label;

  late final _i1.ColumnEnum<_i4.FeatureDisplayPropertyValueKind> valueKind;

  late final _i1.ColumnString staticValue;

  late final _i1.ColumnSerializable progression;

  late final _i1.ColumnString formula;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassFeatureDataTable get sourceClassFeature {
    if (_sourceClassFeature != null) return _sourceClassFeature!;
    _sourceClassFeature = _i1.createRelationTable(
      relationFieldName: 'sourceClassFeature',
      field: FeatureDisplayPropertyData.t.sourceClassFeatureId,
      foreignField: _i2.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClassFeature!;
  }

  _i3.SubclassFeatureDataTable get sourceSubclassFeature {
    if (_sourceSubclassFeature != null) return _sourceSubclassFeature!;
    _sourceSubclassFeature = _i1.createRelationTable(
      relationFieldName: 'sourceSubclassFeature',
      field: FeatureDisplayPropertyData.t.sourceSubclassFeatureId,
      foreignField: _i3.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceSubclassFeature!;
  }

  @override
  List<_i1.Column> get columns => [
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
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'sourceClassFeature') {
      return sourceClassFeature;
    }
    if (relationField == 'sourceSubclassFeature') {
      return sourceSubclassFeature;
    }
    return null;
  }
}

class FeatureDisplayPropertyDataInclude extends _i1.IncludeObject {
  FeatureDisplayPropertyDataInclude._({
    _i2.ClassFeatureDataInclude? sourceClassFeature,
    _i3.SubclassFeatureDataInclude? sourceSubclassFeature,
  }) {
    _sourceClassFeature = sourceClassFeature;
    _sourceSubclassFeature = sourceSubclassFeature;
  }

  _i2.ClassFeatureDataInclude? _sourceClassFeature;

  _i3.SubclassFeatureDataInclude? _sourceSubclassFeature;

  @override
  Map<String, _i1.Include?> get includes => {
        'sourceClassFeature': _sourceClassFeature,
        'sourceSubclassFeature': _sourceSubclassFeature,
      };

  @override
  _i1.Table<int?> get table => FeatureDisplayPropertyData.t;
}

class FeatureDisplayPropertyDataIncludeList extends _i1.IncludeList {
  FeatureDisplayPropertyDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureDisplayPropertyData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureDisplayPropertyData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
  }) async {
    return session.db.find<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureDisplayPropertyDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureDisplayPropertyDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
  }) async {
    return session.db.findFirstRow<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      orderBy: orderBy?.call(FeatureDisplayPropertyData.t),
      orderByList: orderByList?.call(FeatureDisplayPropertyData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FeatureDisplayPropertyData] by its [id] or null if no such row exists.
  Future<FeatureDisplayPropertyData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FeatureDisplayPropertyDataInclude? include,
  }) async {
    return session.db.findById<FeatureDisplayPropertyData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FeatureDisplayPropertyData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureDisplayPropertyData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureDisplayPropertyData>> insert(
    _i1.Session session,
    List<FeatureDisplayPropertyData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureDisplayPropertyData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureDisplayPropertyData] and returns the inserted row.
  ///
  /// The returned [FeatureDisplayPropertyData] will have its `id` field set.
  Future<FeatureDisplayPropertyData> insertRow(
    _i1.Session session,
    FeatureDisplayPropertyData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureDisplayPropertyData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureDisplayPropertyData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureDisplayPropertyData>> update(
    _i1.Session session,
    List<FeatureDisplayPropertyData> rows, {
    _i1.ColumnSelections<FeatureDisplayPropertyDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureDisplayPropertyData>(
      rows,
      columns: columns?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureDisplayPropertyData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureDisplayPropertyData> updateRow(
    _i1.Session session,
    FeatureDisplayPropertyData row, {
    _i1.ColumnSelections<FeatureDisplayPropertyDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureDisplayPropertyData>(
      row,
      columns: columns?.call(FeatureDisplayPropertyData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureDisplayPropertyData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureDisplayPropertyData>> delete(
    _i1.Session session,
    List<FeatureDisplayPropertyData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureDisplayPropertyData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureDisplayPropertyData].
  Future<FeatureDisplayPropertyData> deleteRow(
    _i1.Session session,
    FeatureDisplayPropertyData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureDisplayPropertyData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureDisplayPropertyData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureDisplayPropertyData>(
      where: where(FeatureDisplayPropertyData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureDisplayPropertyDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureDisplayPropertyData>(
      where: where?.call(FeatureDisplayPropertyData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FeatureDisplayPropertyDataAttachRowRepository {
  const FeatureDisplayPropertyDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureDisplayPropertyData] and [ClassFeatureData]
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceClassFeatureId` to refer to the [ClassFeatureData].
  Future<void> sourceClassFeature(
    _i1.Session session,
    FeatureDisplayPropertyData featureDisplayPropertyData,
    _i2.ClassFeatureData sourceClassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }
    if (sourceClassFeature.id == null) {
      throw ArgumentError.notNull('sourceClassFeature.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
        sourceClassFeatureId: sourceClassFeature.id);
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featureDisplayPropertyData,
      columns: [FeatureDisplayPropertyData.t.sourceClassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureDisplayPropertyData] and [SubclassFeatureData]
  /// by setting the [FeatureDisplayPropertyData]'s foreign key `sourceSubclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> sourceSubclassFeature(
    _i1.Session session,
    FeatureDisplayPropertyData featureDisplayPropertyData,
    _i3.SubclassFeatureData sourceSubclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureDisplayPropertyData.id == null) {
      throw ArgumentError.notNull('featureDisplayPropertyData.id');
    }
    if (sourceSubclassFeature.id == null) {
      throw ArgumentError.notNull('sourceSubclassFeature.id');
    }

    var $featureDisplayPropertyData = featureDisplayPropertyData.copyWith(
        sourceSubclassFeatureId: sourceSubclassFeature.id);
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
    _i1.Session session,
    FeatureDisplayPropertyData featuredisplaypropertydata, {
    _i1.Transaction? transaction,
  }) async {
    if (featuredisplaypropertydata.id == null) {
      throw ArgumentError.notNull('featuredisplaypropertydata.id');
    }

    var $featuredisplaypropertydata =
        featuredisplaypropertydata.copyWith(sourceClassFeatureId: null);
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featuredisplaypropertydata,
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
    _i1.Session session,
    FeatureDisplayPropertyData featuredisplaypropertydata, {
    _i1.Transaction? transaction,
  }) async {
    if (featuredisplaypropertydata.id == null) {
      throw ArgumentError.notNull('featuredisplaypropertydata.id');
    }

    var $featuredisplaypropertydata =
        featuredisplaypropertydata.copyWith(sourceSubclassFeatureId: null);
    await session.db.updateRow<FeatureDisplayPropertyData>(
      $featuredisplaypropertydata,
      columns: [FeatureDisplayPropertyData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }
}
