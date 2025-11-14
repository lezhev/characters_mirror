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

abstract class MagicItemData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MagicItemData._({
    this.id,
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
  }) : _charactersMagicitemsCharactersId = null;

  factory MagicItemData({
    int? id,
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
    return MagicItemDataImplicit._(
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
      rarity: jsonSerialization['rarity'] as String?,
      type: jsonSerialization['type'] as String?,
      requiresAttunement: jsonSerialization['requiresAttunement'] as bool?,
      attunementCondition: jsonSerialization['attunementCondition'] as String?,
      bonus: (jsonSerialization['bonus'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            v as int,
          )),
      charges: jsonSerialization['charges'] as int?,
      rechargeCondition: jsonSerialization['rechargeCondition'] as String?,
      effects: (jsonSerialization['effects'] as List?)
          ?.map((e) => e as String)
          .toList(),
      $_charactersMagicitemsCharactersId:
          jsonSerialization['_charactersMagicitemsCharactersId'] as int?,
    );
  }

  static final t = MagicItemDataTable();

  static const db = MagicItemDataRepository._();

  @override
  int? id;

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

  final int? _charactersMagicitemsCharactersId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MagicItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MagicItemData copyWith({
    int? id,
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
      if (id != null) 'id': id,
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
      if (_charactersMagicitemsCharactersId != null)
        '_charactersMagicitemsCharactersId': _charactersMagicitemsCharactersId,
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
    _i1.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MagicItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicItemDataTable>? orderByList,
    MagicItemDataInclude? include,
  }) {
    return MagicItemDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MagicItemData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MagicItemData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MagicItemDataImpl extends MagicItemData {
  _MagicItemDataImpl({
    int? id,
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
  @_i1.useResult
  @override
  MagicItemData copyWith({
    Object? id = _Undefined,
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
    return MagicItemDataImplicit._(
      id: id is int? ? id : this.id,
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
          : this.bonus?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      charges: charges is int? ? charges : this.charges,
      rechargeCondition: rechargeCondition is String?
          ? rechargeCondition
          : this.rechargeCondition,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
      $_charactersMagicitemsCharactersId:
          this._charactersMagicitemsCharactersId,
    );
  }
}

class MagicItemDataImplicit extends _MagicItemDataImpl {
  MagicItemDataImplicit._({
    int? id,
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
    int? $_charactersMagicitemsCharactersId,
  })  : _charactersMagicitemsCharactersId = $_charactersMagicitemsCharactersId,
        super(
          id: id,
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

  factory MagicItemDataImplicit(
    MagicItemData magicItemData, {
    int? $_charactersMagicitemsCharactersId,
  }) {
    return MagicItemDataImplicit._(
      id: magicItemData.id,
      name: magicItemData.name,
      description: magicItemData.description,
      source: magicItemData.source,
      version: magicItemData.version,
      createdAt: magicItemData.createdAt,
      updatedAt: magicItemData.updatedAt,
      rarity: magicItemData.rarity,
      type: magicItemData.type,
      requiresAttunement: magicItemData.requiresAttunement,
      attunementCondition: magicItemData.attunementCondition,
      bonus: magicItemData.bonus,
      charges: magicItemData.charges,
      rechargeCondition: magicItemData.rechargeCondition,
      effects: magicItemData.effects,
      $_charactersMagicitemsCharactersId: $_charactersMagicitemsCharactersId,
    );
  }

  @override
  final int? _charactersMagicitemsCharactersId;
}

class MagicItemDataTable extends _i1.Table<int?> {
  MagicItemDataTable({super.tableRelation})
      : super(tableName: 'magic_item_data') {
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
    rarity = _i1.ColumnString(
      'rarity',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    requiresAttunement = _i1.ColumnBool(
      'requiresAttunement',
      this,
    );
    attunementCondition = _i1.ColumnString(
      'attunementCondition',
      this,
    );
    bonus = _i1.ColumnSerializable(
      'bonus',
      this,
    );
    charges = _i1.ColumnInt(
      'charges',
      this,
    );
    rechargeCondition = _i1.ColumnString(
      'rechargeCondition',
      this,
    );
    effects = _i1.ColumnSerializable(
      'effects',
      this,
    );
    $_charactersMagicitemsCharactersId = _i1.ColumnInt(
      '_charactersMagicitemsCharactersId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnString rarity;

  late final _i1.ColumnString type;

  late final _i1.ColumnBool requiresAttunement;

  late final _i1.ColumnString attunementCondition;

  late final _i1.ColumnSerializable bonus;

  late final _i1.ColumnInt charges;

  late final _i1.ColumnString rechargeCondition;

  late final _i1.ColumnSerializable effects;

  late final _i1.ColumnInt $_charactersMagicitemsCharactersId;

  @override
  List<_i1.Column> get columns => [
        id,
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
        $_charactersMagicitemsCharactersId,
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

class MagicItemDataInclude extends _i1.IncludeObject {
  MagicItemDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MagicItemData.t;
}

class MagicItemDataIncludeList extends _i1.IncludeList {
  MagicItemDataIncludeList._({
    _i1.WhereExpressionBuilder<MagicItemDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MagicItemData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MagicItemData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MagicItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<MagicItemData>(
      where: where?.call(MagicItemData.t),
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<MagicItemDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MagicItemDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<MagicItemData>(
      where: where?.call(MagicItemData.t),
      orderBy: orderBy?.call(MagicItemData.t),
      orderByList: orderByList?.call(MagicItemData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [MagicItemData] by its [id] or null if no such row exists.
  Future<MagicItemData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<MagicItemData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [MagicItemData]s in the list and returns the inserted rows.
  ///
  /// The returned [MagicItemData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<MagicItemData>> insert(
    _i1.Session session,
    List<MagicItemData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<MagicItemData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [MagicItemData] and returns the inserted row.
  ///
  /// The returned [MagicItemData] will have its `id` field set.
  Future<MagicItemData> insertRow(
    _i1.Session session,
    MagicItemData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MagicItemData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MagicItemData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MagicItemData>> update(
    _i1.Session session,
    List<MagicItemData> rows, {
    _i1.ColumnSelections<MagicItemDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MagicItemData>(
      rows,
      columns: columns?.call(MagicItemData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MagicItemData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MagicItemData> updateRow(
    _i1.Session session,
    MagicItemData row, {
    _i1.ColumnSelections<MagicItemDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MagicItemData>(
      row,
      columns: columns?.call(MagicItemData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [MagicItemData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MagicItemData>> delete(
    _i1.Session session,
    List<MagicItemData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MagicItemData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MagicItemData].
  Future<MagicItemData> deleteRow(
    _i1.Session session,
    MagicItemData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MagicItemData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MagicItemData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MagicItemDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MagicItemData>(
      where: where(MagicItemData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MagicItemDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MagicItemData>(
      where: where?.call(MagicItemData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
