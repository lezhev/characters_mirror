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

abstract class Character
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Character._({
    this.id,
    required this.userId,
    required this.name,
  });

  factory Character({
    int? id,
    required int userId,
    required String name,
  }) = _CharacterImpl;

  factory Character.fromJson(Map<String, dynamic> jsonSerialization) {
    return Character(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String,
    );
  }

  static final t = CharacterTable();

  static const db = CharacterRepository._();

  @override
  int? id;

  int userId;

  String name;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Character]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Character copyWith({
    int? id,
    int? userId,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
    };
  }

  static CharacterInclude include() {
    return CharacterInclude._();
  }

  static CharacterIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterTable>? orderByList,
    CharacterInclude? include,
  }) {
    return CharacterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Character.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Character.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterImpl extends Character {
  _CharacterImpl({
    int? id,
    required int userId,
    required String name,
  }) : super._(
          id: id,
          userId: userId,
          name: name,
        );

  /// Returns a shallow copy of this [Character]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Character copyWith({
    Object? id = _Undefined,
    int? userId,
    String? name,
  }) {
    return Character(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }
}

class CharacterTable extends _i1.Table<int?> {
  CharacterTable({super.tableRelation}) : super(tableName: 'character') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
  }

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString name;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        name,
      ];
}

class CharacterInclude extends _i1.IncludeObject {
  CharacterInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Character.t;
}

class CharacterIncludeList extends _i1.IncludeList {
  CharacterIncludeList._({
    _i1.WhereExpressionBuilder<CharacterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Character.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Character.t;
}

class CharacterRepository {
  const CharacterRepository._();

  /// Returns a list of [Character]s matching the given query parameters.
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
  Future<List<Character>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Character>(
      where: where?.call(Character.t),
      orderBy: orderBy?.call(Character.t),
      orderByList: orderByList?.call(Character.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Character] matching the given query parameters.
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
  Future<Character?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Character>(
      where: where?.call(Character.t),
      orderBy: orderBy?.call(Character.t),
      orderByList: orderByList?.call(Character.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Character] by its [id] or null if no such row exists.
  Future<Character?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Character>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Character]s in the list and returns the inserted rows.
  ///
  /// The returned [Character]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Character>> insert(
    _i1.Session session,
    List<Character> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Character>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Character] and returns the inserted row.
  ///
  /// The returned [Character] will have its `id` field set.
  Future<Character> insertRow(
    _i1.Session session,
    Character row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Character>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Character]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Character>> update(
    _i1.Session session,
    List<Character> rows, {
    _i1.ColumnSelections<CharacterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Character>(
      rows,
      columns: columns?.call(Character.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Character]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Character> updateRow(
    _i1.Session session,
    Character row, {
    _i1.ColumnSelections<CharacterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Character>(
      row,
      columns: columns?.call(Character.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Character]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Character>> delete(
    _i1.Session session,
    List<Character> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Character>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Character].
  Future<Character> deleteRow(
    _i1.Session session,
    Character row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Character>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Character>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Character>(
      where: where(Character.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Character>(
      where: where?.call(Character.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
