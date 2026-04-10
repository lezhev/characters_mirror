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
import '../../../data/general/class/starting_equipment_option_data.dart' as _i3;
import '../../../enums/starting_equipment_line_kind.dart' as _i4;
import '../../../enums/equipment_catalog_type.dart' as _i5;
import '../../../enums/weapon_category.dart' as _i6;

abstract class StartingEquipmentLineData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StartingEquipmentLineData._({
    this.id,
    this.blockId,
    this.block,
    this.optionId,
    this.option,
    this.lineKey,
    this.orderIndex,
    this.kind,
    this.displayText,
    this.quantity,
    this.catalogType,
    this.referenceKey,
    this.allowedWeaponCategories,
    this.allowedItemCategories,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentLineData({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentLineDataImpl;

  factory StartingEquipmentLineData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentLineData(
      id: jsonSerialization['id'] as int?,
      blockId: jsonSerialization['blockId'] as int?,
      block: jsonSerialization['block'] == null
          ? null
          : _i2.StartingEquipmentBlockData.fromJson(
              (jsonSerialization['block'] as Map<String, dynamic>)),
      optionId: jsonSerialization['optionId'] as int?,
      option: jsonSerialization['option'] == null
          ? null
          : _i3.StartingEquipmentOptionData.fromJson(
              (jsonSerialization['option'] as Map<String, dynamic>)),
      lineKey: jsonSerialization['lineKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['kind'] as String)),
      displayText: jsonSerialization['displayText'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          (jsonSerialization['allowedWeaponCategories'] as List?)
              ?.map((e) => _i6.WeaponCategory.fromJson((e as String)))
              .toList(),
      allowedItemCategories:
          (jsonSerialization['allowedItemCategories'] as List?)
              ?.map((e) => e as String)
              .toList(),
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

  static final t = StartingEquipmentLineDataTable();

  static const db = StartingEquipmentLineDataRepository._();

  @override
  int? id;

  int? blockId;

  _i2.StartingEquipmentBlockData? block;

  int? optionId;

  _i3.StartingEquipmentOptionData? option;

  String? lineKey;

  int? orderIndex;

  _i4.StartingEquipmentLineKind? kind;

  String? displayText;

  int? quantity;

  _i5.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_i6.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentLineData copyWith({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (blockId != null) 'blockId': blockId,
      if (block != null) 'block': block?.toJson(),
      if (optionId != null) 'optionId': optionId,
      if (option != null) 'option': option?.toJson(),
      if (lineKey != null) 'lineKey': lineKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (displayText != null) 'displayText': displayText,
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories':
            allowedWeaponCategories?.toJson(valueToJson: (v) => v.toJson()),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
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
      if (blockId != null) 'blockId': blockId,
      if (block != null) 'block': block?.toJsonForProtocol(),
      if (optionId != null) 'optionId': optionId,
      if (option != null) 'option': option?.toJsonForProtocol(),
      if (lineKey != null) 'lineKey': lineKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (displayText != null) 'displayText': displayText,
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories':
            allowedWeaponCategories?.toJson(valueToJson: (v) => v.toJson()),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static StartingEquipmentLineDataInclude include({
    _i2.StartingEquipmentBlockDataInclude? block,
    _i3.StartingEquipmentOptionDataInclude? option,
  }) {
    return StartingEquipmentLineDataInclude._(
      block: block,
      option: option,
    );
  }

  static StartingEquipmentLineDataIncludeList includeList({
    _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentLineDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentLineDataTable>? orderByList,
    StartingEquipmentLineDataInclude? include,
  }) {
    return StartingEquipmentLineDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentLineData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StartingEquipmentLineData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentLineDataImpl extends StartingEquipmentLineData {
  _StartingEquipmentLineDataImpl({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockId: blockId,
          block: block,
          optionId: optionId,
          option: option,
          lineKey: lineKey,
          orderIndex: orderIndex,
          kind: kind,
          displayText: displayText,
          quantity: quantity,
          catalogType: catalogType,
          referenceKey: referenceKey,
          allowedWeaponCategories: allowedWeaponCategories,
          allowedItemCategories: allowedItemCategories,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentLineData copyWith({
    Object? id = _Undefined,
    Object? blockId = _Undefined,
    Object? block = _Undefined,
    Object? optionId = _Undefined,
    Object? option = _Undefined,
    Object? lineKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? displayText = _Undefined,
    Object? quantity = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? allowedWeaponCategories = _Undefined,
    Object? allowedItemCategories = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentLineData(
      id: id is int? ? id : this.id,
      blockId: blockId is int? ? blockId : this.blockId,
      block: block is _i2.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      optionId: optionId is int? ? optionId : this.optionId,
      option: option is _i3.StartingEquipmentOptionData?
          ? option
          : this.option?.copyWith(),
      lineKey: lineKey is String? ? lineKey : this.lineKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i4.StartingEquipmentLineKind? ? kind : this.kind,
      displayText: displayText is String? ? displayText : this.displayText,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i5.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_i6.WeaponCategory>?
              ? allowedWeaponCategories
              : this.allowedWeaponCategories?.map((e0) => e0).toList(),
      allowedItemCategories: allowedItemCategories is List<String>?
          ? allowedItemCategories
          : this.allowedItemCategories?.map((e0) => e0).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class StartingEquipmentLineDataTable extends _i1.Table<int?> {
  StartingEquipmentLineDataTable({super.tableRelation})
      : super(tableName: 'starting_equipment_line_data') {
    blockId = _i1.ColumnInt(
      'blockId',
      this,
    );
    optionId = _i1.ColumnInt(
      'optionId',
      this,
    );
    lineKey = _i1.ColumnString(
      'lineKey',
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
    displayText = _i1.ColumnString(
      'displayText',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    catalogType = _i1.ColumnEnum(
      'catalogType',
      this,
      _i1.EnumSerialization.byName,
    );
    referenceKey = _i1.ColumnString(
      'referenceKey',
      this,
    );
    allowedWeaponCategories = _i1.ColumnSerializable(
      'allowedWeaponCategories',
      this,
    );
    allowedItemCategories = _i1.ColumnSerializable(
      'allowedItemCategories',
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

  late final _i1.ColumnInt optionId;

  _i3.StartingEquipmentOptionDataTable? _option;

  late final _i1.ColumnString lineKey;

  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnEnum<_i4.StartingEquipmentLineKind> kind;

  late final _i1.ColumnString displayText;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnEnum<_i5.EquipmentCatalogType> catalogType;

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnSerializable allowedWeaponCategories;

  late final _i1.ColumnSerializable allowedItemCategories;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.StartingEquipmentBlockDataTable get block {
    if (_block != null) return _block!;
    _block = _i1.createRelationTable(
      relationFieldName: 'block',
      field: StartingEquipmentLineData.t.blockId,
      foreignField: _i2.StartingEquipmentBlockData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.StartingEquipmentBlockDataTable(
              tableRelation: foreignTableRelation),
    );
    return _block!;
  }

  _i3.StartingEquipmentOptionDataTable get option {
    if (_option != null) return _option!;
    _option = _i1.createRelationTable(
      relationFieldName: 'option',
      field: StartingEquipmentLineData.t.optionId,
      foreignField: _i3.StartingEquipmentOptionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.StartingEquipmentOptionDataTable(
              tableRelation: foreignTableRelation),
    );
    return _option!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        blockId,
        optionId,
        lineKey,
        orderIndex,
        kind,
        displayText,
        quantity,
        catalogType,
        referenceKey,
        allowedWeaponCategories,
        allowedItemCategories,
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
    if (relationField == 'option') {
      return option;
    }
    return null;
  }
}

class StartingEquipmentLineDataInclude extends _i1.IncludeObject {
  StartingEquipmentLineDataInclude._({
    _i2.StartingEquipmentBlockDataInclude? block,
    _i3.StartingEquipmentOptionDataInclude? option,
  }) {
    _block = block;
    _option = option;
  }

  _i2.StartingEquipmentBlockDataInclude? _block;

  _i3.StartingEquipmentOptionDataInclude? _option;

  @override
  Map<String, _i1.Include?> get includes => {
        'block': _block,
        'option': _option,
      };

  @override
  _i1.Table<int?> get table => StartingEquipmentLineData.t;
}

class StartingEquipmentLineDataIncludeList extends _i1.IncludeList {
  StartingEquipmentLineDataIncludeList._({
    _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartingEquipmentLineData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StartingEquipmentLineData.t;
}

class StartingEquipmentLineDataRepository {
  const StartingEquipmentLineDataRepository._();

  final attachRow = const StartingEquipmentLineDataAttachRowRepository._();

  final detachRow = const StartingEquipmentLineDataDetachRowRepository._();

  /// Returns a list of [StartingEquipmentLineData]s matching the given query parameters.
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
  Future<List<StartingEquipmentLineData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentLineDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentLineDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentLineDataInclude? include,
  }) async {
    return session.db.find<StartingEquipmentLineData>(
      where: where?.call(StartingEquipmentLineData.t),
      orderBy: orderBy?.call(StartingEquipmentLineData.t),
      orderByList: orderByList?.call(StartingEquipmentLineData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StartingEquipmentLineData] matching the given query parameters.
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
  Future<StartingEquipmentLineData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentLineDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentLineDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentLineDataInclude? include,
  }) async {
    return session.db.findFirstRow<StartingEquipmentLineData>(
      where: where?.call(StartingEquipmentLineData.t),
      orderBy: orderBy?.call(StartingEquipmentLineData.t),
      orderByList: orderByList?.call(StartingEquipmentLineData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StartingEquipmentLineData] by its [id] or null if no such row exists.
  Future<StartingEquipmentLineData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StartingEquipmentLineDataInclude? include,
  }) async {
    return session.db.findById<StartingEquipmentLineData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StartingEquipmentLineData]s in the list and returns the inserted rows.
  ///
  /// The returned [StartingEquipmentLineData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StartingEquipmentLineData>> insert(
    _i1.Session session,
    List<StartingEquipmentLineData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StartingEquipmentLineData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StartingEquipmentLineData] and returns the inserted row.
  ///
  /// The returned [StartingEquipmentLineData] will have its `id` field set.
  Future<StartingEquipmentLineData> insertRow(
    _i1.Session session,
    StartingEquipmentLineData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartingEquipmentLineData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentLineData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StartingEquipmentLineData>> update(
    _i1.Session session,
    List<StartingEquipmentLineData> rows, {
    _i1.ColumnSelections<StartingEquipmentLineDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StartingEquipmentLineData>(
      rows,
      columns: columns?.call(StartingEquipmentLineData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartingEquipmentLineData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartingEquipmentLineData> updateRow(
    _i1.Session session,
    StartingEquipmentLineData row, {
    _i1.ColumnSelections<StartingEquipmentLineDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartingEquipmentLineData>(
      row,
      columns: columns?.call(StartingEquipmentLineData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StartingEquipmentLineData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StartingEquipmentLineData>> delete(
    _i1.Session session,
    List<StartingEquipmentLineData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StartingEquipmentLineData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StartingEquipmentLineData].
  Future<StartingEquipmentLineData> deleteRow(
    _i1.Session session,
    StartingEquipmentLineData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartingEquipmentLineData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StartingEquipmentLineData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StartingEquipmentLineData>(
      where: where(StartingEquipmentLineData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentLineDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StartingEquipmentLineData>(
      where: where?.call(StartingEquipmentLineData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StartingEquipmentLineDataAttachRowRepository {
  const StartingEquipmentLineDataAttachRowRepository._();

  /// Creates a relation between the given [StartingEquipmentLineData] and [StartingEquipmentBlockData]
  /// by setting the [StartingEquipmentLineData]'s foreign key `blockId` to refer to the [StartingEquipmentBlockData].
  Future<void> block(
    _i1.Session session,
    StartingEquipmentLineData startingEquipmentLineData,
    _i2.StartingEquipmentBlockData block, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentLineData.id == null) {
      throw ArgumentError.notNull('startingEquipmentLineData.id');
    }
    if (block.id == null) {
      throw ArgumentError.notNull('block.id');
    }

    var $startingEquipmentLineData =
        startingEquipmentLineData.copyWith(blockId: block.id);
    await session.db.updateRow<StartingEquipmentLineData>(
      $startingEquipmentLineData,
      columns: [StartingEquipmentLineData.t.blockId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StartingEquipmentLineData] and [StartingEquipmentOptionData]
  /// by setting the [StartingEquipmentLineData]'s foreign key `optionId` to refer to the [StartingEquipmentOptionData].
  Future<void> option(
    _i1.Session session,
    StartingEquipmentLineData startingEquipmentLineData,
    _i3.StartingEquipmentOptionData option, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentLineData.id == null) {
      throw ArgumentError.notNull('startingEquipmentLineData.id');
    }
    if (option.id == null) {
      throw ArgumentError.notNull('option.id');
    }

    var $startingEquipmentLineData =
        startingEquipmentLineData.copyWith(optionId: option.id);
    await session.db.updateRow<StartingEquipmentLineData>(
      $startingEquipmentLineData,
      columns: [StartingEquipmentLineData.t.optionId],
      transaction: transaction,
    );
  }
}

class StartingEquipmentLineDataDetachRowRepository {
  const StartingEquipmentLineDataDetachRowRepository._();

  /// Detaches the relation between this [StartingEquipmentLineData] and the [StartingEquipmentBlockData] set in `block`
  /// by setting the [StartingEquipmentLineData]'s foreign key `blockId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> block(
    _i1.Session session,
    StartingEquipmentLineData startingequipmentlinedata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmentlinedata.id == null) {
      throw ArgumentError.notNull('startingequipmentlinedata.id');
    }

    var $startingequipmentlinedata =
        startingequipmentlinedata.copyWith(blockId: null);
    await session.db.updateRow<StartingEquipmentLineData>(
      $startingequipmentlinedata,
      columns: [StartingEquipmentLineData.t.blockId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [StartingEquipmentLineData] and the [StartingEquipmentOptionData] set in `option`
  /// by setting the [StartingEquipmentLineData]'s foreign key `optionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> option(
    _i1.Session session,
    StartingEquipmentLineData startingequipmentlinedata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmentlinedata.id == null) {
      throw ArgumentError.notNull('startingequipmentlinedata.id');
    }

    var $startingequipmentlinedata =
        startingequipmentlinedata.copyWith(optionId: null);
    await session.db.updateRow<StartingEquipmentLineData>(
      $startingequipmentlinedata,
      columns: [StartingEquipmentLineData.t.optionId],
      transaction: transaction,
    );
  }
}
