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
import '../../enums/damage_type.dart' as _iei1ksog;
import '../../enums/weapon_category.dart' as _iya6mjd5;
import '../../enums/weapon_property.dart' as _iw4a05a7;

abstract class WeaponData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  WeaponData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.damage,
    this.damageType,
    this.properties,
    this.weight,
    this.cost,
    this.rangeNormal,
    this.rangeMax,
  });

  factory WeaponData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _iya6mjd5.WeaponCategory? category,
    String? damage,
    _iei1ksog.DamageType? damageType,
    List<_iw4a05a7.WeaponProperty>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) = _WeaponDataImpl;

  factory WeaponData.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeaponData(
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
      category: jsonSerialization['category'] == null
          ? null
          : _iya6mjd5.WeaponCategory.fromJson(
              (jsonSerialization['category'] as String),
            ),
      damage: jsonSerialization['damage'] as String?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _iei1ksog.DamageType.fromJson(
              (jsonSerialization['damageType'] as String),
            ),
      properties: jsonSerialization['properties'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw4a05a7.WeaponProperty>>(
              jsonSerialization['properties'],
            ),
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

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  _iya6mjd5.WeaponCategory? category;

  String? damage;

  _iei1ksog.DamageType? damageType;

  List<_iw4a05a7.WeaponProperty>? properties;

  double? weight;

  double? cost;

  int? rangeNormal;

  int? rangeMax;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WeaponData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _iya6mjd5.WeaponCategory? category,
    String? damage,
    _iei1ksog.DamageType? damageType,
    List<_iw4a05a7.WeaponProperty>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WeaponData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category?.toJson(),
      if (damage != null) 'damage': damage,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (properties != null)
        'properties': properties?.toJson(valueToJson: (v) => v.toJson()),
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (rangeNormal != null) 'rangeNormal': rangeNormal,
      if (rangeMax != null) 'rangeMax': rangeMax,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WeaponData',
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category?.toJson(),
      if (damage != null) 'damage': damage,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (properties != null)
        'properties': properties?.toJson(valueToJson: (v) => v.toJson()),
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
    _is.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    WeaponDataInclude? include,
  }) {
    return WeaponDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeaponDataImpl extends WeaponData {
  _WeaponDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _iya6mjd5.WeaponCategory? category,
    String? damage,
    _iei1ksog.DamageType? damageType,
    List<_iw4a05a7.WeaponProperty>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) : super._(
         id: id,
         referenceKey: referenceKey,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         category: category,
         damage: damage,
         damageType: damageType,
         properties: properties,
         weight: weight,
         cost: cost,
         rangeNormal: rangeNormal,
         rangeMax: rangeMax,
       );

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WeaponData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? damage = _Undefined,
    Object? damageType = _Undefined,
    Object? properties = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? rangeNormal = _Undefined,
    Object? rangeMax = _Undefined,
  }) {
    return WeaponData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is _iya6mjd5.WeaponCategory?
          ? category
          : this.category,
      damage: damage is String? ? damage : this.damage,
      damageType: damageType is _iei1ksog.DamageType?
          ? damageType
          : this.damageType,
      properties: properties is List<_iw4a05a7.WeaponProperty>?
          ? properties
          : this.properties?.map((e0) => e0).toList(),
      weight: weight is double? ? weight : this.weight,
      cost: cost is double? ? cost : this.cost,
      rangeNormal: rangeNormal is int? ? rangeNormal : this.rangeNormal,
      rangeMax: rangeMax is int? ? rangeMax : this.rangeMax,
    );
  }
}

class WeaponDataUpdateTable extends _is.UpdateTable<WeaponDataTable> {
  WeaponDataUpdateTable(super.table);

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

  _is.ColumnValue<_iya6mjd5.WeaponCategory, _iya6mjd5.WeaponCategory> category(
    _iya6mjd5.WeaponCategory? value,
  ) => _is.ColumnValue(table.category, value);

  _is.ColumnValue<String, String> damage(String? value) =>
      _is.ColumnValue(table.damage, value);

  _is.ColumnValue<_iei1ksog.DamageType, _iei1ksog.DamageType> damageType(
    _iei1ksog.DamageType? value,
  ) => _is.ColumnValue(table.damageType, value);

  _is.ColumnValue<
    List<_iw4a05a7.WeaponProperty>,
    List<_iw4a05a7.WeaponProperty>
  >
  properties(List<_iw4a05a7.WeaponProperty>? value) =>
      _is.ColumnValue(table.properties, value);

  _is.ColumnValue<double, double> weight(double? value) =>
      _is.ColumnValue(table.weight, value);

  _is.ColumnValue<double, double> cost(double? value) =>
      _is.ColumnValue(table.cost, value);

  _is.ColumnValue<int, int> rangeNormal(int? value) =>
      _is.ColumnValue(table.rangeNormal, value);

  _is.ColumnValue<int, int> rangeMax(int? value) =>
      _is.ColumnValue(table.rangeMax, value);
}

