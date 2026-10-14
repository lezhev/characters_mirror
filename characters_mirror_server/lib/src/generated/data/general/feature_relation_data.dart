/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../enums/character_feature_source_type.dart' as _i2;
import '../../enums/feature_relation_type.dart' as _i3;

abstract class FeatureRelationData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureRelationData._({
    this.id,
    required this.sourceType,
    required this.sourceReferenceKey,
    required this.targetType,
    required this.targetReferenceKey,
    required this.relationType,
    this.propertyMappings,
    required this.priority,
    this.mergeDisplay,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory FeatureRelationData({
    int? id,
    required _i2.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _i2.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i3.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _FeatureRelationDataImpl;

  factory FeatureRelationData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatureRelationData(
      id: jsonSerialization['id'] as int?,
      sourceType: _i2.CharacterFeatureSourceType.fromJson(
          (jsonSerialization['sourceType'] as String)),
      sourceReferenceKey: jsonSerialization['sourceReferenceKey'] as String,
      targetType: _i2.CharacterFeatureSourceType.fromJson(
          (jsonSerialization['targetType'] as String)),
      targetReferenceKey: jsonSerialization['targetReferenceKey'] as String,
      relationType: _i3.FeatureRelationType.fromJson(
          (jsonSerialization['relationType'] as String)),
      propertyMappings: (jsonSerialization['propertyMappings'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
      priority: jsonSerialization['priority'] as int,
      mergeDisplay: jsonSerialization['mergeDisplay'] as bool?,
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

  static final t = FeatureRelationDataTable();

  static const db = FeatureRelationDataRepository._();

  @override
  int? id;

  _i2.CharacterFeatureSourceType sourceType;

  String sourceReferenceKey;

  _i2.CharacterFeatureSourceType targetType;

  String targetReferenceKey;

  _i3.FeatureRelationType relationType;

  Map<String, String>? propertyMappings;

  int priority;

  bool? mergeDisplay;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureRelationData copyWith({
    int? id,
    _i2.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _i2.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i3.FeatureRelationType? relationType,
    Map<String, String>? propertyMappings,
    int? priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
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
      'sourceType': sourceType.toJson(),
      'sourceReferenceKey': sourceReferenceKey,
      'targetType': targetType.toJson(),
      'targetReferenceKey': targetReferenceKey,
      'relationType': relationType.toJson(),
      if (propertyMappings != null)
        'propertyMappings': propertyMappings?.toJson(),
      'priority': priority,
      if (mergeDisplay != null) 'mergeDisplay': mergeDisplay,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static FeatureRelationDataInclude include() {
    return FeatureRelationDataInclude._();
  }

  static FeatureRelationDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    FeatureRelationDataInclude? include,
  }) {
    return FeatureRelationDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureRelationData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureRelationDataImpl extends FeatureRelationData {
  _FeatureRelationDataImpl({
    int? id,
    required _i2.CharacterFeatureSourceType sourceType,
    required String sourceReferenceKey,
    required _i2.CharacterFeatureSourceType targetType,
    required String targetReferenceKey,
    required _i3.FeatureRelationType relationType,
    Map<String, String>? propertyMappings,
    required int priority,
    bool? mergeDisplay,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          sourceType: sourceType,
          sourceReferenceKey: sourceReferenceKey,
          targetType: targetType,
          targetReferenceKey: targetReferenceKey,
          relationType: relationType,
          propertyMappings: propertyMappings,
          priority: priority,
          mergeDisplay: mergeDisplay,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [FeatureRelationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureRelationData copyWith({
    Object? id = _Undefined,
    _i2.CharacterFeatureSourceType? sourceType,
    String? sourceReferenceKey,
    _i2.CharacterFeatureSourceType? targetType,
    String? targetReferenceKey,
    _i3.FeatureRelationType? relationType,
    Object? propertyMappings = _Undefined,
    int? priority,
    Object? mergeDisplay = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return FeatureRelationData(
      id: id is int? ? id : this.id,
      sourceType: sourceType ?? this.sourceType,
      sourceReferenceKey: sourceReferenceKey ?? this.sourceReferenceKey,
      targetType: targetType ?? this.targetType,
      targetReferenceKey: targetReferenceKey ?? this.targetReferenceKey,
      relationType: relationType ?? this.relationType,
      propertyMappings: propertyMappings is Map<String, String>?
          ? propertyMappings
          : this.propertyMappings?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      priority: priority ?? this.priority,
      mergeDisplay: mergeDisplay is bool? ? mergeDisplay : this.mergeDisplay,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class FeatureRelationDataTable extends _i1.Table<int?> {
  FeatureRelationDataTable({super.tableRelation})
      : super(tableName: 'feature_relation_data') {
    sourceType = _i1.ColumnEnum(
      'sourceType',
      this,
      _i1.EnumSerialization.byName,
    );
    sourceReferenceKey = _i1.ColumnString(
      'sourceReferenceKey',
      this,
    );
    targetType = _i1.ColumnEnum(
      'targetType',
      this,
      _i1.EnumSerialization.byName,
    );
    targetReferenceKey = _i1.ColumnString(
      'targetReferenceKey',
      this,
    );
    relationType = _i1.ColumnEnum(
      'relationType',
      this,
      _i1.EnumSerialization.byName,
    );
    propertyMappings = _i1.ColumnSerializable(
      'propertyMappings',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
    );
    mergeDisplay = _i1.ColumnBool(
      'mergeDisplay',
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

  late final _i1.ColumnEnum<_i2.CharacterFeatureSourceType> sourceType;

  late final _i1.ColumnString sourceReferenceKey;

  late final _i1.ColumnEnum<_i2.CharacterFeatureSourceType> targetType;

  late final _i1.ColumnString targetReferenceKey;

  late final _i1.ColumnEnum<_i3.FeatureRelationType> relationType;

  late final _i1.ColumnSerializable propertyMappings;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnBool mergeDisplay;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        sourceType,
        sourceReferenceKey,
        targetType,
        targetReferenceKey,
        relationType,
        propertyMappings,
        priority,
        mergeDisplay,
        source,
        version,
        createdAt,
        updatedAt,
      ];
}

class FeatureRelationDataInclude extends _i1.IncludeObject {
  FeatureRelationDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FeatureRelationData.t;
}

class FeatureRelationDataIncludeList extends _i1.IncludeList {
  FeatureRelationDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureRelationData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureRelationData.t;
}

class FeatureRelationDataRepository {
  const FeatureRelationDataRepository._();

  /// Returns a list of [FeatureRelationData]s matching the given query parameters.
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
  Future<List<FeatureRelationData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FeatureRelationData] matching the given query parameters.
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
  Future<FeatureRelationData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureRelationDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureRelationDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      orderBy: orderBy?.call(FeatureRelationData.t),
      orderByList: orderByList?.call(FeatureRelationData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FeatureRelationData] by its [id] or null if no such row exists.
  Future<FeatureRelationData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FeatureRelationData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FeatureRelationData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureRelationData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureRelationData>> insert(
    _i1.Session session,
    List<FeatureRelationData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureRelationData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureRelationData] and returns the inserted row.
  ///
  /// The returned [FeatureRelationData] will have its `id` field set.
  Future<FeatureRelationData> insertRow(
    _i1.Session session,
    FeatureRelationData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureRelationData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureRelationData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureRelationData>> update(
    _i1.Session session,
    List<FeatureRelationData> rows, {
    _i1.ColumnSelections<FeatureRelationDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureRelationData>(
      rows,
      columns: columns?.call(FeatureRelationData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureRelationData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureRelationData> updateRow(
    _i1.Session session,
    FeatureRelationData row, {
    _i1.ColumnSelections<FeatureRelationDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureRelationData>(
      row,
      columns: columns?.call(FeatureRelationData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureRelationData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureRelationData>> delete(
    _i1.Session session,
    List<FeatureRelationData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureRelationData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureRelationData].
  Future<FeatureRelationData> deleteRow(
    _i1.Session session,
    FeatureRelationData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureRelationData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureRelationData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatureRelationDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureRelationData>(
      where: where(FeatureRelationData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureRelationDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureRelationData>(
      where: where?.call(FeatureRelationData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
