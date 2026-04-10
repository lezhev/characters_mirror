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
import '../../../data/general/class/starting_equipment_block_data.dart' as _i2;

abstract class StartingEquipmentOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StartingEquipmentOptionData._({
    this.id,
    required this.blockId,
    this.block,
    this.optionKey,
    this.orderIndex,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentOptionData({
    int? id,
    required int blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentOptionDataImpl;

  factory StartingEquipmentOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentOptionData(
      id: jsonSerialization['id'] as int?,
      blockId: jsonSerialization['blockId'] as int,
      block: jsonSerialization['block'] == null
          ? null
          : _i2.StartingEquipmentBlockData.fromJson(
              (jsonSerialization['block'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
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

  static final t = StartingEquipmentOptionDataTable();

  static const db = StartingEquipmentOptionDataRepository._();

  @override
  int? id;

  int blockId;

  _i2.StartingEquipmentBlockData? block;

  String? optionKey;

  int? orderIndex;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentOptionData copyWith({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'blockId': blockId,
      if (block != null) 'block': block?.toJson(),
      if (optionKey != null) 'optionKey': optionKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
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
      'blockId': blockId,
      if (block != null) 'block': block?.toJsonForProtocol(),
      if (optionKey != null) 'optionKey': optionKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static StartingEquipmentOptionDataInclude include(
      {_i2.StartingEquipmentBlockDataInclude? block}) {
    return StartingEquipmentOptionDataInclude._(block: block);
  }

  static StartingEquipmentOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentOptionDataTable>? orderByList,
    StartingEquipmentOptionDataInclude? include,
  }) {
    return StartingEquipmentOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StartingEquipmentOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentOptionDataImpl extends StartingEquipmentOptionData {
  _StartingEquipmentOptionDataImpl({
    int? id,
    required int blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockId: blockId,
          block: block,
          optionKey: optionKey,
          orderIndex: orderIndex,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentOptionData copyWith({
    Object? id = _Undefined,
    int? blockId,
    Object? block = _Undefined,
    Object? optionKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentOptionData(
      id: id is int? ? id : this.id,
      blockId: blockId ?? this.blockId,
      block: block is _i2.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class StartingEquipmentOptionDataTable extends _i1.Table<int?> {
  StartingEquipmentOptionDataTable({super.tableRelation})
      : super(tableName: 'starting_equipment_option_data') {
    blockId = _i1.ColumnInt(
      'blockId',
      this,
    );
    optionKey = _i1.ColumnString(
      'optionKey',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
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

  late final _i1.ColumnInt blockId;

  _i2.StartingEquipmentBlockDataTable? _block;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.StartingEquipmentBlockDataTable get block {
    if (_block != null) return _block!;
    _block = _i1.createRelationTable(
      relationFieldName: 'block',
      field: StartingEquipmentOptionData.t.blockId,
      foreignField: _i2.StartingEquipmentBlockData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.StartingEquipmentBlockDataTable(
              tableRelation: foreignTableRelation),
    );
    return _block!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        blockId,
        optionKey,
        orderIndex,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'block') {
      return block;
    }
    return null;
  }
}

class StartingEquipmentOptionDataInclude extends _i1.IncludeObject {
  StartingEquipmentOptionDataInclude._(
      {_i2.StartingEquipmentBlockDataInclude? block}) {
    _block = block;
  }

  _i2.StartingEquipmentBlockDataInclude? _block;

  @override
  Map<String, _i1.Include?> get includes => {'block': _block};

  @override
  _i1.Table<int?> get table => StartingEquipmentOptionData.t;
}

class StartingEquipmentOptionDataIncludeList extends _i1.IncludeList {
  StartingEquipmentOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartingEquipmentOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StartingEquipmentOptionData.t;
}

class StartingEquipmentOptionDataRepository {
  const StartingEquipmentOptionDataRepository._();

  final attachRow = const StartingEquipmentOptionDataAttachRowRepository._();

  /// Returns a list of [StartingEquipmentOptionData]s matching the given query parameters.
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
  Future<List<StartingEquipmentOptionData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentOptionDataInclude? include,
  }) async {
    return session.db.find<StartingEquipmentOptionData>(
      where: where?.call(StartingEquipmentOptionData.t),
      orderBy: orderBy?.call(StartingEquipmentOptionData.t),
      orderByList: orderByList?.call(StartingEquipmentOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StartingEquipmentOptionData] matching the given query parameters.
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
  Future<StartingEquipmentOptionData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentOptionDataInclude? include,
  }) async {
    return session.db.findFirstRow<StartingEquipmentOptionData>(
      where: where?.call(StartingEquipmentOptionData.t),
      orderBy: orderBy?.call(StartingEquipmentOptionData.t),
      orderByList: orderByList?.call(StartingEquipmentOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StartingEquipmentOptionData] by its [id] or null if no such row exists.
  Future<StartingEquipmentOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StartingEquipmentOptionDataInclude? include,
  }) async {
    return session.db.findById<StartingEquipmentOptionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StartingEquipmentOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [StartingEquipmentOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StartingEquipmentOptionData>> insert(
    _i1.Session session,
    List<StartingEquipmentOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StartingEquipmentOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StartingEquipmentOptionData] and returns the inserted row.
  ///
  /// The returned [StartingEquipmentOptionData] will have its `id` field set.
  Future<StartingEquipmentOptionData> insertRow(
    _i1.Session session,
    StartingEquipmentOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartingEquipmentOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StartingEquipmentOptionData>> update(
    _i1.Session session,
    List<StartingEquipmentOptionData> rows, {
    _i1.ColumnSelections<StartingEquipmentOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StartingEquipmentOptionData>(
      rows,
      columns: columns?.call(StartingEquipmentOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartingEquipmentOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartingEquipmentOptionData> updateRow(
    _i1.Session session,
    StartingEquipmentOptionData row, {
    _i1.ColumnSelections<StartingEquipmentOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartingEquipmentOptionData>(
      row,
      columns: columns?.call(StartingEquipmentOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StartingEquipmentOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StartingEquipmentOptionData>> delete(
    _i1.Session session,
    List<StartingEquipmentOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StartingEquipmentOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StartingEquipmentOptionData].
  Future<StartingEquipmentOptionData> deleteRow(
    _i1.Session session,
    StartingEquipmentOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartingEquipmentOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StartingEquipmentOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StartingEquipmentOptionData>(
      where: where(StartingEquipmentOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StartingEquipmentOptionData>(
      where: where?.call(StartingEquipmentOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StartingEquipmentOptionDataAttachRowRepository {
  const StartingEquipmentOptionDataAttachRowRepository._();

  /// Creates a relation between the given [StartingEquipmentOptionData] and [StartingEquipmentBlockData]
  /// by setting the [StartingEquipmentOptionData]'s foreign key `blockId` to refer to the [StartingEquipmentBlockData].
  Future<void> block(
    _i1.Session session,
    StartingEquipmentOptionData startingEquipmentOptionData,
    _i2.StartingEquipmentBlockData block, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentOptionData.id == null) {
      throw ArgumentError.notNull('startingEquipmentOptionData.id');
    }
    if (block.id == null) {
      throw ArgumentError.notNull('block.id');
    }

    var $startingEquipmentOptionData =
        startingEquipmentOptionData.copyWith(blockId: block.id);
    await session.db.updateRow<StartingEquipmentOptionData>(
      $startingEquipmentOptionData,
      columns: [StartingEquipmentOptionData.t.blockId],
      transaction: transaction,
    );
  }
}