class WeaponDataTable extends _is.Table<int?> {
  WeaponDataTable({super.tableRelation}) : super(tableName: 'weapon_data') {
    updateTable = WeaponDataUpdateTable(this);
    referenceKey = _is.ColumnString('referenceKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    category = _is.ColumnEnum('category', this, _is.EnumSerialization.byName);
    damage = _is.ColumnString('damage', this);
    damageType = _is.ColumnEnum(
      'damageType',
      this,
      _is.EnumSerialization.byName,
    );
    properties = _is.ColumnSerializable<List<_iw4a05a7.WeaponProperty>>(
      'properties',
      this,
    );
    weight = _is.ColumnDouble('weight', this);
    cost = _is.ColumnDouble('cost', this);
    rangeNormal = _is.ColumnInt('rangeNormal', this);
    rangeMax = _is.ColumnInt('rangeMax', this);
  }

  late final WeaponDataUpdateTable updateTable;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnEnum<_iya6mjd5.WeaponCategory> category;

  late final _is.ColumnString damage;

  late final _is.ColumnEnum<_iei1ksog.DamageType> damageType;

  late final _is.ColumnSerializable<List<_iw4a05a7.WeaponProperty>> properties;

  late final _is.ColumnDouble weight;

  late final _is.ColumnDouble cost;

  late final _is.ColumnInt rangeNormal;

  late final _is.ColumnInt rangeMax;

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
    category,
    damage,
    damageType,
    properties,
    weight,
    cost,
    rangeNormal,
    rangeMax,
  ];
}

class WeaponDataInclude extends _is.IncludeObject {
  WeaponDataInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => WeaponData.t;
}

class WeaponDataIncludeList extends _is.IncludeList {
  WeaponDataIncludeList._({
    _is.WhereExpressionBuilder<WeaponDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(WeaponData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => WeaponData.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<WeaponData>(
      where: where?.call(WeaponData.t),
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WeaponDataTable>? where,
    int? offset,
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<WeaponData>(
      where: where?.call(WeaponData.t),
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [WeaponData] by its [id] or null if no such row exists.
  Future<WeaponData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<WeaponData>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [WeaponData]s in the list and returns the inserted rows.
  ///
  /// The returned [WeaponData]s will have their `id` fields set.
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
  Future<List<WeaponData>> insert(
    _is.DatabaseSession session,
    List<WeaponData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<WeaponData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [WeaponData] and returns the inserted row.
  ///
  /// The returned [WeaponData] will have its `id` field set.
  Future<WeaponData> insertRow(
    _is.DatabaseSession session,
    WeaponData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<WeaponData>(row, transaction: transaction);
  }

  /// Upserts all [WeaponData]s in the list and returns the resulting rows.
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
  /// The returned [WeaponData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WeaponData>> upsert(
    _is.DatabaseSession session,
    List<WeaponData> rows, {
    required _is.ColumnSelections<WeaponDataTable> conflictColumns,
    _is.ColumnSelections<WeaponDataTable>? updateColumns,
    _is.WhereExpressionBuilder<WeaponDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<WeaponData>(
      rows,
      conflictColumns: conflictColumns(WeaponData.t),
      updateColumns: updateColumns?.call(WeaponData.t),
      updateWhere: updateWhere?.call(WeaponData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [WeaponData] and returns the resulting row.
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
  /// The returned [WeaponData] will have its `id` field set.
  Future<WeaponData?> upsertRow(
    _is.DatabaseSession session,
    WeaponData row, {
    required _is.ColumnSelections<WeaponDataTable> conflictColumns,
    _is.ColumnSelections<WeaponDataTable>? updateColumns,
    _is.WhereExpressionBuilder<WeaponDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<WeaponData>(
      row,
      conflictColumns: conflictColumns(WeaponData.t),
      updateColumns: updateColumns?.call(WeaponData.t),
      updateWhere: updateWhere?.call(WeaponData.t),
      transaction: transaction,
    );
  }

  /// Updates all [WeaponData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WeaponData>> update(
    _is.DatabaseSession session,
    List<WeaponData> rows, {
    _is.ColumnSelections<WeaponDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<WeaponData>(
      rows,
      columns: columns?.call(WeaponData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [WeaponData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<WeaponData> updateRow(
    _is.DatabaseSession session,
    WeaponData row, {
    _is.ColumnSelections<WeaponDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<WeaponData>(
      row,
      columns: columns?.call(WeaponData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [WeaponData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<WeaponData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WeaponDataUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<WeaponData>(
      id,
      columnValues: columnValues(WeaponData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [WeaponData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WeaponData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WeaponDataUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WeaponDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<WeaponData>(
      columnValues: columnValues(WeaponData.t.updateTable),
      where: where(WeaponData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [WeaponData]s in the list and returns the deleted rows.
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
  Future<List<WeaponData>> delete(
    _is.DatabaseSession session,
    List<WeaponData> rows, {
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<WeaponData>(
      rows,
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [WeaponData].
  Future<WeaponData> deleteRow(
    _is.DatabaseSession session,
    WeaponData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<WeaponData>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<WeaponData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WeaponDataTable> where,
    _is.OrderByBuilder<WeaponDataTable>? orderBy,
    _is.OrderByListBuilder<WeaponDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<WeaponData>(
      where: where(WeaponData.t),
      orderBy: orderBy?.call(WeaponData.t),
      orderByList: orderByList?.call(WeaponData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WeaponDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<WeaponData>(
      where: where?.call(WeaponData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [WeaponData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WeaponDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<WeaponData>(
      where: where(WeaponData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
