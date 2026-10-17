/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/feature_tag.dart' as _ij7cgcpq;

abstract class FeatData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeatData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.traits,
    this.tags,
    this.specialAbilities,
    this.proficiencies,
    this.prerequisites,
  });

  factory FeatData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_ij7cgcpq.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) = _FeatDataImpl;

  factory FeatData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      abilityBonuses: jsonSerialization['abilityBonuses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['abilityBonuses'],
            ),
      traits: jsonSerialization['traits'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['traits'],
            ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ij7cgcpq.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      specialAbilities: jsonSerialization['specialAbilities'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['specialAbilities'],
            ),
      proficiencies: jsonSerialization['proficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['proficiencies'],
            ),
      prerequisites: jsonSerialization['prerequisites'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['prerequisites'],
            ),
    );
  }

  static final t = FeatDataTable();

  static const db = FeatDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<_ij7cgcpq.FeatureTag>? tags;

  List<String>? specialAbilities;

  List<String>? proficiencies;

  Map<String, int>? prerequisites;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_ij7cgcpq.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  static FeatDataInclude include() {
    return FeatDataInclude._();
  }

  static FeatDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    FeatDataInclude? include,
  }) {
    return FeatDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatDataImpl extends FeatData {
  _FeatDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<_ij7cgcpq.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) : super._(
         id: id,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         abilityBonuses: abilityBonuses,
         traits: traits,
         tags: tags,
         specialAbilities: specialAbilities,
         proficiencies: proficiencies,
         prerequisites: prerequisites,
       );

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? tags = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? proficiencies = _Undefined,
    Object? prerequisites = _Undefined,
  }) {
    return FeatData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      abilityBonuses: abilityBonuses is Map<String, int>?
          ? abilityBonuses
          : this.abilityBonuses?.map((key0, value0) => MapEntry(key0, value0)),
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      tags: tags is List<_ij7cgcpq.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      prerequisites: prerequisites is Map<String, int>?
          ? prerequisites
          : this.prerequisites?.map((key0, value0) => MapEntry(key0, value0)),
    );
  }
}

class FeatDataUpdateTable extends _is.UpdateTable<FeatDataTable> {
  FeatDataUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> abilityBonuses(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.abilityBonuses, value);

  _is.ColumnValue<List<String>, List<String>> traits(List<String>? value) =>
      _is.ColumnValue(table.traits, value);

  _is.ColumnValue<List<_ij7cgcpq.FeatureTag>, List<_ij7cgcpq.FeatureTag>> tags(
    List<_ij7cgcpq.FeatureTag>? value,
  ) => _is.ColumnValue(table.tags, value);

  _is.ColumnValue<List<String>, List<String>> specialAbilities(
    List<String>? value,
  ) => _is.ColumnValue(table.specialAbilities, value);

  _is.ColumnValue<List<String>, List<String>> proficiencies(
    List<String>? value,
  ) => _is.ColumnValue(table.proficiencies, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> prerequisites(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.prerequisites, value);
}

class FeatDataTable extends _is.Table<int?> {
  FeatDataTable({super.tableRelation}) : super(tableName: 'feat_data') {
    updateTable = FeatDataUpdateTable(this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    abilityBonuses = _is.ColumnSerializable<Map<String, int>>(
      'abilityBonuses',
      this,
    );
    traits = _is.ColumnSerializable<List<String>>('traits', this);
    tags = _is.ColumnSerializable<List<_ij7cgcpq.FeatureTag>>('tags', this);
    specialAbilities = _is.ColumnSerializable<List<String>>(
      'specialAbilities',
      this,
    );
    proficiencies = _is.ColumnSerializable<List<String>>('proficiencies', this);
    prerequisites = _is.ColumnSerializable<Map<String, int>>(
      'prerequisites',
      this,
    );
  }

  late final FeatDataUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnSerializable<Map<String, int>> abilityBonuses;

  late final _is.ColumnSerializable<List<String>> traits;

  late final _is.ColumnSerializable<List<_ij7cgcpq.FeatureTag>> tags;

  late final _is.ColumnSerializable<List<String>> specialAbilities;

  late final _is.ColumnSerializable<List<String>> proficiencies;

  late final _is.ColumnSerializable<Map<String, int>> prerequisites;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    description,
    source,
    version,
    createdAt,
    updatedAt,
    abilityBonuses,
    traits,
    tags,
    specialAbilities,
    proficiencies,
    prerequisites,
  ];
}

class FeatDataInclude extends _is.IncludeObject {
  FeatDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeatData.t;
}

class FeatDataIncludeList extends _is.IncludeList {
  FeatDataIncludeList._({
    _is.WhereExpressionBuilder<FeatDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatData.t;
}

class FeatDataRepository {
  const FeatDataRepository._();

  /// Returns a list of [FeatData]s matching the given query parameters.
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
  Future<List<FeatData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatData>(
      where: where?.call(FeatData.t),
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeatData] matching the given query parameters.
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
  Future<FeatData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatData>(
      where: where?.call(FeatData.t),
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatData] by its [id] or null if no such row exists.
  Future<FeatData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatData]s will have their `id` fields set.
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
  Future<List<FeatData>> insert(
    _is.DatabaseSession session,
    List<FeatData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatData] and returns the inserted row.
  ///
  /// The returned [FeatData] will have its `id` field set.
  Future<FeatData> insertRow(
    _is.DatabaseSession session,
    FeatData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatData>(row, transaction: transaction);
  }

  /// Upserts all [FeatData]s in the list and returns the resulting rows.
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
  /// The returned [FeatData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatData>> upsert(
    _is.DatabaseSession session,
    List<FeatData> rows, {
    required _is.ColumnSelections<FeatDataTable> conflictColumns,
    _is.ColumnSelections<FeatDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatData>(
      rows,
      conflictColumns: conflictColumns(FeatData.t),
      updateColumns: updateColumns?.call(FeatData.t),
      updateWhere: updateWhere?.call(FeatData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatData] and returns the resulting row.
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
  /// The returned [FeatData] will have its `id` field set.
  Future<FeatData?> upsertRow(
    _is.DatabaseSession session,
    FeatData row, {
    required _is.ColumnSelections<FeatDataTable> conflictColumns,
    _is.ColumnSelections<FeatDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatData>(
      row,
      conflictColumns: conflictColumns(FeatData.t),
      updateColumns: updateColumns?.call(FeatData.t),
      updateWhere: updateWhere?.call(FeatData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatData>> update(
    _is.DatabaseSession session,
    List<FeatData> rows, {
    _is.ColumnSelections<FeatDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatData>(
      rows,
      columns: columns?.call(FeatData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatData> updateRow(
    _is.DatabaseSession session,
    FeatData row, {
    _is.ColumnSelections<FeatDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatData>(
      row,
      columns: columns?.call(FeatData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeatDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatData>(
      id,
      columnValues: columnValues(FeatData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeatDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeatDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatData>(
      columnValues: columnValues(FeatData.t.updateTable),
      where: where(FeatData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatData]s in the list and returns the deleted rows.
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
  Future<List<FeatData>> delete(
    _is.DatabaseSession session,
    List<FeatData> rows, {
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatData>(
      rows,
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatData].
  Future<FeatData> deleteRow(
    _is.DatabaseSession session,
    FeatData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatDataTable> where,
    _is.OrderByBuilder<FeatDataTable>? orderBy,
    _is.OrderByListBuilder<FeatDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatData>(
      where: where(FeatData.t),
      orderBy: orderBy?.call(FeatData.t),
      orderByList: orderByList?.call(FeatData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatData>(
      where: where?.call(FeatData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatData>(
      where: where(FeatData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
