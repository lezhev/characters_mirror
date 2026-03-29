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
import '../../enums/weapon_category.dart' as _i2;
import '../../enums/damage_type.dart' as _i3;

abstract class WeaponData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  WeaponData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.damage,
    this.damageTypeValue,
    this.properties,
    this.weight,
    this.cost,
    this.rangeNormal,
    this.rangeMax,
  });

  factory WeaponData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) = _WeaponDataImpl;

  factory WeaponData.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeaponData(
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
      category: jsonSerialization['category'] == null
          ? null
          : _i2.WeaponCategory.fromJson(
              (jsonSerialization['category'] as String)),
      damage: jsonSerialization['damage'] as String?,
      damageTypeValue: jsonSerialization['damageTypeValue'] == null
          ? null
          : _i3.DamageType.fromJson(
              (jsonSerialization['damageTypeValue'] as String)),
      properties: (jsonSerialization['properties'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: (jsonSerialization['cost'] as num?)?.toDouble(),
      rangeNormal: jsonSerialization['rangeNormal'] as int?,
      rangeMax: jsonSerialization['rangeMax'] as int?,
    );
  }

  static final t = WeaponDataTable();

  static const db = WeaponDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  _i2.WeaponCategory? category;

  String? damage;

  _i3.DamageType? damageTypeValue;

  List<String>? properties;

  double? weight;

  double? cost;

  int? rangeNormal;

  int? rangeMax;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeaponData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
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
      if (category != null) 'category': category?.toJson(),
      if (damage != null) 'damage': damage,
      if (damageTypeValue != null) 'damageTypeValue': damageTypeValue?.toJson(),
      if (properties != null) 'properties': properties?.toJson(),
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (rangeNormal != null) 'rangeNormal': rangeNormal,
      if (rangeMax != null) 'rangeMax': rangeMax,
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
      if (category != null) 'category': category?.toJson(),
      if (damage != null) 'damage': damage,
      if (damageTypeValue != null) 'damageTypeValue': damageTypeValue?.toJson(),
      if (properties != null) 'properties': properties?.toJson(),
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (rangeNormal != null) 'rangeNormal': rangeNormal,
      if (rangeMax != null) 'rangeMax': rangeMax,
    };
  }

  static WeaponDataInclude include() {
    return WeaponDataInclude._();
  }

  static WeaponDataIncludeList includeList({
    _i1.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WeaponDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeaponDataTable>? orderByList,
    WeaponDataInclude? include,
  }) {
    return WeaponDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WeaponData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(WeaponData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeaponDataImpl extends WeaponData {
  _WeaponDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          damage: damage,
          damageTypeValue: damageTypeValue,
          properties: properties,
          weight: weight,
          cost: cost,
          rangeNormal: rangeNormal,
          rangeMax: rangeMax,
        );

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeaponData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? damage = _Undefined,
    Object? damageTypeValue = _Undefined,
    Object? properties = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? rangeNormal = _Undefined,
    Object? rangeMax = _Undefined,
  }) {
    return WeaponData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is _i2.WeaponCategory? ? category : this.category,
      damage: damage is String? ? damage : this.damage,
      damageTypeValue: damageTypeValue is _i3.DamageType?
          ? damageTypeValue
          : this.damageTypeValue,
      properties: properties is List<String>?
          ? properties
          : this.properties?.map((e0) => e0).toList(),
      weight: weight is double? ? weight : this.weight,
      cost: cost is double? ? cost : this.cost,
      rangeNormal: rangeNormal is int? ? rangeNormal : this.rangeNormal,
      rangeMax: rangeMax is int? ? rangeMax : this.rangeMax,
    );
  }
}

class WeaponDataTable extends _i1.Table<int?> {
  WeaponDataTable({super.tableRelation}) : super(tableName: 'weapon_data') {
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
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
    );
    damage = _i1.ColumnString(
      'damage',
      this,
    );
    damageTypeValue = _i1.ColumnEnum(
      'damageTypeValue',
      this,
      _i1.EnumSerialization.byName,
    );
    properties = _i1.ColumnSerializable(
      'properties',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    cost = _i1.ColumnDouble(
      'cost',
      this,
    );
    rangeNormal = _i1.ColumnInt(
      'rangeNormal',
      this,
    );
    rangeMax = _i1.ColumnInt(
      'rangeMax',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnEnum<_i2.WeaponCategory> category;

  late final _i1.ColumnString damage;

  late final _i1.ColumnEnum<_i3.DamageType> damageTypeValue;

  late final _i1.ColumnSerializable properties;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnDouble cost;

  late final _i1.ColumnInt rangeNormal;

  late final _i1.ColumnInt rangeMax;

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
        damage,
        damageTypeValue,
        properties,
        weight,
        cost,
        rangeNormal,
        rangeMax,
      ];
}

class WeaponDataInclude extends _i1.IncludeObject {
  WeaponDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => WeaponData.t;
}

class WeaponDataIncludeList extends _i1.IncludeList {
  WeaponDataIncludeList._({
    _i1.WhereExpressionBuilder<WeaponDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WeaponData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => WeaponData.t;
}

class WeaponDataRepository {
  const WeaponDataRepository._();

  /// Returns a list of [WeaponData]s matching the given query parameters.
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
  Future<List<WeaponData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<WeaponDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeaponDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<WeaponData>(
      where: where?.call(WeaponData.t),
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [WeaponData] matching the given query parameters.
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
  Future<WeaponData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeaponDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<WeaponDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<WeaponDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<WeaponData>(
      where: where?.call(WeaponData.t),
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [WeaponData] by its [id] or null if no such row exists.
  Future<WeaponData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<WeaponData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [WeaponData]s in the list and returns the inserted rows.
  ///
  /// The returned [WeaponData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<WeaponData>> insert(
    _i1.Session session,
    List<WeaponData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<WeaponData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [WeaponData] and returns the inserted row.
  ///
  /// The returned [WeaponData] will have its `id` field set.
  Future<WeaponData> insertRow(
    _i1.Session session,
    WeaponData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<WeaponData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [WeaponData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<WeaponData>> update(
    _i1.Session session,
    List<WeaponData> rows, {
    _i1.ColumnSelections<WeaponDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<WeaponData>(
      rows,
      columns: columns?.call(WeaponData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WeaponData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WeaponData> updateRow(
    _i1.Session session,
    WeaponData row, {
    _i1.ColumnSelections<WeaponDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<WeaponData>(
      row,
      columns: columns?.call(WeaponData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [WeaponData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<WeaponData>> delete(
    _i1.Session session,
    List<WeaponData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<WeaponData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [WeaponData].
  Future<WeaponData> deleteRow(
    _i1.Session session,
    WeaponData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WeaponData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<WeaponData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<WeaponDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<WeaponData>(
      where: where(WeaponData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<WeaponData>(
      where: where?.call(WeaponData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
