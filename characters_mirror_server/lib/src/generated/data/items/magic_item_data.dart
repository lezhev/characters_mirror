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

abstract class MagicItemData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  MagicItemData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.rarity,
    this.type,
    this.requiresAttunement,
    this.attunementCondition,
    this.bonus,
    this.charges,
    this.rechargeCondition,
    this.effects,
  });

  factory MagicItemData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  }) = _MagicItemDataImpl;

  factory MagicItemData.fromJson(Map<String, dynamic> jsonSerialization) {
    return MagicItemData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
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
      rarity: jsonSerialization['rarity'] as String?,
      type: jsonSerialization['type'] as String?,
      requiresAttunement: jsonSerialization['requiresAttunement'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['requiresAttunement'],
            ),
      attunementCondition: jsonSerialization['attunementCondition'] as String?,
      bonus: jsonSerialization['bonus'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['bonus'],
            ),
      charges: jsonSerialization['charges'] as int?,
      rechargeCondition: jsonSerialization['rechargeCondition'] as String?,
      effects: jsonSerialization['effects'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['effects'],
            ),
    );
  }

  static final t = MagicItemDataTable();

  static const db = MagicItemDataRepository._();

  @override
  int? id;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? rarity;

  String? type;

  bool? requiresAttunement;

  String? attunementCondition;

  Map<String, int>? bonus;

  int? charges;

  String? rechargeCondition;

  List<String>? effects;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [MagicItemData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MagicItemData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MagicItemData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (rarity != null) 'rarity': rarity,
      if (type != null) 'type': type,
      if (requiresAttunement != null) 'requiresAttunement': requiresAttunement,
      if (attunementCondition != null)
        'attunementCondition': attunementCondition,
      if (bonus != null) 'bonus': bonus?.toJson(),
      if (charges != null) 'charges': charges,
      if (rechargeCondition != null) 'rechargeCondition': rechargeCondition,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MagicItemData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (rarity != null) 'rarity': rarity,
      if (type != null) 'type': type,
      if (requiresAttunement != null) 'requiresAttunement': requiresAttunement,
      if (attunementCondition != null)
        'attunementCondition': attunementCondition,
      if (bonus != null) 'bonus': bonus?.toJson(),
      if (charges != null) 'charges': charges,
      if (rechargeCondition != null) 'rechargeCondition': rechargeCondition,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  static MagicItemDataInclude include() {
    return MagicItemDataInclude._();
  }

  static MagicItemDataIncludeList includeList({
    _is.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    MagicItemDataInclude? include,
  }) {
    return MagicItemDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MagicItemDataImpl extends MagicItemData {
  _MagicItemDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rarity,
    String? type,
    bool? requiresAttunement,
    String? attunementCondition,
    Map<String, int>? bonus,
    int? charges,
    String? rechargeCondition,
    List<String>? effects,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         rarity: rarity,
         type: type,
         requiresAttunement: requiresAttunement,
         attunementCondition: attunementCondition,
         bonus: bonus,
         charges: charges,
         rechargeCondition: rechargeCondition,
         effects: effects,
       );

  /// Returns a shallow copy of this [MagicItemData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MagicItemData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? rarity = _Undefined,
    Object? type = _Undefined,
    Object? requiresAttunement = _Undefined,
    Object? attunementCondition = _Undefined,
    Object? bonus = _Undefined,
    Object? charges = _Undefined,
    Object? rechargeCondition = _Undefined,
    Object? effects = _Undefined,
  }) {
    return MagicItemData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      rarity: rarity is String? ? rarity : this.rarity,
      type: type is String? ? type : this.type,
      requiresAttunement: requiresAttunement is bool?
          ? requiresAttunement
          : this.requiresAttunement,
      attunementCondition: attunementCondition is String?
          ? attunementCondition
          : this.attunementCondition,
      bonus: bonus is Map<String, int>?
          ? bonus
          : this.bonus?.map((key0, value0) => MapEntry(key0, value0)),
      charges: charges is int? ? charges : this.charges,
      rechargeCondition: rechargeCondition is String?
          ? rechargeCondition
          : this.rechargeCondition,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
    );
  }
}

class MagicItemDataUpdateTable extends _is.UpdateTable<MagicItemDataTable> {
  MagicItemDataUpdateTable(super.table);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

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

  _is.ColumnValue<String, String> rarity(String? value) =>
      _is.ColumnValue(table.rarity, value);

