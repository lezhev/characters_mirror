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
import '../../../data/general/character/character_class_entry_record.dart'
    as _igs591f3;
import '../../../data/general/character/character_record.dart' as _i50rgqfs;
import '../../../data/general/character/choice_replacement_history_data.dart'
    as _ikw9ov94;

abstract class CharacterChoiceRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterChoiceRecord._({
    this.id,
    this.replacementHistory,
    this.syncId,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.groupKey,
    this.optionKey,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterChoiceRecord({
    int? id,
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterChoiceRecordImpl;

  factory CharacterChoiceRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterChoiceRecord(
      id: jsonSerialization['id'] as int?,
      replacementHistory: jsonSerialization['replacementHistory'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ikw9ov94.ChoiceReplacementHistoryData>>(
                  jsonSerialization['replacementHistory'],
                ),
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i50rgqfs.CharacterRecord>(
              jsonSerialization['character'],
            ),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_igs591f3.CharacterClassEntryRecord>(
                  jsonSerialization['classEntry'],
                ),
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterChoiceRecordTable();

  static const db = CharacterChoiceRecordRepository._();

  @override
  int? id;

  List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory;

  String? syncId;

  int characterId;

  _i50rgqfs.CharacterRecord? character;

  int? classEntryId;

  _igs591f3.CharacterClassEntryRecord? classEntry;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterChoiceRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterChoiceRecord copyWith({
    int? id,
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    int? characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterChoiceRecord',
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory': replacementHistory?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (syncId != null) 'syncId': syncId,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (classEntryId != null) 'classEntryId': classEntryId,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterChoiceRecordInclude include({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
  }) {
    return CharacterChoiceRecordInclude._(
      character: character,
      classEntry: classEntry,
    );
  }

  static CharacterChoiceRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    CharacterChoiceRecordInclude? include,
  }) {
    return CharacterChoiceRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChoiceRecordImpl extends CharacterChoiceRecord {
  _CharacterChoiceRecordImpl({
    int? id,
    List<_ikw9ov94.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         replacementHistory: replacementHistory,
         syncId: syncId,
         characterId: characterId,
         character: character,
         classEntryId: classEntryId,
         classEntry: classEntry,
         groupKey: groupKey,
         optionKey: optionKey,
         selectionIndex: selectionIndex,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterChoiceRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterChoiceRecord copyWith({
    Object? id = _Undefined,
    Object? replacementHistory = _Undefined,
    Object? syncId = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterChoiceRecord(
      id: id is int? ? id : this.id,
      replacementHistory:
          replacementHistory is List<_ikw9ov94.ChoiceReplacementHistoryData>?
          ? replacementHistory
          : this.replacementHistory?.map((e0) => e0.copyWith()).toList(),
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i50rgqfs.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _igs591f3.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterChoiceRecordUpdateTable
    extends _is.UpdateTable<CharacterChoiceRecordTable> {
  CharacterChoiceRecordUpdateTable(super.table);

  _is.ColumnValue<
    List<_ikw9ov94.ChoiceReplacementHistoryData>,
    List<_ikw9ov94.ChoiceReplacementHistoryData>
  >
  replacementHistory(List<_ikw9ov94.ChoiceReplacementHistoryData>? value) =>
      _is.ColumnValue(table.replacementHistory, value);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> classEntryId(int? value) =>
      _is.ColumnValue(table.classEntryId, value);

  _is.ColumnValue<String, String> groupKey(String? value) =>
      _is.ColumnValue(table.groupKey, value);

  _is.ColumnValue<String, String> optionKey(String? value) =>
      _is.ColumnValue(table.optionKey, value);

  _is.ColumnValue<int, int> selectionIndex(int? value) =>
      _is.ColumnValue(table.selectionIndex, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterChoiceRecordTable extends _is.Table<int?> {
  CharacterChoiceRecordTable({super.tableRelation})
    : super(tableName: 'character_choice_data') {
    updateTable = CharacterChoiceRecordUpdateTable(this);
    replacementHistory =
        _is.ColumnSerializable<List<_ikw9ov94.ChoiceReplacementHistoryData>>(
          'replacementHistory',
          this,
        );
    syncId = _is.ColumnString('syncId', this);
    characterId = _is.ColumnInt('characterId', this);
    classEntryId = _is.ColumnInt('classEntryId', this);
    groupKey = _is.ColumnString('groupKey', this);
    optionKey = _is.ColumnString('optionKey', this);
    selectionIndex = _is.ColumnInt('selectionIndex', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterChoiceRecordUpdateTable updateTable;

  late final _is.ColumnSerializable<
    List<_ikw9ov94.ChoiceReplacementHistoryData>
  >
  replacementHistory;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt characterId;

  _i50rgqfs.CharacterRecordTable? _character;

  late final _is.ColumnInt classEntryId;

  _igs591f3.CharacterClassEntryRecordTable? _classEntry;

  late final _is.ColumnString groupKey;

  late final _is.ColumnString optionKey;

  late final _is.ColumnInt selectionIndex;

  late final _is.ColumnDateTime updatedAt;

  _i50rgqfs.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _is.createRelationTable(
      relationFieldName: 'character',
      field: CharacterChoiceRecord.t.characterId,
      foreignField: _i50rgqfs.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i50rgqfs.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _igs591f3.CharacterClassEntryRecordTable get classEntry {
    if (_classEntry != null) return _classEntry!;
    _classEntry = _is.createRelationTable(
      relationFieldName: 'classEntry',
      field: CharacterChoiceRecord.t.classEntryId,
      foreignField: _igs591f3.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _igs591f3.CharacterClassEntryRecordTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _classEntry!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    replacementHistory,
    syncId,
    characterId,
    classEntryId,
    groupKey,
    optionKey,
    selectionIndex,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    if (relationField == 'classEntry') {
      return classEntry;
    }
    return null;
  }
}

class CharacterChoiceRecordInclude extends _is.IncludeObject {
  CharacterChoiceRecordInclude._({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
  }) {
    _character = character;
    _classEntry = classEntry;
  }

  _i50rgqfs.CharacterRecordInclude? _character;

  _igs591f3.CharacterClassEntryRecordInclude? _classEntry;

  @override
  Map<String, _is.Include?> get includes => {
    'character': _character,
    'classEntry': _classEntry,
  };

  @override
  _is.Table<int?> get table => CharacterChoiceRecord.t;
}

class CharacterChoiceRecordIncludeList extends _is.IncludeList {
  CharacterChoiceRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterChoiceRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterChoiceRecord.t;
}

class CharacterChoiceRecordRepository {
  const CharacterChoiceRecordRepository._();

  final attachRow = const CharacterChoiceRecordAttachRowRepository._();

  final detachRow = const CharacterChoiceRecordDetachRowRepository._();

  /// Returns a list of [CharacterChoiceRecord]s matching the given query parameters.
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
  Future<List<CharacterChoiceRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterChoiceRecord] matching the given query parameters.
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
  Future<CharacterChoiceRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterChoiceRecord] by its [id] or null if no such row exists.
  Future<CharacterChoiceRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterChoiceRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterChoiceRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterChoiceRecord]s will have their `id` fields set.
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
  Future<List<CharacterChoiceRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterChoiceRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterChoiceRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterChoiceRecord] and returns the inserted row.
  ///
  /// The returned [CharacterChoiceRecord] will have its `id` field set.
  Future<CharacterChoiceRecord> insertRow(
    _is.DatabaseSession session,
    CharacterChoiceRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterChoiceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterChoiceRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterChoiceRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterChoiceRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterChoiceRecord> rows, {
    required _is.ColumnSelections<CharacterChoiceRecordTable> conflictColumns,
    _is.ColumnSelections<CharacterChoiceRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterChoiceRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterChoiceRecord.t),
      updateColumns: updateColumns?.call(CharacterChoiceRecord.t),
      updateWhere: updateWhere?.call(CharacterChoiceRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterChoiceRecord] and returns the resulting row.
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
  /// The returned [CharacterChoiceRecord] will have its `id` field set.
  Future<CharacterChoiceRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterChoiceRecord row, {
    required _is.ColumnSelections<CharacterChoiceRecordTable> conflictColumns,
    _is.ColumnSelections<CharacterChoiceRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterChoiceRecord>(
      row,
      conflictColumns: conflictColumns(CharacterChoiceRecord.t),
      updateColumns: updateColumns?.call(CharacterChoiceRecord.t),
      updateWhere: updateWhere?.call(CharacterChoiceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterChoiceRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterChoiceRecord>> update(
    _is.DatabaseSession session,
    List<CharacterChoiceRecord> rows, {
    _is.ColumnSelections<CharacterChoiceRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterChoiceRecord>(
      rows,
      columns: columns?.call(CharacterChoiceRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterChoiceRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterChoiceRecord> updateRow(
    _is.DatabaseSession session,
    CharacterChoiceRecord row, {
    _is.ColumnSelections<CharacterChoiceRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterChoiceRecord>(
      row,
      columns: columns?.call(CharacterChoiceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterChoiceRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterChoiceRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CharacterChoiceRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterChoiceRecord>(
      id,
      columnValues: columnValues(CharacterChoiceRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterChoiceRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterChoiceRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CharacterChoiceRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CharacterChoiceRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterChoiceRecord>(
      columnValues: columnValues(CharacterChoiceRecord.t.updateTable),
      where: where(CharacterChoiceRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterChoiceRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterChoiceRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterChoiceRecord> rows, {
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterChoiceRecord>(
      rows,
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterChoiceRecord].
  Future<CharacterChoiceRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterChoiceRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterChoiceRecord>(
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
  Future<List<CharacterChoiceRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterChoiceRecordTable> where,
    _is.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterChoiceRecord>(
      where: where(CharacterChoiceRecord.t),
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterChoiceRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterChoiceRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterChoiceRecord>(
      where: where(CharacterChoiceRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterChoiceRecordAttachRowRepository {
  const CharacterChoiceRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterChoiceRecord] and [CharacterRecord]
  /// by setting the [CharacterChoiceRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _is.DatabaseSession session,
    CharacterChoiceRecord characterChoiceRecord,
    _i50rgqfs.CharacterRecord character, {
    _is.Transaction? transaction,
  }) async {
    if (characterChoiceRecord.id == null) {
      throw ArgumentError.notNull('characterChoiceRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterChoiceRecord = characterChoiceRecord.copyWith(
      characterId: character.id,
    );
    await session.db.updateRow<CharacterChoiceRecord>(
      $characterChoiceRecord,
      columns: [CharacterChoiceRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterChoiceRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterChoiceRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _is.DatabaseSession session,
    CharacterChoiceRecord characterChoiceRecord,
    _igs591f3.CharacterClassEntryRecord classEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterChoiceRecord.id == null) {
      throw ArgumentError.notNull('characterChoiceRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterChoiceRecord = characterChoiceRecord.copyWith(
      classEntryId: classEntry.id,
    );
    await session.db.updateRow<CharacterChoiceRecord>(
      $characterChoiceRecord,
      columns: [CharacterChoiceRecord.t.classEntryId],
      transaction: transaction,
    );
  }
}

class CharacterChoiceRecordDetachRowRepository {
  const CharacterChoiceRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterChoiceRecord] and the [CharacterClassEntryRecord] set in `classEntry`
  /// by setting the [CharacterChoiceRecord]'s foreign key `classEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classEntry(
    _is.DatabaseSession session,
    CharacterChoiceRecord characterChoiceRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterChoiceRecord.id == null) {
      throw ArgumentError.notNull('characterChoiceRecord.id');
    }

    var $characterChoiceRecord = characterChoiceRecord.copyWith(
      classEntryId: null,
    );
    await session.db.updateRow<CharacterChoiceRecord>(
      $characterChoiceRecord,
      columns: [CharacterChoiceRecord.t.classEntryId],
      transaction: transaction,
    );
  }
}
