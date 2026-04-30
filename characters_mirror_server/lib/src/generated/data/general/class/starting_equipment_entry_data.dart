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
import '../../../data/general/class/class_data.dart' as _i2;
import '../../../data/background_data.dart' as _i3;
import '../../../enums/starting_equipment_entry_kind.dart' as _i4;
import '../../../enums/starting_equipment_line_kind.dart' as _i5;
import '../../../enums/equipment_catalog_type.dart' as _i6;
import '../../../enums/weapon_category.dart' as _i7;

abstract class StartingEquipmentEntryData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  StartingEquipmentEntryData._({
    this.id,
    this.sourceClassId,
    this.sourceClass,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.parentEntryId,
    this.kind,
    this.orderIndex,
    this.selectionCount,
    this.lineKind,
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

  factory StartingEquipmentEntryData({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentEntryDataImpl;

  factory StartingEquipmentEntryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentEntryData(
      id: jsonSerialization['id'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i3.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.StartingEquipmentEntryKind.fromJson(
              (jsonSerialization['kind'] as String)),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      selectionCount: jsonSerialization['selectionCount'] as int?,
      lineKind: jsonSerialization['lineKind'] == null
          ? null
          : _i5.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['lineKind'] as String)),
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i6.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          (jsonSerialization['allowedWeaponCategories'] as List?)
              ?.map((e) => _i7.WeaponCategory.fromJson((e as String)))
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

  static final t = StartingEquipmentEntryDataTable();

  static const db = StartingEquipmentEntryDataRepository._();

  @override
  int? id;

  int? sourceClassId;

  _i2.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i3.BackgroundData? sourceBackground;

  int? parentEntryId;

  _i4.StartingEquipmentEntryKind? kind;

  int? orderIndex;

  int? selectionCount;

  _i5.StartingEquipmentLineKind? lineKind;

  int? quantity;

  _i6.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_i7.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentEntryData copyWith({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
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
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (kind != null) 'kind': kind?.toJson(),
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (lineKind != null) 'lineKind': lineKind?.toJson(),
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
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJsonForProtocol(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (kind != null) 'kind': kind?.toJson(),
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (lineKind != null) 'lineKind': lineKind?.toJson(),
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

  static StartingEquipmentEntryDataInclude include({
    _i2.ClassDataInclude? sourceClass,
    _i3.BackgroundDataInclude? sourceBackground,
  }) {
    return StartingEquipmentEntryDataInclude._(
      sourceClass: sourceClass,
      sourceBackground: sourceBackground,
    );
  }

  static StartingEquipmentEntryDataIncludeList includeList({
    _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    StartingEquipmentEntryDataInclude? include,
  }) {
    return StartingEquipmentEntryDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentEntryDataImpl extends StartingEquipmentEntryData {
  _StartingEquipmentEntryDataImpl({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          parentEntryId: parentEntryId,
          kind: kind,
          orderIndex: orderIndex,
          selectionCount: selectionCount,
          lineKind: lineKind,
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

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentEntryData copyWith({
    Object? id = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? parentEntryId = _Undefined,
    Object? kind = _Undefined,
    Object? orderIndex = _Undefined,
    Object? selectionCount = _Undefined,
    Object? lineKind = _Undefined,
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
    return StartingEquipmentEntryData(
      id: id is int? ? id : this.id,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i2.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i3.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      kind: kind is _i4.StartingEquipmentEntryKind? ? kind : this.kind,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      lineKind:
          lineKind is _i5.StartingEquipmentLineKind? ? lineKind : this.lineKind,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i6.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_i7.WeaponCategory>?
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

class StartingEquipmentEntryDataTable extends _i1.Table<int?> {
  StartingEquipmentEntryDataTable({super.tableRelation})
      : super(tableName: 'starting_equipment_entry_data') {
    sourceClassId = _i1.ColumnInt(
      'sourceClassId',
      this,
    );
    sourceBackgroundId = _i1.ColumnInt(
      'sourceBackgroundId',
      this,
    );
    parentEntryId = _i1.ColumnInt(
      'parentEntryId',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    orderIndex = _i1.ColumnInt(
      'orderIndex',
      this,
    );
    selectionCount = _i1.ColumnInt(
      'selectionCount',
      this,
    );
    lineKind = _i1.ColumnEnum(
      'lineKind',
      this,
      _i1.EnumSerialization.byName,
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

  late final _i1.ColumnInt sourceClassId;

  _i2.ClassDataTable? _sourceClass;

  late final _i1.ColumnInt sourceBackgroundId;

  _i3.BackgroundDataTable? _sourceBackground;

  late final _i1.ColumnInt parentEntryId;

  late final _i1.ColumnEnum<_i4.StartingEquipmentEntryKind> kind;

  late final _i1.ColumnInt orderIndex;

  late final _i1.ColumnInt selectionCount;

  late final _i1.ColumnEnum<_i5.StartingEquipmentLineKind> lineKind;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnEnum<_i6.EquipmentCatalogType> catalogType;

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnSerializable allowedWeaponCategories;

  late final _i1.ColumnSerializable allowedItemCategories;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _i1.createRelationTable(
      relationFieldName: 'sourceClass',
      field: StartingEquipmentEntryData.t.sourceClassId,
      foreignField: _i2.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _i3.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _i1.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: StartingEquipmentEntryData.t.sourceBackgroundId,
      foreignField: _i3.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        sourceClassId,
        sourceBackgroundId,
        parentEntryId,
        kind,
        orderIndex,
        selectionCount,
        lineKind,
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
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceBackground') {
      return sourceBackground;
    }
    return null;
  }
}

class StartingEquipmentEntryDataInclude extends _i1.IncludeObject {
  StartingEquipmentEntryDataInclude._({
    _i2.ClassDataInclude? sourceClass,
    _i3.BackgroundDataInclude? sourceBackground,
  }) {
    _sourceClass = sourceClass;
    _sourceBackground = sourceBackground;
  }

  _i2.ClassDataInclude? _sourceClass;

  _i3.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _i1.Include?> get includes => {
        'sourceClass': _sourceClass,
        'sourceBackground': _sourceBackground,
      };

  @override
  _i1.Table<int?> get table => StartingEquipmentEntryData.t;
}

class StartingEquipmentEntryDataIncludeList extends _i1.IncludeList {
  StartingEquipmentEntryDataIncludeList._({
    _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartingEquipmentEntryData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => StartingEquipmentEntryData.t;
}

class StartingEquipmentEntryDataRepository {
  const StartingEquipmentEntryDataRepository._();

  final attachRow = const StartingEquipmentEntryDataAttachRowRepository._();

  final detachRow = const StartingEquipmentEntryDataDetachRowRepository._();

  /// Returns a list of [StartingEquipmentEntryData]s matching the given query parameters.
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
  Future<List<StartingEquipmentEntryData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
  }) async {
    return session.db.find<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [StartingEquipmentEntryData] matching the given query parameters.
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
  Future<StartingEquipmentEntryData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _i1.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
  }) async {
    return session.db.findFirstRow<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [StartingEquipmentEntryData] by its [id] or null if no such row exists.
  Future<StartingEquipmentEntryData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
  }) async {
    return session.db.findById<StartingEquipmentEntryData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [StartingEquipmentEntryData]s in the list and returns the inserted rows.
  ///
  /// The returned [StartingEquipmentEntryData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StartingEquipmentEntryData>> insert(
    _i1.Session session,
    List<StartingEquipmentEntryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StartingEquipmentEntryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StartingEquipmentEntryData] and returns the inserted row.
  ///
  /// The returned [StartingEquipmentEntryData] will have its `id` field set.
  Future<StartingEquipmentEntryData> insertRow(
    _i1.Session session,
    StartingEquipmentEntryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartingEquipmentEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentEntryData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StartingEquipmentEntryData>> update(
    _i1.Session session,
    List<StartingEquipmentEntryData> rows, {
    _i1.ColumnSelections<StartingEquipmentEntryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StartingEquipmentEntryData>(
      rows,
      columns: columns?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartingEquipmentEntryData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartingEquipmentEntryData> updateRow(
    _i1.Session session,
    StartingEquipmentEntryData row, {
    _i1.ColumnSelections<StartingEquipmentEntryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartingEquipmentEntryData>(
      row,
      columns: columns?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StartingEquipmentEntryData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StartingEquipmentEntryData>> delete(
    _i1.Session session,
    List<StartingEquipmentEntryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StartingEquipmentEntryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StartingEquipmentEntryData].
  Future<StartingEquipmentEntryData> deleteRow(
    _i1.Session session,
    StartingEquipmentEntryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartingEquipmentEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StartingEquipmentEntryData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StartingEquipmentEntryData>(
      where: where(StartingEquipmentEntryData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class StartingEquipmentEntryDataAttachRowRepository {
  const StartingEquipmentEntryDataAttachRowRepository._();

  /// Creates a relation between the given [StartingEquipmentEntryData] and [ClassData]
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _i1.Session session,
    StartingEquipmentEntryData startingEquipmentEntryData,
    _i2.ClassData sourceClass, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $startingEquipmentEntryData =
        startingEquipmentEntryData.copyWith(sourceClassId: sourceClass.id);
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingEquipmentEntryData,
      columns: [StartingEquipmentEntryData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StartingEquipmentEntryData] and [BackgroundData]
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _i1.Session session,
    StartingEquipmentEntryData startingEquipmentEntryData,
    _i3.BackgroundData sourceBackground, {
    _i1.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $startingEquipmentEntryData = startingEquipmentEntryData.copyWith(
        sourceBackgroundId: sourceBackground.id);
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingEquipmentEntryData,
      columns: [StartingEquipmentEntryData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}

class StartingEquipmentEntryDataDetachRowRepository {
  const StartingEquipmentEntryDataDetachRowRepository._();

  /// Detaches the relation between this [StartingEquipmentEntryData] and the [ClassData] set in `sourceClass`
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceClassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceClass(
    _i1.Session session,
    StartingEquipmentEntryData startingequipmententrydata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmententrydata.id == null) {
      throw ArgumentError.notNull('startingequipmententrydata.id');
    }

    var $startingequipmententrydata =
        startingequipmententrydata.copyWith(sourceClassId: null);
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingequipmententrydata,
      columns: [StartingEquipmentEntryData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [StartingEquipmentEntryData] and the [BackgroundData] set in `sourceBackground`
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceBackgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceBackground(
    _i1.Session session,
    StartingEquipmentEntryData startingequipmententrydata, {
    _i1.Transaction? transaction,
  }) async {
    if (startingequipmententrydata.id == null) {
      throw ArgumentError.notNull('startingequipmententrydata.id');
    }

    var $startingequipmententrydata =
        startingequipmententrydata.copyWith(sourceBackgroundId: null);
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingequipmententrydata,
      columns: [StartingEquipmentEntryData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
