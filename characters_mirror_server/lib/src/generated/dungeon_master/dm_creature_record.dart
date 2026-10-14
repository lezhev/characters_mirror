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

abstract class DmCreatureRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  DmCreatureRecord._({
    this.id,
    required this.userId,
    required this.name,
    required this.sourceType,
    this.sourceVersion,
    this.challengeRating,
    required this.rawJson,
    required this.normalizedJson,
    required this.importHash,
    required this.schemaVersion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DmCreatureRecord({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DmCreatureRecordImpl;

  factory DmCreatureRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return DmCreatureRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
      sourceType: jsonSerialization['sourceType'] as String,
      sourceVersion: jsonSerialization['sourceVersion'] as String?,
      challengeRating: jsonSerialization['challengeRating'] as String?,
      rawJson: jsonSerialization['rawJson'] as String,
      normalizedJson: jsonSerialization['normalizedJson'] as String,
      importHash: jsonSerialization['importHash'] as String,
      schemaVersion: jsonSerialization['schemaVersion'] as int,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = DmCreatureRecordTable();

  static const db = DmCreatureRecordRepository._();

  @override
  int? id;

  int userId;

  String name;

  String sourceType;

  String? sourceVersion;

  String? challengeRating;

  String rawJson;

  String normalizedJson;

  String importHash;

  int schemaVersion;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DmCreatureRecord copyWith({
    int? id,
    int? userId,
    String? name,
    String? sourceType,
    String? sourceVersion,
    String? challengeRating,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'sourceType': sourceType,
      if (sourceVersion != null) 'sourceVersion': sourceVersion,
      if (challengeRating != null) 'challengeRating': challengeRating,
      'rawJson': rawJson,
      'normalizedJson': normalizedJson,
      'importHash': importHash,
      'schemaVersion': schemaVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'sourceType': sourceType,
      if (sourceVersion != null) 'sourceVersion': sourceVersion,
      if (challengeRating != null) 'challengeRating': challengeRating,
      'rawJson': rawJson,
      'normalizedJson': normalizedJson,
      'importHash': importHash,
      'schemaVersion': schemaVersion,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static DmCreatureRecordInclude include() {
    return DmCreatureRecordInclude._();
  }

  static DmCreatureRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    DmCreatureRecordInclude? include,
  }) {
    return DmCreatureRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DmCreatureRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DmCreatureRecordImpl extends DmCreatureRecord {
  _DmCreatureRecordImpl({
    int? id,
    required int userId,
    required String name,
    required String sourceType,
    String? sourceVersion,
    String? challengeRating,
    required String rawJson,
    required String normalizedJson,
    required String importHash,
    required int schemaVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
          sourceType: sourceType,
          sourceVersion: sourceVersion,
          challengeRating: challengeRating,
          rawJson: rawJson,
          normalizedJson: normalizedJson,
          importHash: importHash,
          schemaVersion: schemaVersion,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [DmCreatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DmCreatureRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
    String? sourceType,
    Object? sourceVersion = _Undefined,
    Object? challengeRating = _Undefined,
    String? rawJson,
    String? normalizedJson,
    String? importHash,
    int? schemaVersion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DmCreatureRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      sourceType: sourceType ?? this.sourceType,
      sourceVersion:
          sourceVersion is String? ? sourceVersion : this.sourceVersion,
      challengeRating:
          challengeRating is String? ? challengeRating : this.challengeRating,
      rawJson: rawJson ?? this.rawJson,
      normalizedJson: normalizedJson ?? this.normalizedJson,
      importHash: importHash ?? this.importHash,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class DmCreatureRecordTable extends _i1.Table<int?> {
  DmCreatureRecordTable({super.tableRelation})
      : super(tableName: 'dm_creatures') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    sourceType = _i1.ColumnString(
      'sourceType',
      this,
    );
    sourceVersion = _i1.ColumnString(
      'sourceVersion',
      this,
    );
    challengeRating = _i1.ColumnString(
      'challengeRating',
      this,
    );
    rawJson = _i1.ColumnString(
      'rawJson',
      this,
    );
    normalizedJson = _i1.ColumnString(
      'normalizedJson',
      this,
    );
    importHash = _i1.ColumnString(
      'importHash',
      this,
    );
    schemaVersion = _i1.ColumnInt(
      'schemaVersion',
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString sourceType;

  late final _i1.ColumnString sourceVersion;

  late final _i1.ColumnString challengeRating;

  late final _i1.ColumnString rawJson;

  late final _i1.ColumnString normalizedJson;

  late final _i1.ColumnString importHash;

  late final _i1.ColumnInt schemaVersion;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
        sourceType,
        sourceVersion,
        challengeRating,
        rawJson,
        normalizedJson,
        importHash,
        schemaVersion,
        createdAt,
        updatedAt,
      ];
}

class DmCreatureRecordInclude extends _i1.IncludeObject {
  DmCreatureRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => DmCreatureRecord.t;
}

class DmCreatureRecordIncludeList extends _i1.IncludeList {
  DmCreatureRecordIncludeList._({
    _i1.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DmCreatureRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => DmCreatureRecord.t;
}

class DmCreatureRecordRepository {
  const DmCreatureRecordRepository._();

  /// Returns a list of [DmCreatureRecord]s matching the given query parameters.
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
  Future<List<DmCreatureRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DmCreatureRecord] matching the given query parameters.
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
  Future<DmCreatureRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<DmCreatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DmCreatureRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      orderBy: orderBy?.call(DmCreatureRecord.t),
      orderByList: orderByList?.call(DmCreatureRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DmCreatureRecord] by its [id] or null if no such row exists.
  Future<DmCreatureRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DmCreatureRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DmCreatureRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [DmCreatureRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DmCreatureRecord>> insert(
    _i1.Session session,
    List<DmCreatureRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DmCreatureRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DmCreatureRecord] and returns the inserted row.
  ///
  /// The returned [DmCreatureRecord] will have its `id` field set.
  Future<DmCreatureRecord> insertRow(
    _i1.Session session,
    DmCreatureRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DmCreatureRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DmCreatureRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DmCreatureRecord>> update(
    _i1.Session session,
    List<DmCreatureRecord> rows, {
    _i1.ColumnSelections<DmCreatureRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DmCreatureRecord>(
      rows,
      columns: columns?.call(DmCreatureRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DmCreatureRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DmCreatureRecord> updateRow(
    _i1.Session session,
    DmCreatureRecord row, {
    _i1.ColumnSelections<DmCreatureRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DmCreatureRecord>(
      row,
      columns: columns?.call(DmCreatureRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DmCreatureRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DmCreatureRecord>> delete(
    _i1.Session session,
    List<DmCreatureRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DmCreatureRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DmCreatureRecord].
  Future<DmCreatureRecord> deleteRow(
    _i1.Session session,
    DmCreatureRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DmCreatureRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DmCreatureRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DmCreatureRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DmCreatureRecord>(
      where: where(DmCreatureRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DmCreatureRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DmCreatureRecord>(
      where: where?.call(DmCreatureRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
