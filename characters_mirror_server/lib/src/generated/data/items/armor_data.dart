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
import '../../enums/armor_category.dart' as _i2;

abstract class ArmorData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ArmorData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.categoryValue,
    this.baseAC,
    this.bonusAC,
    this.dexBonus,
    this.dexBonusMax,
    this.strengthRequirement,
    this.stealthDisadvantage,
    this.weight,
    this.cost,
  });

  factory ArmorData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) = _ArmorDataImpl;

  factory ArmorData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArmorData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
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
      categoryValue: jsonSerialization['categoryValue'] == null
          ? null
          : _i2.ArmorCategory.fromJson(
              (jsonSerialization['categoryValue'] as String)),
      baseAC: jsonSerialization['baseAC'] as int?,
      bonusAC: jsonSerialization['bonusAC'] as int?,
      dexBonus: jsonSerialization['dexBonus'] as bool?,
      dexBonusMax: jsonSerialization['dexBonusMax'] as int?,
      strengthRequirement: jsonSerialization['strengthRequirement'] as int?,
      stealthDisadvantage: jsonSerialization['stealthDisadvantage'] as bool?,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as String?,
    );
  }

  static final t = ArmorDataTable();

  static const db = ArmorDataRepository._();

  @override
  int? id;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  _i2.ArmorCategory? categoryValue;

  int? baseAC;

  int? bonusAC;

  bool? dexBonus;

  int? dexBonusMax;

  int? strengthRequirement;

  bool? stealthDisadvantage;

  double? weight;

  String? cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ArmorData copyWith({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (categoryValue != null) 'categoryValue': categoryValue?.toJson(),
      if (baseAC != null) 'baseAC': baseAC,
      if (bonusAC != null) 'bonusAC': bonusAC,
      if (dexBonus != null) 'dexBonus': dexBonus,
      if (dexBonusMax != null) 'dexBonusMax': dexBonusMax,
      if (strengthRequirement != null)
        'strengthRequirement': strengthRequirement,
      if (stealthDisadvantage != null)
        'stealthDisadvantage': stealthDisadvantage,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (categoryValue != null) 'categoryValue': categoryValue?.toJson(),
      if (baseAC != null) 'baseAC': baseAC,
      if (bonusAC != null) 'bonusAC': bonusAC,
      if (dexBonus != null) 'dexBonus': dexBonus,
      if (dexBonusMax != null) 'dexBonusMax': dexBonusMax,
      if (strengthRequirement != null)
        'strengthRequirement': strengthRequirement,
      if (stealthDisadvantage != null)
        'stealthDisadvantage': stealthDisadvantage,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
    };
  }

  static ArmorDataInclude include() {
    return ArmorDataInclude._();
  }

  static ArmorDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArmorDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArmorDataTable>? orderByList,
    ArmorDataInclude? include,
  }) {
    return ArmorDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ArmorData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ArmorData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArmorDataImpl extends ArmorData {
  _ArmorDataImpl({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    int? bonusAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          categoryValue: categoryValue,
          baseAC: baseAC,
          bonusAC: bonusAC,
          dexBonus: dexBonus,
          dexBonusMax: dexBonusMax,
          strengthRequirement: strengthRequirement,
          stealthDisadvantage: stealthDisadvantage,
          weight: weight,
          cost: cost,
        );

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ArmorData copyWith({
    Object? id = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? categoryValue = _Undefined,
    Object? baseAC = _Undefined,
    Object? bonusAC = _Undefined,
    Object? dexBonus = _Undefined,
    Object? dexBonusMax = _Undefined,
    Object? strengthRequirement = _Undefined,
    Object? stealthDisadvantage = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
  }) {
    return ArmorData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      categoryValue: categoryValue is _i2.ArmorCategory?
          ? categoryValue
          : this.categoryValue,
      baseAC: baseAC is int? ? baseAC : this.baseAC,
      bonusAC: bonusAC is int? ? bonusAC : this.bonusAC,
      dexBonus: dexBonus is bool? ? dexBonus : this.dexBonus,
      dexBonusMax: dexBonusMax is int? ? dexBonusMax : this.dexBonusMax,
      strengthRequirement: strengthRequirement is int?
          ? strengthRequirement
          : this.strengthRequirement,
      stealthDisadvantage: stealthDisadvantage is bool?
          ? stealthDisadvantage
          : this.stealthDisadvantage,
      weight: weight is double? ? weight : this.weight,
      cost: cost is String? ? cost : this.cost,
    );
  }
}

class ArmorDataTable extends _i1.Table<int?> {
  ArmorDataTable({super.tableRelation}) : super(tableName: 'armor_data') {
    referenceKey = _i1.ColumnString(
      'referenceKey',
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
    categoryValue = _i1.ColumnEnum(
      'categoryValue',
      this,
      _i1.EnumSerialization.byName,
    );
    baseAC = _i1.ColumnInt(
      'baseAC',
      this,
    );
    bonusAC = _i1.ColumnInt(
      'bonusAC',
      this,
    );
    dexBonus = _i1.ColumnBool(
      'dexBonus',
      this,
    );
    dexBonusMax = _i1.ColumnInt(
      'dexBonusMax',
      this,
    );
    strengthRequirement = _i1.ColumnInt(
      'strengthRequirement',
      this,
    );
    stealthDisadvantage = _i1.ColumnBool(
      'stealthDisadvantage',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
    cost = _i1.ColumnString(
      'cost',
      this,
    );
  }

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnEnum<_i2.ArmorCategory> categoryValue;

  late final _i1.ColumnInt baseAC;

  late final _i1.ColumnInt bonusAC;

  late final _i1.ColumnBool dexBonus;

  late final _i1.ColumnInt dexBonusMax;

  late final _i1.ColumnInt strengthRequirement;

  late final _i1.ColumnBool stealthDisadvantage;

  late final _i1.ColumnDouble weight;

  late final _i1.ColumnString cost;

  @override
  List<_i1.Column> get columns => [
        id,
        referenceKey,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        categoryValue,
        baseAC,
        bonusAC,
        dexBonus,
        dexBonusMax,
        strengthRequirement,
        stealthDisadvantage,
        weight,
        cost,
      ];
}

class ArmorDataInclude extends _i1.IncludeObject {
  ArmorDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ArmorData.t;
}

class ArmorDataIncludeList extends _i1.IncludeList {
  ArmorDataIncludeList._({
    _i1.WhereExpressionBuilder<ArmorDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ArmorData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ArmorData.t;
}

class ArmorDataRepository {
  const ArmorDataRepository._();

  /// Returns a list of [ArmorData]s matching the given query parameters.
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
  Future<List<ArmorData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ArmorDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArmorDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ArmorData>(
      where: where?.call(ArmorData.t),
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ArmorData] matching the given query parameters.
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
  Future<ArmorData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArmorDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ArmorDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ArmorDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ArmorData>(
      where: where?.call(ArmorData.t),
      orderBy: orderBy?.call(ArmorData.t),
      orderByList: orderByList?.call(ArmorData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ArmorData] by its [id] or null if no such row exists.
  Future<ArmorData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ArmorData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ArmorData]s in the list and returns the inserted rows.
  ///
  /// The returned [ArmorData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ArmorData>> insert(
    _i1.Session session,
    List<ArmorData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ArmorData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ArmorData] and returns the inserted row.
  ///
  /// The returned [ArmorData] will have its `id` field set.
  Future<ArmorData> insertRow(
    _i1.Session session,
    ArmorData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ArmorData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ArmorData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ArmorData>> update(
    _i1.Session session,
    List<ArmorData> rows, {
    _i1.ColumnSelections<ArmorDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ArmorData>(
      rows,
      columns: columns?.call(ArmorData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ArmorData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ArmorData> updateRow(
    _i1.Session session,
    ArmorData row, {
    _i1.ColumnSelections<ArmorDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ArmorData>(
      row,
      columns: columns?.call(ArmorData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ArmorData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ArmorData>> delete(
    _i1.Session session,
    List<ArmorData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ArmorData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ArmorData].
  Future<ArmorData> deleteRow(
    _i1.Session session,
    ArmorData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ArmorData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ArmorData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ArmorDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ArmorData>(
      where: where(ArmorData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ArmorDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ArmorData>(
      where: where?.call(ArmorData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
