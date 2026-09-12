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

abstract class CharacterAppliedChangeRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterAppliedChangeRecord._({
    this.id,
    required this.userId,
    required this.changeId,
    this.characterId,
    this.revision,
    required this.createdAt,
  });

  factory CharacterAppliedChangeRecord({
    int? id,
    required int userId,
    required String changeId,
    int? characterId,
    int? revision,
    required DateTime createdAt,
  }) = _CharacterAppliedChangeRecordImpl;

  factory CharacterAppliedChangeRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterAppliedChangeRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      changeId: jsonSerialization['changeId'] as String,
      characterId: jsonSerialization['characterId'] as int?,
      revision: jsonSerialization['revision'] as int?,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = CharacterAppliedChangeRecordTable();

  static const db = CharacterAppliedChangeRecordRepository._();

  @override
  int? id;

  int userId;

  String changeId;

  int? characterId;

  int? revision;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterAppliedChangeRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterAppliedChangeRecord copyWith({
    int? id,
    int? userId,
    String? changeId,
    int? characterId,
    int? revision,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'changeId': changeId,
      if (characterId != null) 'characterId': characterId,
      if (revision != null) 'revision': revision,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterAppliedChangeRecordInclude include() {
    return CharacterAppliedChangeRecordInclude._();
  }

  static CharacterAppliedChangeRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    CharacterAppliedChangeRecordInclude? include,
  }) {
    return CharacterAppliedChangeRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterAppliedChangeRecordImpl extends CharacterAppliedChangeRecord {
  _CharacterAppliedChangeRecordImpl({
    int? id,
    required int userId,
    required String changeId,
    int? characterId,
    int? revision,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          changeId: changeId,
          characterId: characterId,
          revision: revision,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [CharacterAppliedChangeRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterAppliedChangeRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    String? changeId,
    Object? characterId = _Undefined,
    Object? revision = _Undefined,
    DateTime? createdAt,
  }) {
    return CharacterAppliedChangeRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      changeId: changeId ?? this.changeId,
      characterId: characterId is int? ? characterId : this.characterId,
      revision: revision is int? ? revision : this.revision,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CharacterAppliedChangeRecordTable extends _i1.Table<int?> {
  CharacterAppliedChangeRecordTable({super.tableRelation})
      : super(tableName: 'character_applied_changes') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    changeId = _i1.ColumnString(
      'changeId',
      this,
    );
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    revision = _i1.ColumnInt(
      'revision',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString changeId;

  late final _i1.ColumnInt characterId;

  late final _i1.ColumnInt revision;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        changeId,
        characterId,
        revision,
        createdAt,
      ];
}

class CharacterAppliedChangeRecordInclude extends _i1.IncludeObject {
  CharacterAppliedChangeRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CharacterAppliedChangeRecord.t;
}

class CharacterAppliedChangeRecordIncludeList extends _i1.IncludeList {
  CharacterAppliedChangeRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterAppliedChangeRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterAppliedChangeRecord.t;
}

class CharacterAppliedChangeRecordRepository {
  const CharacterAppliedChangeRecordRepository._();

  /// Returns a list of [CharacterAppliedChangeRecord]s matching the given query parameters.
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
  Future<List<CharacterAppliedChangeRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [CharacterAppliedChangeRecord] matching the given query parameters.
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
  Future<CharacterAppliedChangeRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterAppliedChangeRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterAppliedChangeRecordTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      orderBy: orderBy?.call(CharacterAppliedChangeRecord.t),
      orderByList: orderByList?.call(CharacterAppliedChangeRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [CharacterAppliedChangeRecord] by its [id] or null if no such row exists.
  Future<CharacterAppliedChangeRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<CharacterAppliedChangeRecord>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [CharacterAppliedChangeRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterAppliedChangeRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterAppliedChangeRecord>> insert(
    _i1.Session session,
    List<CharacterAppliedChangeRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterAppliedChangeRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterAppliedChangeRecord] and returns the inserted row.
  ///
  /// The returned [CharacterAppliedChangeRecord] will have its `id` field set.
  Future<CharacterAppliedChangeRecord> insertRow(
    _i1.Session session,
    CharacterAppliedChangeRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterAppliedChangeRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterAppliedChangeRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterAppliedChangeRecord>> update(
    _i1.Session session,
    List<CharacterAppliedChangeRecord> rows, {
    _i1.ColumnSelections<CharacterAppliedChangeRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterAppliedChangeRecord>(
      rows,
      columns: columns?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterAppliedChangeRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterAppliedChangeRecord> updateRow(
    _i1.Session session,
    CharacterAppliedChangeRecord row, {
    _i1.ColumnSelections<CharacterAppliedChangeRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterAppliedChangeRecord>(
      row,
      columns: columns?.call(CharacterAppliedChangeRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterAppliedChangeRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterAppliedChangeRecord>> delete(
    _i1.Session session,
    List<CharacterAppliedChangeRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterAppliedChangeRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterAppliedChangeRecord].
  Future<CharacterAppliedChangeRecord> deleteRow(
    _i1.Session session,
    CharacterAppliedChangeRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterAppliedChangeRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterAppliedChangeRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterAppliedChangeRecord>(
      where: where(CharacterAppliedChangeRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterAppliedChangeRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterAppliedChangeRecord>(
      where: where?.call(CharacterAppliedChangeRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
