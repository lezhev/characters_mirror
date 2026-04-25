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
import '../../../data/general/character/character_starting_equipment_selection_record.dart'
    as _i2;
import '../../../enums/equipment_catalog_type.dart' as _i3;

abstract class CharacterStartingEquipmentResolutionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterStartingEquipmentResolutionRecord._({
    this.id,
    this.syncId,
    required this.selectionId,
    this.selection,
    this.lineKey,
    this.catalogType,
    this.referenceKey,
    this.quantity,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentResolutionRecord({
    int? id,
    String? syncId,
    required int selectionId,
    _i2.CharacterStartingEquipmentSelectionRecord? selection,
    String? lineKey,
    _i3.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentResolutionRecordImpl;

  factory CharacterStartingEquipmentResolutionRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterStartingEquipmentResolutionRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      selectionId: jsonSerialization['selectionId'] as int,
      selection: jsonSerialization['selection'] == null
          ? null
          : _i2.CharacterStartingEquipmentSelectionRecord.fromJson(
              (jsonSerialization['selection'] as Map<String, dynamic>)),
      lineKey: jsonSerialization['lineKey'] as String?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i3.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterStartingEquipmentResolutionRecordTable();

  static const db = CharacterStartingEquipmentResolutionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int selectionId;

  _i2.CharacterStartingEquipmentSelectionRecord? selection;

  String? lineKey;

  _i3.EquipmentCatalogType? catalogType;

  String? referenceKey;

  int? quantity;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterStartingEquipmentResolutionRecord copyWith({
    int? id,
    String? syncId,
    int? selectionId,
    _i2.CharacterStartingEquipmentSelectionRecord? selection,
    String? lineKey,
    _i3.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (syncId != null) 'syncId': syncId,
      'selectionId': selectionId,
      if (selection != null) 'selection': selection?.toJson(),
      if (lineKey != null) 'lineKey': lineKey,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterStartingEquipmentResolutionRecordInclude include(
      {_i2.CharacterStartingEquipmentSelectionRecordInclude? selection}) {
    return CharacterStartingEquipmentResolutionRecordInclude._(
        selection: selection);
  }

  static CharacterStartingEquipmentResolutionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderByList,
    CharacterStartingEquipmentResolutionRecordInclude? include,
  }) {
    return CharacterStartingEquipmentResolutionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderDescending: orderDescending,
      orderByList:
          orderByList?.call(CharacterStartingEquipmentResolutionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentResolutionRecordImpl
    extends CharacterStartingEquipmentResolutionRecord {
  _CharacterStartingEquipmentResolutionRecordImpl({
    int? id,
    String? syncId,
    required int selectionId,
    _i2.CharacterStartingEquipmentSelectionRecord? selection,
    String? lineKey,
    _i3.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          syncId: syncId,
          selectionId: selectionId,
          selection: selection,
          lineKey: lineKey,
          catalogType: catalogType,
          referenceKey: referenceKey,
          quantity: quantity,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterStartingEquipmentResolutionRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? selectionId,
    Object? selection = _Undefined,
    Object? lineKey = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? quantity = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentResolutionRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      selectionId: selectionId ?? this.selectionId,
      selection: selection is _i2.CharacterStartingEquipmentSelectionRecord?
          ? selection
          : this.selection?.copyWith(),
      lineKey: lineKey is String? ? lineKey : this.lineKey,
      catalogType: catalogType is _i3.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      quantity: quantity is int? ? quantity : this.quantity,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterStartingEquipmentResolutionRecordTable extends _i1.Table<int?> {
  CharacterStartingEquipmentResolutionRecordTable({super.tableRelation})
      : super(tableName: 'character_starting_equipment_resolution_data') {
    syncId = _i1.ColumnString(
      'syncId',
      this,
    );
    selectionId = _i1.ColumnInt(
      'selectionId',
      this,
    );
    lineKey = _i1.ColumnString(
      'lineKey',
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
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnString syncId;

  late final _i1.ColumnInt selectionId;

  _i2.CharacterStartingEquipmentSelectionRecordTable? _selection;

  late final _i1.ColumnString lineKey;

  late final _i1.ColumnEnum<_i3.EquipmentCatalogType> catalogType;

  late final _i1.ColumnString referenceKey;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDateTime updatedAt;

  _i2.CharacterStartingEquipmentSelectionRecordTable get selection {
    if (_selection != null) return _selection!;
    _selection = _i1.createRelationTable(
      relationFieldName: 'selection',
      field: CharacterStartingEquipmentResolutionRecord.t.selectionId,
      foreignField: _i2.CharacterStartingEquipmentSelectionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterStartingEquipmentSelectionRecordTable(
              tableRelation: foreignTableRelation),
    );
    return _selection!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        syncId,
        selectionId,
        lineKey,
        catalogType,
        referenceKey,
        quantity,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'selection') {
      return selection;
    }
    return null;
  }
}

class CharacterStartingEquipmentResolutionRecordInclude
    extends _i1.IncludeObject {
  CharacterStartingEquipmentResolutionRecordInclude._(
      {_i2.CharacterStartingEquipmentSelectionRecordInclude? selection}) {
    _selection = selection;
  }

  _i2.CharacterStartingEquipmentSelectionRecordInclude? _selection;

  @override
  Map<String, _i1.Include?> get includes => {'selection': _selection};

  @override
  _i1.Table<int?> get table => CharacterStartingEquipmentResolutionRecord.t;
}

class CharacterStartingEquipmentResolutionRecordIncludeList
    extends _i1.IncludeList {
  CharacterStartingEquipmentResolutionRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterStartingEquipmentResolutionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterStartingEquipmentResolutionRecord.t;
}

class CharacterStartingEquipmentResolutionRecordRepository {
  const CharacterStartingEquipmentResolutionRecordRepository._();

  final attachRow =
      const CharacterStartingEquipmentResolutionRecordAttachRowRepository._();

  /// Returns a list of [CharacterStartingEquipmentResolutionRecord]s matching the given query parameters.
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
  Future<List<CharacterStartingEquipmentResolutionRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderByList,
    _i1.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
  }) async {
    return session.db.find<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList:
          orderByList?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterStartingEquipmentResolutionRecord] matching the given query parameters.
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
  Future<CharacterStartingEquipmentResolutionRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        where,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        orderByList,
    _i1.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList:
          orderByList?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterStartingEquipmentResolutionRecord] by its [id] or null if no such row exists.
  Future<CharacterStartingEquipmentResolutionRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
  }) async {
    return session.db.findById<CharacterStartingEquipmentResolutionRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterStartingEquipmentResolutionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterStartingEquipmentResolutionRecord>> insert(
    _i1.Session session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterStartingEquipmentResolutionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterStartingEquipmentResolutionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterStartingEquipmentResolutionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentResolutionRecord> insertRow(
    _i1.Session session,
    CharacterStartingEquipmentResolutionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterStartingEquipmentResolutionRecord>> update(
    _i1.Session session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _i1.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
        columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterStartingEquipmentResolutionRecord>(
      rows,
      columns: columns?.call(CharacterStartingEquipmentResolutionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterStartingEquipmentResolutionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterStartingEquipmentResolutionRecord> updateRow(
    _i1.Session session,
    CharacterStartingEquipmentResolutionRecord row, {
    _i1.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
        columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      columns: columns?.call(CharacterStartingEquipmentResolutionRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterStartingEquipmentResolutionRecord>> delete(
    _i1.Session session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterStartingEquipmentResolutionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterStartingEquipmentResolutionRecord].
  Future<CharacterStartingEquipmentResolutionRecord> deleteRow(
    _i1.Session session,
    CharacterStartingEquipmentResolutionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterStartingEquipmentResolutionRecord>> deleteWhere(
    _i1.Session session, {
    required _i1
        .WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterStartingEquipmentResolutionRecord>(
      where: where(CharacterStartingEquipmentResolutionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
        where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentResolutionRecordAttachRowRepository {
  const CharacterStartingEquipmentResolutionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterStartingEquipmentResolutionRecord] and [CharacterStartingEquipmentSelectionRecord]
  /// by setting the [CharacterStartingEquipmentResolutionRecord]'s foreign key `selectionId` to refer to the [CharacterStartingEquipmentSelectionRecord].
  Future<void> selection(
    _i1.Session session,
    CharacterStartingEquipmentResolutionRecord
        characterStartingEquipmentResolutionRecord,
    _i2.CharacterStartingEquipmentSelectionRecord selection, {
    _i1.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentResolutionRecord.id == null) {
      throw ArgumentError.notNull(
          'characterStartingEquipmentResolutionRecord.id');
    }
    if (selection.id == null) {
      throw ArgumentError.notNull('selection.id');
    }

    var $characterStartingEquipmentResolutionRecord =
        characterStartingEquipmentResolutionRecord.copyWith(
            selectionId: selection.id);
    await session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      $characterStartingEquipmentResolutionRecord,
      columns: [CharacterStartingEquipmentResolutionRecord.t.selectionId],
      transaction: transaction,
    );
  }
}
