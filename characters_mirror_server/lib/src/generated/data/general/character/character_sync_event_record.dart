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

abstract class CharacterSyncEventRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterSyncEventRecord._({
    this.id,
    required this.userId,
    required this.characterId,
    this.characterVersion,
    required this.eventType,
    this.changeId,
    required this.createdAt,
  });

  factory CharacterSyncEventRecord({
    int? id,
    required int userId,
    required int characterId,
    int? characterVersion,
    required String eventType,
    String? changeId,
    required DateTime createdAt,
  }) = _CharacterSyncEventRecordImpl;

  factory CharacterSyncEventRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSyncEventRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      characterId: jsonSerialization['characterId'] as int,
      characterVersion: jsonSerialization['characterVersion'] as int?,
      eventType: jsonSerialization['eventType'] as String,
      changeId: jsonSerialization['changeId'] as String?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CharacterSyncEventRecordTable();

  static const db = CharacterSyncEventRecordRepository._();

  @override
  int? id;

  int userId;

  int characterId;

  int? characterVersion;

  String eventType;

  String? changeId;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSyncEventRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSyncEventRecord copyWith({
    int? id,
    int? userId,
    int? characterId,
    int? characterVersion,
    String? eventType,
    String? changeId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'characterId': characterId,
      if (characterVersion != null) 'characterVersion': characterVersion,
      'eventType': eventType,
      if (changeId != null) 'changeId': changeId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterSyncEventRecordInclude include() {
    return CharacterSyncEventRecordInclude._();
  }

  static CharacterSyncEventRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    CharacterSyncEventRecordInclude? include,
  }) {
    return CharacterSyncEventRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncEventRecordImpl extends CharacterSyncEventRecord {
  _CharacterSyncEventRecordImpl({
    int? id,
    required int userId,
    required int characterId,
    int? characterVersion,
    required String eventType,
    String? changeId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          characterId: characterId,
          characterVersion: characterVersion,
          eventType: eventType,
          changeId: changeId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [CharacterSyncEventRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSyncEventRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    int? characterId,
    Object? characterVersion = _Undefined,
    String? eventType,
    Object? changeId = _Undefined,
    DateTime? createdAt,
  }) {
    return CharacterSyncEventRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      characterId: characterId ?? this.characterId,
      characterVersion:
          characterVersion is int? ? characterVersion : this.characterVersion,
      eventType: eventType ?? this.eventType,
      changeId: changeId is String? ? changeId : this.changeId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CharacterSyncEventRecordTable extends _i1.Table<int?> {
  CharacterSyncEventRecordTable({super.tableRelation})
      : super(tableName: 'character_sync_events') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    characterVersion = _i1.ColumnInt(
      'characterVersion',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    changeId = _i1.ColumnString(
      'changeId',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt characterId;

  late final _i1.ColumnInt characterVersion;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnString changeId;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        characterId,
        characterVersion,
        eventType,
        changeId,
        createdAt,
      ];
}

class CharacterSyncEventRecordInclude extends _i1.IncludeObject {
  CharacterSyncEventRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CharacterSyncEventRecord.t;
}

class CharacterSyncEventRecordIncludeList extends _i1.IncludeList {
  CharacterSyncEventRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSyncEventRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterSyncEventRecord.t;
}

class CharacterSyncEventRecordRepository {
  const CharacterSyncEventRecordRepository._();

  /// Returns a list of [CharacterSyncEventRecord]s matching the given query parameters.
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
  Future<List<CharacterSyncEventRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CharacterSyncEventRecord] matching the given query parameters.
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
  Future<CharacterSyncEventRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterSyncEventRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSyncEventRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      orderBy: orderBy?.call(CharacterSyncEventRecord.t),
      orderByList: orderByList?.call(CharacterSyncEventRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CharacterSyncEventRecord] by its [id] or null if no such row exists.
  Future<CharacterSyncEventRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CharacterSyncEventRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CharacterSyncEventRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSyncEventRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterSyncEventRecord>> insert(
    _i1.Session session,
    List<CharacterSyncEventRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterSyncEventRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterSyncEventRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSyncEventRecord] will have its `id` field set.
  Future<CharacterSyncEventRecord> insertRow(
    _i1.Session session,
    CharacterSyncEventRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSyncEventRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSyncEventRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterSyncEventRecord>> update(
    _i1.Session session,
    List<CharacterSyncEventRecord> rows, {
    _i1.ColumnSelections<CharacterSyncEventRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterSyncEventRecord>(
      rows,
      columns: columns?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSyncEventRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSyncEventRecord> updateRow(
    _i1.Session session,
    CharacterSyncEventRecord row, {
    _i1.ColumnSelections<CharacterSyncEventRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSyncEventRecord>(
      row,
      columns: columns?.call(CharacterSyncEventRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterSyncEventRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterSyncEventRecord>> delete(
    _i1.Session session,
    List<CharacterSyncEventRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterSyncEventRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterSyncEventRecord].
  Future<CharacterSyncEventRecord> deleteRow(
    _i1.Session session,
    CharacterSyncEventRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSyncEventRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterSyncEventRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterSyncEventRecord>(
      where: where(CharacterSyncEventRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSyncEventRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSyncEventRecord>(
      where: where?.call(CharacterSyncEventRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