  _is.ColumnValue<String, String> type(String? value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<bool, bool> requiresAttunement(bool? value) =>
      _is.ColumnValue(table.requiresAttunement, value);

  _is.ColumnValue<String, String> attunementCondition(String? value) =>
      _is.ColumnValue(table.attunementCondition, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> bonus(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.bonus, value);

  _is.ColumnValue<int, int> charges(int? value) =>
      _is.ColumnValue(table.charges, value);

  _is.ColumnValue<String, String> rechargeCondition(String? value) =>
      _is.ColumnValue(table.rechargeCondition, value);

  _is.ColumnValue<List<String>, List<String>> effects(List<String>? value) =>
      _is.ColumnValue(table.effects, value);
}

class MagicItemDataTable extends _is.Table<int?> {
  MagicItemDataTable({super.tableRelation})
    : super(tableName: 'magic_item_data') {
    updateTable = MagicItemDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    rarity = _is.ColumnString('rarity', this);
    type = _is.ColumnString('type', this);
    requiresAttunement = _is.ColumnBool('requiresAttunement', this);
    attunementCondition = _is.ColumnString('attunementCondition', this);
    bonus = _is.ColumnSerializable<Map<String, int>>('bonus', this);
    charges = _is.ColumnInt('charges', this);
    rechargeCondition = _is.ColumnString('rechargeCondition', this);
    effects = _is.ColumnSerializable<List<String>>('effects', this);
  }

  late final MagicItemDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnString rarity;

  late final _is.ColumnString type;

  late final _is.ColumnBool requiresAttunement;

  late final _is.ColumnString attunementCondition;

  late final _is.ColumnSerializable<Map<String, int>> bonus;

  late final _is.ColumnInt charges;

  late final _is.ColumnString rechargeCondition;

  late final _is.ColumnSerializable<List<String>> effects;

  @override
  List<_is.Column> get columns => [
    id,
    referenceKey,
    name,
    description,
    source,
    version,
    createdAt,
    updatedAt,
    rarity,
    type,
    requiresAttunement,
    attunementCondition,
    bonus,
    charges,
    rechargeCondition,
    effects,
  ];
}

class MagicItemDataInclude extends _is.IncludeObject {
  MagicItemDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => MagicItemData.t;
}

class MagicItemDataIncludeList extends _is.IncludeList {
  MagicItemDataIncludeList._({
    _is.WhereExpressionBuilder<MagicItemDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MagicItemData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => MagicItemData.t;
}

class MagicItemDataRepository {
  const MagicItemDataRepository._();

  /// Returns a list of [MagicItemData]s matching the given query parameters.
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
  Future<List<MagicItemData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MagicItemData>(
      where: where?.call(MagicItemData.t),
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MagicItemData] matching the given query parameters.
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
  Future<MagicItemData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? offset,
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MagicItemData>(
      where: where?.call(MagicItemData.t),
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MagicItemData] by its [id] or null if no such row exists.
  Future<MagicItemData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MagicItemData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MagicItemData]s in the list and returns the inserted rows.
  ///
  /// The returned [MagicItemData]s will have their `id` fields set.
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
  Future<List<MagicItemData>> insert(
    _is.DatabaseSession session,
    List<MagicItemData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<MagicItemData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [MagicItemData] and returns the inserted row.
  ///
  /// The returned [MagicItemData] will have its `id` field set.
  Future<MagicItemData> insertRow(
    _is.DatabaseSession session,
    MagicItemData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<MagicItemData>(row, transaction: transaction);
  }

  /// Upserts all [MagicItemData]s in the list and returns the resulting rows.
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
  /// The returned [MagicItemData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MagicItemData>> upsert(
    _is.DatabaseSession session,
    List<MagicItemData> rows, {
    required _is.ColumnSelections<MagicItemDataTable> conflictColumns,
    _is.ColumnSelections<MagicItemDataTable>? updateColumns,
    _is.WhereExpressionBuilder<MagicItemDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<MagicItemData>(
      rows,
      conflictColumns: conflictColumns(MagicItemData.t),
      updateColumns: updateColumns?.call(MagicItemData.t),
      updateWhere: updateWhere?.call(MagicItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [MagicItemData] and returns the resulting row.
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
  /// The returned [MagicItemData] will have its `id` field set.
  Future<MagicItemData?> upsertRow(
    _is.DatabaseSession session,
    MagicItemData row, {
    required _is.ColumnSelections<MagicItemDataTable> conflictColumns,
    _is.ColumnSelections<MagicItemDataTable>? updateColumns,
    _is.WhereExpressionBuilder<MagicItemDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<MagicItemData>(
      row,
      conflictColumns: conflictColumns(MagicItemData.t),
      updateColumns: updateColumns?.call(MagicItemData.t),
      updateWhere: updateWhere?.call(MagicItemData.t),
      transaction: transaction,
    );
  }

  /// Updates all [MagicItemData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MagicItemData>> update(
    _is.DatabaseSession session,
    List<MagicItemData> rows, {
    _is.ColumnSelections<MagicItemDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<MagicItemData>(
      rows,
      columns: columns?.call(MagicItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [MagicItemData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MagicItemData> updateRow(
    _is.DatabaseSession session,
    MagicItemData row, {
    _is.ColumnSelections<MagicItemDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<MagicItemData>(
      row,
      columns: columns?.call(MagicItemData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MagicItemData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MagicItemData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MagicItemDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<MagicItemData>(
      id,
      columnValues: columnValues(MagicItemData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MagicItemData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MagicItemData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MagicItemDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MagicItemDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<MagicItemData>(
      columnValues: columnValues(MagicItemData.t.updateTable),
      where: where(MagicItemData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [MagicItemData]s in the list and returns the deleted rows.
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
  Future<List<MagicItemData>> delete(
    _is.DatabaseSession session,
    List<MagicItemData> rows, {
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<MagicItemData>(
      rows,
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [MagicItemData].
  Future<MagicItemData> deleteRow(
    _is.DatabaseSession session,
    MagicItemData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MagicItemData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<MagicItemData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MagicItemDataTable> where,
    _is.OrderByBuilder<MagicItemDataTable>? orderBy,
    _is.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<MagicItemData>(
      where: where(MagicItemData.t),
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<MagicItemData>(
      where: where?.call(MagicItemData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MagicItemData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MagicItemDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MagicItemData>(
      where: where(MagicItemData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
