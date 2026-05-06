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

abstract class SpellSlotProgressionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SpellSlotProgressionData._({
    this.id,
    this.tableKey,
    required this.level,
    this.spellSlots,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory SpellSlotProgressionData({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpellSlotProgressionDataImpl;

  factory SpellSlotProgressionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellSlotProgressionData(
      id: jsonSerialization['id'] as int?,
      tableKey: jsonSerialization['tableKey'] as String?,
      level: jsonSerialization['level'] as int,
      spellSlots: (jsonSerialization['spellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
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

  static final t = SpellSlotProgressionDataTable();

  static const db = SpellSlotProgressionDataRepository._();

  @override
  int? id;

  String? tableKey;

  int level;

  Map<int, int>? spellSlots;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellSlotProgressionData copyWith({
    int? id,
    String? tableKey,
    int? level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
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
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static SpellSlotProgressionDataInclude include() {
    return SpellSlotProgressionDataInclude._();
  }

  static SpellSlotProgressionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    SpellSlotProgressionDataInclude? include,
  }) {
    return SpellSlotProgressionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSlotProgressionDataImpl extends SpellSlotProgressionData {
  _SpellSlotProgressionDataImpl({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          tableKey: tableKey,
          level: level,
          spellSlots: spellSlots,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellSlotProgressionData copyWith({
    Object? id = _Undefined,
    Object? tableKey = _Undefined,
    int? level,
    Object? spellSlots = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return SpellSlotProgressionData(
      id: id is int? ? id : this.id,
      tableKey: tableKey is String? ? tableKey : this.tableKey,
      level: level ?? this.level,
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class SpellSlotProgressionDataTable extends _i1.Table<int?> {
  SpellSlotProgressionDataTable({super.tableRelation})
      : super(tableName: 'spell_slot_progression_data') {
    tableKey = _i1.ColumnString(
      'tableKey',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    spellSlots = _i1.ColumnSerializable(
      'spellSlots',
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

  late final _i1.ColumnString tableKey;

  late final _i1.ColumnInt level;

  late final _i1.ColumnSerializable spellSlots;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
        id,
        tableKey,
        level,
        spellSlots,
        source,
        version,
        createdAt,
        updatedAt,
      ];
}

class SpellSlotProgressionDataInclude extends _i1.IncludeObject {
  SpellSlotProgressionDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SpellSlotProgressionData.t;
}

class SpellSlotProgressionDataIncludeList extends _i1.IncludeList {
  SpellSlotProgressionDataIncludeList._({
    _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellSlotProgressionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpellSlotProgressionData.t;
}

class SpellSlotProgressionDataRepository {
  const SpellSlotProgressionDataRepository._();

  /// Returns a list of [SpellSlotProgressionData]s matching the given query parameters.
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
  Future<List<SpellSlotProgressionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SpellSlotProgressionData] matching the given query parameters.
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
  Future<SpellSlotProgressionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpellSlotProgressionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellSlotProgressionDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      orderBy: orderBy?.call(SpellSlotProgressionData.t),
      orderByList: orderByList?.call(SpellSlotProgressionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SpellSlotProgressionData] by its [id] or null if no such row exists.
  Future<SpellSlotProgressionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SpellSlotProgressionData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SpellSlotProgressionData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellSlotProgressionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SpellSlotProgressionData>> insert(
    _i1.Session session,
    List<SpellSlotProgressionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SpellSlotProgressionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SpellSlotProgressionData] and returns the inserted row.
  ///
  /// The returned [SpellSlotProgressionData] will have its `id` field set.
  Future<SpellSlotProgressionData> insertRow(
    _i1.Session session,
    SpellSlotProgressionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellSlotProgressionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpellSlotProgressionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpellSlotProgressionData>> update(
    _i1.Session session,
    List<SpellSlotProgressionData> rows, {
    _i1.ColumnSelections<SpellSlotProgressionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpellSlotProgressionData>(
      rows,
      columns: columns?.call(SpellSlotProgressionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellSlotProgressionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellSlotProgressionData> updateRow(
    _i1.Session session,
    SpellSlotProgressionData row, {
    _i1.ColumnSelections<SpellSlotProgressionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellSlotProgressionData>(
      row,
      columns: columns?.call(SpellSlotProgressionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SpellSlotProgressionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpellSlotProgressionData>> delete(
    _i1.Session session,
    List<SpellSlotProgressionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpellSlotProgressionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpellSlotProgressionData].
  Future<SpellSlotProgressionData> deleteRow(
    _i1.Session session,
    SpellSlotProgressionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellSlotProgressionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpellSlotProgressionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpellSlotProgressionData>(
      where: where(SpellSlotProgressionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellSlotProgressionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpellSlotProgressionData>(
      where: where?.call(SpellSlotProgressionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
