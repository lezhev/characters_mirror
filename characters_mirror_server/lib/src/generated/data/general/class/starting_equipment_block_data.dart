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
import '../../../enums/starting_equipment_block_kind.dart' as _i2;
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../data/background_data.dart' as _i4;

abstract class StartingEquipmentBlockData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StartingEquipmentBlockData._({
    this.id,
    this.blockKey,
    this.orderIndex,
    this.kind,
    this.selectionCount,
    this.sourceClassId,
    this.sourceClass,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentBlockData({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentBlockDataImpl;

  factory StartingEquipmentBlockData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentBlockData(
      id: jsonSerialization['id'] as int?,
      blockKey: jsonSerialization['blockKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.StartingEquipmentBlockKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i4.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
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

  static final t = StartingEquipmentBlockDataTable();

  static const db = StartingEquipmentBlockDataRepository._();

  @override
  int? id;

  String? blockKey;

  int? orderIndex;

  _i2.StartingEquipmentBlockKind? kind;

  int? selectionCount;

  int? sourceClassId;

  _i3.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i4.BackgroundData? sourceBackground;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentBlockData copyWith({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
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
      if (blockKey != null) 'blockKey': blockKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
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
      if (blockKey != null) 'blockKey': blockKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJsonForProtocol(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static StartingEquipmentBlockDataInclude include({
    _i3.ClassDataInclude? sourceClass,
    _i4.BackgroundDataInclude? sourceBackground,
  }) {
    return StartingEquipmentBlockDataInclude._(
      sourceClass: sourceClass,
      sourceBackground: sourceBackground,
    );
  }

  static StartingEquipmentBlockDataIncludeList includeList({
    _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentBlockDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentBlockDataTable>? orderByList,
    StartingEquipmentBlockDataInclude? include,
  }) {
    return StartingEquipmentBlockDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentBlockData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StartingEquipmentBlockData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentBlockDataImpl extends StartingEquipmentBlockData {
  _StartingEquipmentBlockDataImpl({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockKey: blockKey,
          orderIndex: orderIndex,
          kind: kind,
          selectionCount: selectionCount,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentBlockData copyWith({
    Object? id = _Undefined,
    Object? blockKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentBlockData(
      id: id is int? ? id : this.id,
      blockKey: blockKey is String? ? blockKey : this.blockKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i2.StartingEquipmentBlockKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i3.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i4.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class StartingEquipmentBlockDataTable extends _i1.Table<int?> {
  StartingEquipmentBlockDataTable({super.tableRelation})
      : super(tableName: 'starting_equipment_block_data') {
    blockKey = _i1.ColumnString(
      'blockKey',
      this,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    selectionCount = _i1.ColumnInt(
      'selectionCount',
      this,
    );
    sourceClassId = _i1.ColumnInt(
      'sourceClassId',
      this,
    );
    sourceBackgroundId = _i1.ColumnInt(
      'sourceBackgroundId',
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

  late final _i1.ColumnString blockKey;

  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnEnum<_i2.StartingEquipmentBlockKind> kind;

  late final _i1.ColumnInt selectionCount;

  late final _i1.ColumnInt sourceClassId;

  _i3.ClassDataTable? _sourceClass;

  late final _i1.ColumnInt sourceBackgroundId;

  _i4.BackgroundDataTable? _sourceBackground;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i3.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _i1.createRelationTable(
      relationFieldName: 'sourceClass',
      field: StartingEquipmentBlockData.t.sourceClassId,
      foreignField: _i3.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _i4.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _i1.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: StartingEquipmentBlockData.t.sourceBackgroundId,
      foreignField: _i4.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        blockKey,
        orderIndex,
        kind,
        selectionCount,
        sourceClassId,
        sourceBackgroundId,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceBackground') {
      return sourceBackground;
    }
    return null;
  }
}

class StartingEquipmentBlockDataInclude extends _i1.IncludeObject {
  StartingEquipmentBlockDataInclude._({
    _i3.ClassDataInclude? sourceClass,
    _i4.BackgroundDataInclude? sourceBackground,
  }) {
    _sourceClass = sourceClass;
    _sourceBackground = sourceBackground;
  }

  _i3.ClassDataInclude? _sourceClass;

  _i4.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _i1.Include?> get includes => {
        'sourceClass': _sourceClass,
        'sourceBackground': _sourceBackground,
      };

  @override
  _i1.Table<int?> get table => StartingEquipmentBlockData.t;
}

class StartingEquipmentBlockDataIncludeList extends _i1.IncludeList {
  StartingEquipmentBlockDataIncludeList._({
    _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartingEquipmentBlockData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StartingEquipmentBlockData.t;
}

class StartingEquipmentBlockDataRepository {
  const StartingEquipmentBlockDataRepository._();

  final attachRow = const StartingEquipmentBlockDataAttachRowRepository._();

  final detachRow = const StartingEquipmentBlockDataDetachRowRepository._();

  /// Returns a list of [StartingEquipmentBlockData]s matching the given query parameters.
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
  Future<List<StartingEquipmentBlockData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentBlockDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentBlockDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentBlockDataInclude? include,
  }) async {
    return session.db.find<StartingEquipmentBlockData>(
      where: where?.call(StartingEquipmentBlockData.t),
      orderBy: orderBy?.call(StartingEquipmentBlockData.t),
      orderByList: orderByList?.call(StartingEquipmentBlockData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StartingEquipmentBlockData] matching the given query parameters.
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
  Future<StartingEquipmentBlockData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentBlockDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentBlockDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentBlockDataInclude? include,
  }) async {
    return session.db.findFirstRow<StartingEquipmentBlockData>(
      where: where?.call(StartingEquipmentBlockData.t),
      orderBy: orderBy?.call(StartingEquipmentBlockData.t),
      orderByList: orderByList?.call(StartingEquipmentBlockData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StartingEquipmentBlockData] by its [id] or null if no such row exists.
  Future<StartingEquipmentBlockData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StartingEquipmentBlockDataInclude? include,
  }) async {
    return session.db.findById<StartingEquipmentBlockData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StartingEquipmentBlockData]s in the list and returns the inserted rows.
  ///
  /// The returned [StartingEquipmentBlockData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StartingEquipmentBlockData>> insert(
    _i1.Session session,
    List<StartingEquipmentBlockData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StartingEquipmentBlockData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StartingEquipmentBlockData] and returns the inserted row.
  ///
  /// The returned [StartingEquipmentBlockData] will have its `id` field set.
  Future<StartingEquipmentBlockData> insertRow(
    _i1.Session session,
    StartingEquipmentBlockData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartingEquipmentBlockData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentBlockData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StartingEquipmentBlockData>> update(
    _i1.Session session,
    List<StartingEquipmentBlockData> rows, {
    _i1.ColumnSelections<StartingEquipmentBlockDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StartingEquipmentBlockData>(
      rows,
      columns: columns?.call(StartingEquipmentBlockData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartingEquipmentBlockData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartingEquipmentBlockData> updateRow(
    _i1.Session session,
    StartingEquipmentBlockData row, {
    _i1.ColumnSelections<StartingEquipmentBlockDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartingEquipmentBlockData>(
      row,
      columns: columns?.call(StartingEquipmentBlockData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StartingEquipmentBlockData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StartingEquipmentBlockData>> delete(
    _i1.Session session,
    List<StartingEquipmentBlockData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StartingEquipmentBlockData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StartingEquipmentBlockData].
  Future<StartingEquipmentBlockData> deleteRow(
    _i1.Session session,
    StartingEquipmentBlockData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartingEquipmentBlockData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StartingEquipmentBlockData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StartingEquipmentBlockData>(
      where: where(StartingEquipmentBlockData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentBlockDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StartingEquipmentBlockData>(
      where: where?.call(StartingEquipmentBlockData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StartingEquipmentBlockDataAttachRowRepository {
  const StartingEquipmentBlockDataAttachRowRepository._();

  /// Creates a relation between the given [StartingEquipmentBlockData] and [ClassData]
  /// by setting the [StartingEquipmentBlockData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _i1.Session session,
    StartingEquipmentBlockData startingEquipmentBlockData,
    _i3.ClassData sourceClass, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentBlockData.id == null) {
      throw ArgumentError.notNull('startingEquipmentBlockData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $startingEquipmentBlockData =
        startingEquipmentBlockData.copyWith(sourceClassId: sourceClass.id);
    await session.db.updateRow<StartingEquipmentBlockData>(
      $startingEquipmentBlockData,
      columns: [StartingEquipmentBlockData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StartingEquipmentBlockData] and [BackgroundData]
  /// by setting the [StartingEquipmentBlockData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _i1.Session session,
    StartingEquipmentBlockData startingEquipmentBlockData,
    _i4.BackgroundData sourceBackground, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentBlockData.id == null) {
      throw ArgumentError.notNull('startingEquipmentBlockData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $startingEquipmentBlockData = startingEquipmentBlockData.copyWith(
        sourceBackgroundId: sourceBackground.id);
    await session.db.updateRow<StartingEquipmentBlockData>(
      $startingEquipmentBlockData,
      columns: [StartingEquipmentBlockData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}

class StartingEquipmentBlockDataDetachRowRepository {
  const StartingEquipmentBlockDataDetachRowRepository._();

  /// Detaches the relation between this [StartingEquipmentBlockData] and the [ClassData] set in `sourceClass`
  /// by setting the [StartingEquipmentBlockData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _i1.Session session,
    StartingEquipmentBlockData startingequipmentblockdata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmentblockdata.id == null) {
      throw ArgumentError.notNull('startingequipmentblockdata.id');
    }

    var $startingequipmentblockdata =
        startingequipmentblockdata.copyWith(sourceClassId: null);
    await session.db.updateRow<StartingEquipmentBlockData>(
      $startingequipmentblockdata,
      columns: [StartingEquipmentBlockData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [StartingEquipmentBlockData] and the [BackgroundData] set in `sourceBackground`
  /// by setting the [StartingEquipmentBlockData]'s foreign key `sourceBackgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceBackground(
    _i1.Session session,
    StartingEquipmentBlockData startingequipmentblockdata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmentblockdata.id == null) {
      throw ArgumentError.notNull('startingequipmentblockdata.id');
    }

    var $startingequipmentblockdata =
        startingequipmentblockdata.copyWith(sourceBackgroundId: null);
    await session.db.updateRow<StartingEquipmentBlockData>(
      $startingequipmentblockdata,
      columns: [StartingEquipmentBlockData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
