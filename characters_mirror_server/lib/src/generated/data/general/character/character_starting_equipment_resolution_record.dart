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
import '../../../data/general/character/character_starting_equipment_selection_record.dart'
    as _imblf6m1;
import '../../../data/general/class/starting_equipment_entry_data.dart'
    as _i5s0l1aw;
import '../../../enums/equipment_catalog_type.dart' as _i5zaboz2;

abstract class CharacterStartingEquipmentResolutionRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterStartingEquipmentResolutionRecord._({
    this.id,
    this.syncId,
    required this.selectionId,
    this.selection,
    this.sourceLineEntryId,
    this.sourceLineEntry,
    this.catalogType,
    this.referenceKey,
    this.quantity,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentResolutionRecord({
    int? id,
    String? syncId,
    required int selectionId,
    _imblf6m1.CharacterStartingEquipmentSelectionRecord? selection,
    int? sourceLineEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceLineEntry,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentResolutionRecordImpl;

  factory CharacterStartingEquipmentResolutionRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterStartingEquipmentResolutionRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      selectionId: jsonSerialization['selectionId'] as int,
      selection: jsonSerialization['selection'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              _imblf6m1.CharacterStartingEquipmentSelectionRecord
            >(jsonSerialization['selection']),
      sourceLineEntryId: jsonSerialization['sourceLineEntryId'] as int?,
      sourceLineEntry: jsonSerialization['sourceLineEntry'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i5s0l1aw.StartingEquipmentEntryData>(
                  jsonSerialization['sourceLineEntry'],
                ),
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5zaboz2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String),
            ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterStartingEquipmentResolutionRecordTable();

  static const db = CharacterStartingEquipmentResolutionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int selectionId;

  _imblf6m1.CharacterStartingEquipmentSelectionRecord? selection;

  int? sourceLineEntryId;

  _i5s0l1aw.StartingEquipmentEntryData? sourceLineEntry;

  _i5zaboz2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  int? quantity;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterStartingEquipmentResolutionRecord copyWith({
    int? id,
    String? syncId,
    int? selectionId,
    _imblf6m1.CharacterStartingEquipmentSelectionRecord? selection,
    int? sourceLineEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceLineEntry,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterStartingEquipmentResolutionRecord',
      if (id != null) 'id': id,
      if (syncId != null) 'syncId': syncId,
      'selectionId': selectionId,
      if (selection != null) 'selection': selection?.toJson(),
      if (sourceLineEntryId != null) 'sourceLineEntryId': sourceLineEntryId,
      if (sourceLineEntry != null) 'sourceLineEntry': sourceLineEntry?.toJson(),
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterStartingEquipmentResolutionRecordInclude include({
    _imblf6m1.CharacterStartingEquipmentSelectionRecordInclude? selection,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? sourceLineEntry,
  }) {
    return CharacterStartingEquipmentResolutionRecordInclude._(
      selection: selection,
      sourceLineEntry: sourceLineEntry,
    );
  }

  static CharacterStartingEquipmentResolutionRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    CharacterStartingEquipmentResolutionRecordInclude? include,
  }) {
    return CharacterStartingEquipmentResolutionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentResolutionRecordImpl
    extends CharacterStartingEquipmentResolutionRecord {
  _CharacterStartingEquipmentResolutionRecordImpl({
    int? id,
    String? syncId,
    required int selectionId,
    _imblf6m1.CharacterStartingEquipmentSelectionRecord? selection,
    int? sourceLineEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceLineEntry,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         syncId: syncId,
         selectionId: selectionId,
         selection: selection,
         sourceLineEntryId: sourceLineEntryId,
         sourceLineEntry: sourceLineEntry,
         catalogType: catalogType,
         referenceKey: referenceKey,
         quantity: quantity,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterStartingEquipmentResolutionRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? selectionId,
    Object? selection = _Undefined,
    Object? sourceLineEntryId = _Undefined,
    Object? sourceLineEntry = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? quantity = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentResolutionRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      selectionId: selectionId ?? this.selectionId,
      selection:
          selection is _imblf6m1.CharacterStartingEquipmentSelectionRecord?
          ? selection
          : this.selection?.copyWith(),
      sourceLineEntryId: sourceLineEntryId is int?
          ? sourceLineEntryId
          : this.sourceLineEntryId,
      sourceLineEntry: sourceLineEntry is _i5s0l1aw.StartingEquipmentEntryData?
          ? sourceLineEntry
          : this.sourceLineEntry?.copyWith(),
      catalogType: catalogType is _i5zaboz2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      quantity: quantity is int? ? quantity : this.quantity,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterStartingEquipmentResolutionRecordUpdateTable
    extends _is.UpdateTable<CharacterStartingEquipmentResolutionRecordTable> {
  CharacterStartingEquipmentResolutionRecordUpdateTable(super.table);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> selectionId(int value) =>
      _is.ColumnValue(table.selectionId, value);

  _is.ColumnValue<int, int> sourceLineEntryId(int? value) =>
      _is.ColumnValue(table.sourceLineEntryId, value);

  _is.ColumnValue<
    _i5zaboz2.EquipmentCatalogType,
    _i5zaboz2.EquipmentCatalogType
  >
  catalogType(_i5zaboz2.EquipmentCatalogType? value) =>
      _is.ColumnValue(table.catalogType, value);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<int, int> quantity(int? value) =>
      _is.ColumnValue(table.quantity, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterStartingEquipmentResolutionRecordTable extends _is.Table<int?> {
  CharacterStartingEquipmentResolutionRecordTable({super.tableRelation})
    : super(tableName: 'character_starting_equipment_resolution_data') {
    updateTable = CharacterStartingEquipmentResolutionRecordUpdateTable(this);
    syncId = _is.ColumnString('syncId', this);
    selectionId = _is.ColumnInt('selectionId', this);
    sourceLineEntryId = _is.ColumnInt('sourceLineEntryId', this);
    catalogType = _is.ColumnEnum(
      'catalogType',
      this,
      _is.EnumSerialization.byName,
    );
    referenceKey = _is.ColumnString('referenceKey', this);
    quantity = _is.ColumnInt('quantity', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterStartingEquipmentResolutionRecordUpdateTable updateTable;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt selectionId;

  _imblf6m1.CharacterStartingEquipmentSelectionRecordTable? _selection;

  late final _is.ColumnInt sourceLineEntryId;

  _i5s0l1aw.StartingEquipmentEntryDataTable? _sourceLineEntry;

  late final _is.ColumnEnum<_i5zaboz2.EquipmentCatalogType> catalogType;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnInt quantity;

  late final _is.ColumnDateTime updatedAt;

  _imblf6m1.CharacterStartingEquipmentSelectionRecordTable get selection {
    if (_selection != null) return _selection!;
    _selection = _is.createRelationTable(
      relationFieldName: 'selection',
      field: CharacterStartingEquipmentResolutionRecord.t.selectionId,
      foreignField: _imblf6m1.CharacterStartingEquipmentSelectionRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _imblf6m1.CharacterStartingEquipmentSelectionRecordTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _selection!;
  }

  _i5s0l1aw.StartingEquipmentEntryDataTable get sourceLineEntry {
    if (_sourceLineEntry != null) return _sourceLineEntry!;
    _sourceLineEntry = _is.createRelationTable(
      relationFieldName: 'sourceLineEntry',
      field: CharacterStartingEquipmentResolutionRecord.t.sourceLineEntryId,
      foreignField: _i5s0l1aw.StartingEquipmentEntryData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5s0l1aw.StartingEquipmentEntryDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _sourceLineEntry!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    syncId,
    selectionId,
    sourceLineEntryId,
    catalogType,
    referenceKey,
    quantity,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'selection') {
      return selection;
    }
    if (relationField == 'sourceLineEntry') {
      return sourceLineEntry;
    }
    return null;
  }
}

class CharacterStartingEquipmentResolutionRecordInclude
    extends _is.IncludeObject {
  CharacterStartingEquipmentResolutionRecordInclude._({
    _imblf6m1.CharacterStartingEquipmentSelectionRecordInclude? selection,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? sourceLineEntry,
  }) {
    _selection = selection;
    _sourceLineEntry = sourceLineEntry;
  }

  _imblf6m1.CharacterStartingEquipmentSelectionRecordInclude? _selection;

  _i5s0l1aw.StartingEquipmentEntryDataInclude? _sourceLineEntry;

  @override
  Map<String, _is.Include?> get includes => {
    'selection': _selection,
    'sourceLineEntry': _sourceLineEntry,
  };

  @override
  _is.Table<int?> get table => CharacterStartingEquipmentResolutionRecord.t;
}

class CharacterStartingEquipmentResolutionRecordIncludeList
    extends _is.IncludeList {
  CharacterStartingEquipmentResolutionRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterStartingEquipmentResolutionRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterStartingEquipmentResolutionRecord.t;
}

class CharacterStartingEquipmentResolutionRecordRepository {
  const CharacterStartingEquipmentResolutionRecordRepository._();

  final attachRow =
      const CharacterStartingEquipmentResolutionRecordAttachRowRepository._();

  final detachRow =
      const CharacterStartingEquipmentResolutionRecordDetachRowRepository._();

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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    where,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterStartingEquipmentResolutionRecord] by its [id] or null if no such row exists.
  Future<CharacterStartingEquipmentResolutionRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterStartingEquipmentResolutionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterStartingEquipmentResolutionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterStartingEquipmentResolutionRecord]s will have their `id` fields set.
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
  Future<List<CharacterStartingEquipmentResolutionRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterStartingEquipmentResolutionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterStartingEquipmentResolutionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterStartingEquipmentResolutionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentResolutionRecord> insertRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterStartingEquipmentResolutionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentResolutionRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    required _is.ColumnSelections<
      CharacterStartingEquipmentResolutionRecordTable
    >
    conflictColumns,
    _is.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
    updateColumns,
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterStartingEquipmentResolutionRecord>(
      rows,
      conflictColumns: conflictColumns(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      updateColumns: updateColumns?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      updateWhere: updateWhere?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterStartingEquipmentResolutionRecord] and returns the resulting row.
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
  /// The returned [CharacterStartingEquipmentResolutionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentResolutionRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord row, {
    required _is.ColumnSelections<
      CharacterStartingEquipmentResolutionRecordTable
    >
    conflictColumns,
    _is.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
    updateColumns,
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      conflictColumns: conflictColumns(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      updateColumns: updateColumns?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      updateWhere: updateWhere?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentResolutionRecord>> update(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _is.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
    columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterStartingEquipmentResolutionRecord>(
      rows,
      columns: columns?.call(CharacterStartingEquipmentResolutionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterStartingEquipmentResolutionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterStartingEquipmentResolutionRecord> updateRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord row, {
    _is.ColumnSelections<CharacterStartingEquipmentResolutionRecordTable>?
    columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      row,
      columns: columns?.call(CharacterStartingEquipmentResolutionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterStartingEquipmentResolutionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterStartingEquipmentResolutionRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      CharacterStartingEquipmentResolutionRecordUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterStartingEquipmentResolutionRecord>(
      id,
      columnValues: columnValues(
        CharacterStartingEquipmentResolutionRecord.t.updateTable,
      ),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentResolutionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentResolutionRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      CharacterStartingEquipmentResolutionRecordUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentResolutionRecordTable
    >
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterStartingEquipmentResolutionRecord>(
      columnValues: columnValues(
        CharacterStartingEquipmentResolutionRecord.t.updateTable,
      ),
      where: where(CharacterStartingEquipmentResolutionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterStartingEquipmentResolutionRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterStartingEquipmentResolutionRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentResolutionRecord> rows, {
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterStartingEquipmentResolutionRecord>(
      rows,
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterStartingEquipmentResolutionRecord].
  Future<CharacterStartingEquipmentResolutionRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterStartingEquipmentResolutionRecord>(
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
  Future<List<CharacterStartingEquipmentResolutionRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentResolutionRecordTable
    >
    where,
    _is.OrderByBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterStartingEquipmentResolutionRecord>(
      where: where(CharacterStartingEquipmentResolutionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentResolutionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentResolutionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentResolutionRecordTable>?
    where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterStartingEquipmentResolutionRecord>(
      where: where?.call(CharacterStartingEquipmentResolutionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterStartingEquipmentResolutionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentResolutionRecordTable
    >
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterStartingEquipmentResolutionRecord>(
      where: where(CharacterStartingEquipmentResolutionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentResolutionRecordAttachRowRepository {
  const CharacterStartingEquipmentResolutionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterStartingEquipmentResolutionRecord] and [CharacterStartingEquipmentSelectionRecord]
  /// by setting the [CharacterStartingEquipmentResolutionRecord]'s foreign key `selectionId` to refer to the [CharacterStartingEquipmentSelectionRecord].
  Future<void> selection(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord
    characterStartingEquipmentResolutionRecord,
    _imblf6m1.CharacterStartingEquipmentSelectionRecord selection, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentResolutionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentResolutionRecord.id',
      );
    }
    if (selection.id == null) {
      throw ArgumentError.notNull('selection.id');
    }

    var $characterStartingEquipmentResolutionRecord =
        characterStartingEquipmentResolutionRecord.copyWith(
          selectionId: selection.id,
        );
    await session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      $characterStartingEquipmentResolutionRecord,
      columns: [CharacterStartingEquipmentResolutionRecord.t.selectionId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterStartingEquipmentResolutionRecord] and [StartingEquipmentEntryData]
  /// by setting the [CharacterStartingEquipmentResolutionRecord]'s foreign key `sourceLineEntryId` to refer to the [StartingEquipmentEntryData].
  Future<void> sourceLineEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord
    characterStartingEquipmentResolutionRecord,
    _i5s0l1aw.StartingEquipmentEntryData sourceLineEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentResolutionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentResolutionRecord.id',
      );
    }
    if (sourceLineEntry.id == null) {
      throw ArgumentError.notNull('sourceLineEntry.id');
    }

    var $characterStartingEquipmentResolutionRecord =
        characterStartingEquipmentResolutionRecord.copyWith(
          sourceLineEntryId: sourceLineEntry.id,
        );
    await session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      $characterStartingEquipmentResolutionRecord,
      columns: [CharacterStartingEquipmentResolutionRecord.t.sourceLineEntryId],
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentResolutionRecordDetachRowRepository {
  const CharacterStartingEquipmentResolutionRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterStartingEquipmentResolutionRecord] and the [StartingEquipmentEntryData] set in `sourceLineEntry`
  /// by setting the [CharacterStartingEquipmentResolutionRecord]'s foreign key `sourceLineEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceLineEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentResolutionRecord
    characterStartingEquipmentResolutionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentResolutionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentResolutionRecord.id',
      );
    }

    var $characterStartingEquipmentResolutionRecord =
        characterStartingEquipmentResolutionRecord.copyWith(
          sourceLineEntryId: null,
        );
    await session.db.updateRow<CharacterStartingEquipmentResolutionRecord>(
      $characterStartingEquipmentResolutionRecord,
      columns: [CharacterStartingEquipmentResolutionRecord.t.sourceLineEntryId],
      transaction: transaction,
    );
  }
}
