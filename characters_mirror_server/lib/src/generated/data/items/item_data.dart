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

abstract class ItemData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ItemData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.weight,
    this.cost,
    this.effects,
  })  : _charactersItemsCharactersId = null,
        _classDataProficienciestoolsClassDataId = null,
        _classDataStartingequipmentClassDataId = null;

  factory ItemData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) = _ItemDataImpl;

  factory ItemData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ItemDataImplicit._(
      id: jsonSerialization['id'] as int?,
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
      category: jsonSerialization['category'] as String?,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as int?,
      effects: (jsonSerialization['effects'] as List?)
          ?.map((e) => e as String)
          .toList(),
      $_charactersItemsCharactersId:
          jsonSerialization['_charactersItemsCharactersId'] as int?,
      $_classDataProficienciestoolsClassDataId:
          jsonSerialization['_classDataProficienciestoolsClassDataId'] as int?,
      $_classDataStartingequipmentClassDataId:
          jsonSerialization['_classDataStartingequipmentClassDataId'] as int?,
    );
  }

  static final t = ItemDataTable();

  static const db = ItemDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? category;

  double? weight;

  int? cost;

  List<String>? effects;

  final int? _charactersItemsCharactersId;

  final int? _classDataProficienciestoolsClassDataId;

  final int? _classDataStartingequipmentClassDataId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ItemData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (effects != null) 'effects': effects?.toJson(),
      if (_charactersItemsCharactersId != null)
        '_charactersItemsCharactersId': _charactersItemsCharactersId,
      if (_classDataProficienciestoolsClassDataId != null)
        '_classDataProficienciestoolsClassDataId':
            _classDataProficienciestoolsClassDataId,
      if (_classDataStartingequipmentClassDataId != null)
        '_classDataStartingequipmentClassDataId':
            _classDataStartingequipmentClassDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  static ItemDataInclude include() {
    return ItemDataInclude._();
  }

  static ItemDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ItemDataTable>? orderByList,
    ItemDataInclude? include,
  }) {
    return ItemDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ItemData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ItemData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ItemDataImpl extends ItemData {
  _ItemDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          weight: weight,
          cost: cost,
          effects: effects,
        );

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ItemData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? effects = _Undefined,
  }) {
    return ItemDataImplicit._(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is String? ? category : this.category,
      weight: weight is double? ? weight : this.weight,
      cost: cost is int? ? cost : this.cost,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
      $_charactersItemsCharactersId: this._charactersItemsCharactersId,
      $_classDataProficienciestoolsClassDataId:
          this._classDataProficienciestoolsClassDataId,
      $_classDataStartingequipmentClassDataId:
          this._classDataStartingequipmentClassDataId,
    );
  }
}

class ItemDataImplicit extends _ItemDataImpl {
  ItemDataImplicit._({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
    int? $_charactersItemsCharactersId,
    int? $_classDataProficienciestoolsClassDataId,
    int? $_classDataStartingequipmentClassDataId,
  })  : _charactersItemsCharactersId = $_charactersItemsCharactersId,
        _classDataProficienciestoolsClassDataId =
            $_classDataProficienciestoolsClassDataId,
        _classDataStartingequipmentClassDataId =
            $_classDataStartingequipmentClassDataId,
        super(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          weight: weight,
          cost: cost,
          effects: effects,
        );

  factory ItemDataImplicit(
    ItemData itemData, {
    int? $_charactersItemsCharactersId,
    int? $_classDataProficienciestoolsClassDataId,
    int? $_classDataStartingequipmentClassDataId,
  }) {
    return ItemDataImplicit._(
      id: itemData.id,
      name: itemData.name,
      description: itemData.description,
      source: itemData.source,
      version: itemData.version,
      createdAt: itemData.createdAt,
      updatedAt: itemData.updatedAt,
      category: itemData.category,
      weight: itemData.weight,
      cost: itemData.cost,
      effects: itemData.effects,
      $_charactersItemsCharactersId: $_charactersItemsCharactersId,
      $_classDataProficienciestoolsClassDataId:
          $_classDataProficienciestoolsClassDataId,
      $_classDataStartingequipmentClassDataId:
          $_classDataStartingequipmentClassDataId,
    );
  }

  @override
  final int? _charactersItemsCharactersId;

  @override
  final int? _classDataProficienciestoolsClassDataId;

  @override
  final int? _classDataStartingequipmentClassDataId;
}

class ItemDataTable extends _i1.Table<int?> {
  ItemDataTable({super.tableRelation}) : super(tableName: 'item_data') {
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
    category = _i1.ColumnString(
      'category',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    cost = _i1.ColumnInt(
      'cost',
      this,
    );
    effects = _i1.ColumnSerializable(
      'effects',
      this,
    );
    $_charactersItemsCharactersId = _i1.ColumnInt(
      '_charactersItemsCharactersId',
      this,
    );
    $_classDataProficienciestoolsClassDataId = _i1.ColumnInt(
      '_classDataProficienciestoolsClassDataId',
      this,
    );
    $_classDataStartingequipmentClassDataId = _i1.ColumnInt(
      '_classDataStartingequipmentClassDataId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnString category;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnInt cost;

  late final _i1.ColumnSerializable effects;

  late final _i1.ColumnInt $_charactersItemsCharactersId;

  late final _i1.ColumnInt $_classDataProficienciestoolsClassDataId;

  late final _i1.ColumnInt $_classDataStartingequipmentClassDataId;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        category,
        weight,
        cost,
        effects,
        $_charactersItemsCharactersId,
        $_classDataProficienciestoolsClassDataId,
        $_classDataStartingequipmentClassDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        category,
        weight,
        cost,
        effects,
      ];
}

class ItemDataInclude extends _i1.IncludeObject {
  ItemDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ItemData.t;
}

class ItemDataIncludeList extends _i1.IncludeList {
  ItemDataIncludeList._({
    _i1.WhereExpressionBuilder<ItemDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ItemData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ItemData.t;
}

class ItemDataRepository {
  const ItemDataRepository._();

  /// Returns a list of [ItemData]s matching the given query parameters.
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
  Future<List<ItemData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ItemDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ItemData>(
      where: where?.call(ItemData.t),
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ItemData] matching the given query parameters.
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
  Future<ItemData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ItemDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ItemDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ItemData>(
      where: where?.call(ItemData.t),
      orderBy: orderBy?.call(ItemData.t),
      orderByList: orderByList?.call(ItemData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ItemData] by its [id] or null if no such row exists.
  Future<ItemData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ItemData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ItemData]s in the list and returns the inserted rows.
  ///
  /// The returned [ItemData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ItemData>> insert(
    _i1.Session session,
    List<ItemData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ItemData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ItemData] and returns the inserted row.
  ///
  /// The returned [ItemData] will have its `id` field set.
  Future<ItemData> insertRow(
    _i1.Session session,
    ItemData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ItemData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ItemData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ItemData>> update(
    _i1.Session session,
    List<ItemData> rows, {
    _i1.ColumnSelections<ItemDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ItemData>(
      rows,
      columns: columns?.call(ItemData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ItemData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ItemData> updateRow(
    _i1.Session session,
    ItemData row, {
    _i1.ColumnSelections<ItemDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ItemData>(
      row,
      columns: columns?.call(ItemData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ItemData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ItemData>> delete(
    _i1.Session session,
    List<ItemData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ItemData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ItemData].
  Future<ItemData> deleteRow(
    _i1.Session session,
    ItemData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ItemData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ItemData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ItemDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ItemData>(
      where: where(ItemData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ItemDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ItemData>(
      where: where?.call(ItemData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
