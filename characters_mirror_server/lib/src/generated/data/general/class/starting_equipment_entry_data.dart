/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/background_data.dart' as _i1utzyju;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../enums/equipment_catalog_type.dart' as _i5zaboz2;
import '../../../enums/starting_equipment_entry_kind.dart' as _ibdnjdmg;
import '../../../enums/starting_equipment_line_kind.dart' as _iupdx0br;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class StartingEquipmentEntryData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentEntryDataImpl;

  factory StartingEquipmentEntryData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartingEquipmentEntryData(
      id: jsonSerialization['id'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i1utzyju.BackgroundData>(
              jsonSerialization['sourceBackground'],
            ),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _ibdnjdmg.StartingEquipmentEntryKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      selectionCount: jsonSerialization['selectionCount'] as int?,
      lineKind: jsonSerialization['lineKind'] == null
          ? null
          : _iupdx0br.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['lineKind'] as String),
            ),
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5zaboz2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String),
            ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          jsonSerialization['allowedWeaponCategories'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['allowedWeaponCategories'],
            ),
      allowedItemCategories: jsonSerialization['allowedItemCategories'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['allowedItemCategories'],
            ),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = StartingEquipmentEntryDataTable();

  static const db = StartingEquipmentEntryDataRepository._();

  @override
  int? id;

  int? sourceClassId;

  _i7s9vfyh.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i1utzyju.BackgroundData? sourceBackground;

  int? parentEntryId;

  _ibdnjdmg.StartingEquipmentEntryKind? kind;

  int? orderIndex;

  int? selectionCount;

  _iupdx0br.StartingEquipmentLineKind? lineKind;

  int? quantity;

  _i5zaboz2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StartingEquipmentEntryData copyWith({
    int? id,
    int? sourceClassId,
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartingEquipmentEntryData',
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
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      '__className__': 'StartingEquipmentEntryData',
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
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static StartingEquipmentEntryDataInclude include({
    _i7s9vfyh.ClassDataInclude? sourceClass,
    _i1utzyju.BackgroundDataInclude? sourceBackground,
  }) {
    return StartingEquipmentEntryDataInclude._(
      sourceClass: sourceClass,
      sourceBackground: sourceBackground,
    );
  }

  static StartingEquipmentEntryDataIncludeList includeList({
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    StartingEquipmentEntryDataInclude? include,
  }) {
    return StartingEquipmentEntryDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentEntryDataImpl extends StartingEquipmentEntryData {
  _StartingEquipmentEntryDataImpl({
    int? id,
    int? sourceClassId,
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
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
  @_is.useResult
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
      sourceClass: sourceClass is _i7s9vfyh.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i1utzyju.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      kind: kind is _ibdnjdmg.StartingEquipmentEntryKind? ? kind : this.kind,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      selectionCount: selectionCount is int?
          ? selectionCount
          : this.selectionCount,
      lineKind: lineKind is _iupdx0br.StartingEquipmentLineKind?
          ? lineKind
          : this.lineKind,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i5zaboz2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_ibtz7e0l.WeaponCategory>?
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

class StartingEquipmentEntryDataUpdateTable
    extends _is.UpdateTable<StartingEquipmentEntryDataTable> {
  StartingEquipmentEntryDataUpdateTable(super.table);

  _is.ColumnValue<int, int> sourceClassId(int? value) =>
      _is.ColumnValue(table.sourceClassId, value);

  _is.ColumnValue<int, int> sourceBackgroundId(int? value) =>
      _is.ColumnValue(table.sourceBackgroundId, value);

  _is.ColumnValue<int, int> parentEntryId(int? value) =>
      _is.ColumnValue(table.parentEntryId, value);

  _is.ColumnValue<
    _ibdnjdmg.StartingEquipmentEntryKind,
    _ibdnjdmg.StartingEquipmentEntryKind
  >
  kind(_ibdnjdmg.StartingEquipmentEntryKind? value) =>
      _is.ColumnValue(table.kind, value);

  _is.ColumnValue<int, int> orderIndex(int? value) =>
      _is.ColumnValue(table.orderIndex, value);

  _is.ColumnValue<int, int> selectionCount(int? value) =>
      _is.ColumnValue(table.selectionCount, value);

  _is.ColumnValue<
    _iupdx0br.StartingEquipmentLineKind,
    _iupdx0br.StartingEquipmentLineKind
  >
  lineKind(_iupdx0br.StartingEquipmentLineKind? value) =>
      _is.ColumnValue(table.lineKind, value);

  _is.ColumnValue<int, int> quantity(int? value) =>
      _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<
    _i5zaboz2.EquipmentCatalogType,
    _i5zaboz2.EquipmentCatalogType
  >
  catalogType(_i5zaboz2.EquipmentCatalogType? value) =>
      _is.ColumnValue(table.catalogType, value);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<
    List<_ibtz7e0l.WeaponCategory>,
    List<_ibtz7e0l.WeaponCategory>
  >
  allowedWeaponCategories(List<_ibtz7e0l.WeaponCategory>? value) =>
      _is.ColumnValue(table.allowedWeaponCategories, value);

  _is.ColumnValue<List<String>, List<String>> allowedItemCategories(
    List<String>? value,
  ) => _is.ColumnValue(table.allowedItemCategories, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class StartingEquipmentEntryDataTable extends _is.Table<int?> {
  StartingEquipmentEntryDataTable({super.tableRelation})
    : super(tableName: 'starting_equipment_entry_data') {
    updateTable = StartingEquipmentEntryDataUpdateTable(this);
    sourceClassId = _is.ColumnInt('sourceClassId', this);
    sourceBackgroundId = _is.ColumnInt('sourceBackgroundId', this);
    parentEntryId = _is.ColumnInt('parentEntryId', this);
    kind = _is.ColumnEnum('kind', this, _is.EnumSerialization.byName);
    orderIndex = _is.ColumnInt('orderIndex', this);
    selectionCount = _is.ColumnInt('selectionCount', this);
    lineKind = _is.ColumnEnum('lineKind', this, _is.EnumSerialization.byName);
    quantity = _is.ColumnInt('quantity', this);
    catalogType = _is.ColumnEnum(
      'catalogType',
      this,
      _is.EnumSerialization.byName,
    );
    referenceKey = _is.ColumnString('referenceKey', this);
    allowedWeaponCategories =
        _is.ColumnSerializable<List<_ibtz7e0l.WeaponCategory>>(
          'allowedWeaponCategories',
          this,
        );
    allowedItemCategories = _is.ColumnSerializable<List<String>>(
      'allowedItemCategories',
      this,
    );
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final StartingEquipmentEntryDataUpdateTable updateTable;

  late final _is.ColumnInt sourceClassId;

  _i7s9vfyh.ClassDataTable? _sourceClass;

  late final _is.ColumnInt sourceBackgroundId;

  _i1utzyju.BackgroundDataTable? _sourceBackground;

  late final _is.ColumnInt parentEntryId;

  late final _is.ColumnEnum<_ibdnjdmg.StartingEquipmentEntryKind> kind;

  late final _is.ColumnInt orderIndex;

  late final _is.ColumnInt selectionCount;

  late final _is.ColumnEnum<_iupdx0br.StartingEquipmentLineKind> lineKind;

  late final _is.ColumnInt quantity;

  late final _is.ColumnEnum<_i5zaboz2.EquipmentCatalogType> catalogType;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnSerializable<List<_ibtz7e0l.WeaponCategory>>
  allowedWeaponCategories;

  late final _is.ColumnSerializable<List<String>> allowedItemCategories;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _i7s9vfyh.ClassDataTable get sourceClass {
    if (_sourceClass != null) return _sourceClass!;
    _sourceClass = _is.createRelationTable(
      relationFieldName: 'sourceClass',
      field: StartingEquipmentEntryData.t.sourceClassId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceClass!;
  }

  _i1utzyju.BackgroundDataTable get sourceBackground {
    if (_sourceBackground != null) return _sourceBackground!;
    _sourceBackground = _is.createRelationTable(
      relationFieldName: 'sourceBackground',
      field: StartingEquipmentEntryData.t.sourceBackgroundId,
      foreignField: _i1utzyju.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1utzyju.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _sourceBackground!;
  }

  @override
  List<_is.Column> get columns => [
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
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'sourceClass') {
      return sourceClass;
    }
    if (relationField == 'sourceBackground') {
      return sourceBackground;
    }
    return null;
  }
}

class StartingEquipmentEntryDataInclude extends _is.IncludeObject {
  StartingEquipmentEntryDataInclude._({
    _i7s9vfyh.ClassDataInclude? sourceClass,
    _i1utzyju.BackgroundDataInclude? sourceBackground,
  }) {
    _sourceClass = sourceClass;
    _sourceBackground = sourceBackground;
  }

  _i7s9vfyh.ClassDataInclude? _sourceClass;

  _i1utzyju.BackgroundDataInclude? _sourceBackground;

  @override
  Map<String, _is.Include?> get includes => {
    'sourceClass': _sourceClass,
    'sourceBackground': _sourceBackground,
  };

  @override
  _is.Table<int?> get table => StartingEquipmentEntryData.t;
}

class StartingEquipmentEntryDataIncludeList extends _is.IncludeList {
  StartingEquipmentEntryDataIncludeList._({
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StartingEquipmentEntryData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StartingEquipmentEntryData.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _is.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? offset,
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _is.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StartingEquipmentEntryData] by its [id] or null if no such row exists.
  Future<StartingEquipmentEntryData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    StartingEquipmentEntryDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StartingEquipmentEntryData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StartingEquipmentEntryData]s in the list and returns the inserted rows.
  ///
  /// The returned [StartingEquipmentEntryData]s will have their `id` fields set.
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
  Future<List<StartingEquipmentEntryData>> insert(
    _is.DatabaseSession session,
    List<StartingEquipmentEntryData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StartingEquipmentEntryData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StartingEquipmentEntryData] and returns the inserted row.
  ///
  /// The returned [StartingEquipmentEntryData] will have its `id` field set.
  Future<StartingEquipmentEntryData> insertRow(
    _is.DatabaseSession session,
    StartingEquipmentEntryData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StartingEquipmentEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StartingEquipmentEntryData]s in the list and returns the resulting rows.
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
  /// The returned [StartingEquipmentEntryData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartingEquipmentEntryData>> upsert(
    _is.DatabaseSession session,
    List<StartingEquipmentEntryData> rows, {
    required _is.ColumnSelections<StartingEquipmentEntryDataTable>
    conflictColumns,
    _is.ColumnSelections<StartingEquipmentEntryDataTable>? updateColumns,
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StartingEquipmentEntryData>(
      rows,
      conflictColumns: conflictColumns(StartingEquipmentEntryData.t),
      updateColumns: updateColumns?.call(StartingEquipmentEntryData.t),
      updateWhere: updateWhere?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StartingEquipmentEntryData] and returns the resulting row.
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
  /// The returned [StartingEquipmentEntryData] will have its `id` field set.
  Future<StartingEquipmentEntryData?> upsertRow(
    _is.DatabaseSession session,
    StartingEquipmentEntryData row, {
    required _is.ColumnSelections<StartingEquipmentEntryDataTable>
    conflictColumns,
    _is.ColumnSelections<StartingEquipmentEntryDataTable>? updateColumns,
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StartingEquipmentEntryData>(
      row,
      conflictColumns: conflictColumns(StartingEquipmentEntryData.t),
      updateColumns: updateColumns?.call(StartingEquipmentEntryData.t),
      updateWhere: updateWhere?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentEntryData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartingEquipmentEntryData>> update(
    _is.DatabaseSession session,
    List<StartingEquipmentEntryData> rows, {
    _is.ColumnSelections<StartingEquipmentEntryDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StartingEquipmentEntryData>(
      rows,
      columns: columns?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StartingEquipmentEntryData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StartingEquipmentEntryData> updateRow(
    _is.DatabaseSession session,
    StartingEquipmentEntryData row, {
    _is.ColumnSelections<StartingEquipmentEntryDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StartingEquipmentEntryData>(
      row,
      columns: columns?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StartingEquipmentEntryData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StartingEquipmentEntryData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StartingEquipmentEntryDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StartingEquipmentEntryData>(
      id,
      columnValues: columnValues(StartingEquipmentEntryData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StartingEquipmentEntryData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartingEquipmentEntryData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StartingEquipmentEntryDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StartingEquipmentEntryData>(
      columnValues: columnValues(StartingEquipmentEntryData.t.updateTable),
      where: where(StartingEquipmentEntryData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StartingEquipmentEntryData]s in the list and returns the deleted rows.
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
  Future<List<StartingEquipmentEntryData>> delete(
    _is.DatabaseSession session,
    List<StartingEquipmentEntryData> rows, {
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StartingEquipmentEntryData>(
      rows,
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StartingEquipmentEntryData].
  Future<StartingEquipmentEntryData> deleteRow(
    _is.DatabaseSession session,
    StartingEquipmentEntryData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StartingEquipmentEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StartingEquipmentEntryData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable> where,
    _is.OrderByBuilder<StartingEquipmentEntryDataTable>? orderBy,
    _is.OrderByListBuilder<StartingEquipmentEntryDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StartingEquipmentEntryData>(
      where: where(StartingEquipmentEntryData.t),
      orderBy: orderBy?.call(StartingEquipmentEntryData.t),
      orderByList: orderByList?.call(StartingEquipmentEntryData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StartingEquipmentEntryData>(
      where: where?.call(StartingEquipmentEntryData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StartingEquipmentEntryData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StartingEquipmentEntryDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StartingEquipmentEntryData>(
      where: where(StartingEquipmentEntryData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class StartingEquipmentEntryDataAttachRowRepository {
  const StartingEquipmentEntryDataAttachRowRepository._();

  /// Creates a relation between the given [StartingEquipmentEntryData] and [ClassData]
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceClassId` to refer to the [ClassData].
  Future<void> sourceClass(
    _is.DatabaseSession session,
    StartingEquipmentEntryData startingEquipmentEntryData,
    _i7s9vfyh.ClassData sourceClass, {
    _is.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }
    if (sourceClass.id == null) {
      throw ArgumentError.notNull('sourceClass.id');
    }

    var $startingEquipmentEntryData = startingEquipmentEntryData.copyWith(
      sourceClassId: sourceClass.id,
    );
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingEquipmentEntryData,
      columns: [StartingEquipmentEntryData.t.sourceClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [StartingEquipmentEntryData] and [BackgroundData]
  /// by setting the [StartingEquipmentEntryData]'s foreign key `sourceBackgroundId` to refer to the [BackgroundData].
  Future<void> sourceBackground(
    _is.DatabaseSession session,
    StartingEquipmentEntryData startingEquipmentEntryData,
    _i1utzyju.BackgroundData sourceBackground, {
    _is.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }
    if (sourceBackground.id == null) {
      throw ArgumentError.notNull('sourceBackground.id');
    }

    var $startingEquipmentEntryData = startingEquipmentEntryData.copyWith(
      sourceBackgroundId: sourceBackground.id,
    );
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
    _is.DatabaseSession session,
    StartingEquipmentEntryData startingEquipmentEntryData, {
    _is.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }

    var $startingEquipmentEntryData = startingEquipmentEntryData.copyWith(
      sourceClassId: null,
    );
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingEquipmentEntryData,
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
    _is.DatabaseSession session,
    StartingEquipmentEntryData startingEquipmentEntryData, {
    _is.Transaction? transaction,
  }) async {
    if (startingEquipmentEntryData.id == null) {
      throw ArgumentError.notNull('startingEquipmentEntryData.id');
    }

    var $startingEquipmentEntryData = startingEquipmentEntryData.copyWith(
      sourceBackgroundId: null,
    );
    await session.db.updateRow<StartingEquipmentEntryData>(
      $startingEquipmentEntryData,
      columns: [StartingEquipmentEntryData.t.sourceBackgroundId],
      transaction: transaction,
    );
  }
}
