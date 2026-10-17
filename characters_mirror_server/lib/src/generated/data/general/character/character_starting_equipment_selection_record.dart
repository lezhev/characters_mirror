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
import '../../../data/general/character/character_record.dart' as _i50rgqfs;
import '../../../data/general/class/starting_equipment_entry_data.dart'
    as _i5s0l1aw;
import '../../../enums/choice_source_type.dart' as _isgp310x;

abstract class CharacterStartingEquipmentSelectionRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterStartingEquipmentSelectionRecord._({
    this.id,
    this.syncId,
    required this.characterId,
    this.character,
    this.sourceType,
    this.sourceId,
    this.sourceEntryId,
    this.sourceEntry,
    this.choiceOptionEntryId,
    this.choiceOptionEntry,
    this.isSelected,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentSelectionRecord({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceEntry,
    int? choiceOptionEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? choiceOptionEntry,
    bool? isSelected,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentSelectionRecordImpl;

  factory CharacterStartingEquipmentSelectionRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterStartingEquipmentSelectionRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i50rgqfs.CharacterRecord>(
              jsonSerialization['character'],
            ),
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _isgp310x.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String),
            ),
      sourceId: jsonSerialization['sourceId'] as int?,
      sourceEntryId: jsonSerialization['sourceEntryId'] as int?,
      sourceEntry: jsonSerialization['sourceEntry'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i5s0l1aw.StartingEquipmentEntryData>(
                  jsonSerialization['sourceEntry'],
                ),
      choiceOptionEntryId: jsonSerialization['choiceOptionEntryId'] as int?,
      choiceOptionEntry: jsonSerialization['choiceOptionEntry'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i5s0l1aw.StartingEquipmentEntryData>(
                  jsonSerialization['choiceOptionEntry'],
                ),
      isSelected: jsonSerialization['isSelected'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSelected']),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterStartingEquipmentSelectionRecordTable();

  static const db = CharacterStartingEquipmentSelectionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i50rgqfs.CharacterRecord? character;

  _isgp310x.ChoiceSourceType? sourceType;

  int? sourceId;

  int? sourceEntryId;

  _i5s0l1aw.StartingEquipmentEntryData? sourceEntry;

  int? choiceOptionEntryId;

  _i5s0l1aw.StartingEquipmentEntryData? choiceOptionEntry;

  bool? isSelected;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterStartingEquipmentSelectionRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i50rgqfs.CharacterRecord? character,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceEntry,
    int? choiceOptionEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? choiceOptionEntry,
    bool? isSelected,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterStartingEquipmentSelectionRecord',
      if (id != null) 'id': id,
      if (syncId != null) 'syncId': syncId,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (sourceEntryId != null) 'sourceEntryId': sourceEntryId,
      if (sourceEntry != null) 'sourceEntry': sourceEntry?.toJson(),
      if (choiceOptionEntryId != null)
        'choiceOptionEntryId': choiceOptionEntryId,
      if (choiceOptionEntry != null)
        'choiceOptionEntry': choiceOptionEntry?.toJson(),
      if (isSelected != null) 'isSelected': isSelected,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterStartingEquipmentSelectionRecordInclude include({
    _i50rgqfs.CharacterRecordInclude? character,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? sourceEntry,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? choiceOptionEntry,
  }) {
    return CharacterStartingEquipmentSelectionRecordInclude._(
      character: character,
      sourceEntry: sourceEntry,
      choiceOptionEntry: choiceOptionEntry,
    );
  }

  static CharacterStartingEquipmentSelectionRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    CharacterStartingEquipmentSelectionRecordInclude? include,
  }) {
    return CharacterStartingEquipmentSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
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

class _CharacterStartingEquipmentSelectionRecordImpl
    extends CharacterStartingEquipmentSelectionRecord {
  _CharacterStartingEquipmentSelectionRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    _isgp310x.ChoiceSourceType? sourceType,
    int? sourceId,
    int? sourceEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? sourceEntry,
    int? choiceOptionEntryId,
    _i5s0l1aw.StartingEquipmentEntryData? choiceOptionEntry,
    bool? isSelected,
    int? selectionIndex,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         syncId: syncId,
         characterId: characterId,
         character: character,
         sourceType: sourceType,
         sourceId: sourceId,
         sourceEntryId: sourceEntryId,
         sourceEntry: sourceEntry,
         choiceOptionEntryId: choiceOptionEntryId,
         choiceOptionEntry: choiceOptionEntry,
         isSelected: isSelected,
         selectionIndex: selectionIndex,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterStartingEquipmentSelectionRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? sourceEntryId = _Undefined,
    Object? sourceEntry = _Undefined,
    Object? choiceOptionEntryId = _Undefined,
    Object? choiceOptionEntry = _Undefined,
    Object? isSelected = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentSelectionRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i50rgqfs.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      sourceType: sourceType is _isgp310x.ChoiceSourceType?
          ? sourceType
          : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      sourceEntryId: sourceEntryId is int? ? sourceEntryId : this.sourceEntryId,
      sourceEntry: sourceEntry is _i5s0l1aw.StartingEquipmentEntryData?
          ? sourceEntry
          : this.sourceEntry?.copyWith(),
      choiceOptionEntryId: choiceOptionEntryId is int?
          ? choiceOptionEntryId
          : this.choiceOptionEntryId,
      choiceOptionEntry:
          choiceOptionEntry is _i5s0l1aw.StartingEquipmentEntryData?
          ? choiceOptionEntry
          : this.choiceOptionEntry?.copyWith(),
      isSelected: isSelected is bool? ? isSelected : this.isSelected,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterStartingEquipmentSelectionRecordUpdateTable
    extends _is.UpdateTable<CharacterStartingEquipmentSelectionRecordTable> {
  CharacterStartingEquipmentSelectionRecordUpdateTable(super.table);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<_isgp310x.ChoiceSourceType, _isgp310x.ChoiceSourceType>
  sourceType(_isgp310x.ChoiceSourceType? value) =>
      _is.ColumnValue(table.sourceType, value);

  _is.ColumnValue<int, int> sourceId(int? value) =>
      _is.ColumnValue(table.sourceId, value);

  _is.ColumnValue<int, int> sourceEntryId(int? value) =>
      _is.ColumnValue(table.sourceEntryId, value);

  _is.ColumnValue<int, int> choiceOptionEntryId(int? value) =>
      _is.ColumnValue(table.choiceOptionEntryId, value);

  _is.ColumnValue<bool, bool> isSelected(bool? value) =>
      _is.ColumnValue(table.isSelected, value);

  _is.ColumnValue<int, int> selectionIndex(int? value) =>
      _is.ColumnValue(table.selectionIndex, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterStartingEquipmentSelectionRecordTable extends _is.Table<int?> {
  CharacterStartingEquipmentSelectionRecordTable({super.tableRelation})
    : super(tableName: 'character_starting_equipment_selection_data') {
    updateTable = CharacterStartingEquipmentSelectionRecordUpdateTable(this);
    syncId = _is.ColumnString('syncId', this);
    characterId = _is.ColumnInt('characterId', this);
    sourceType = _is.ColumnEnum(
      'sourceType',
      this,
      _is.EnumSerialization.byName,
    );
    sourceId = _is.ColumnInt('sourceId', this);
    sourceEntryId = _is.ColumnInt('sourceEntryId', this);
    choiceOptionEntryId = _is.ColumnInt('choiceOptionEntryId', this);
    isSelected = _is.ColumnBool('isSelected', this);
    selectionIndex = _is.ColumnInt('selectionIndex', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterStartingEquipmentSelectionRecordUpdateTable updateTable;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt characterId;

  _i50rgqfs.CharacterRecordTable? _character;

  late final _is.ColumnEnum<_isgp310x.ChoiceSourceType> sourceType;

  late final _is.ColumnInt sourceId;

  late final _is.ColumnInt sourceEntryId;

  _i5s0l1aw.StartingEquipmentEntryDataTable? _sourceEntry;

  late final _is.ColumnInt choiceOptionEntryId;

  _i5s0l1aw.StartingEquipmentEntryDataTable? _choiceOptionEntry;

  late final _is.ColumnBool isSelected;

  late final _is.ColumnInt selectionIndex;

  late final _is.ColumnDateTime updatedAt;

  _i50rgqfs.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _is.createRelationTable(
      relationFieldName: 'character',
      field: CharacterStartingEquipmentSelectionRecord.t.characterId,
      foreignField: _i50rgqfs.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i50rgqfs.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i5s0l1aw.StartingEquipmentEntryDataTable get sourceEntry {
    if (_sourceEntry != null) return _sourceEntry!;
    _sourceEntry = _is.createRelationTable(
      relationFieldName: 'sourceEntry',
      field: CharacterStartingEquipmentSelectionRecord.t.sourceEntryId,
      foreignField: _i5s0l1aw.StartingEquipmentEntryData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5s0l1aw.StartingEquipmentEntryDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _sourceEntry!;
  }

  _i5s0l1aw.StartingEquipmentEntryDataTable get choiceOptionEntry {
    if (_choiceOptionEntry != null) return _choiceOptionEntry!;
    _choiceOptionEntry = _is.createRelationTable(
      relationFieldName: 'choiceOptionEntry',
      field: CharacterStartingEquipmentSelectionRecord.t.choiceOptionEntryId,
      foreignField: _i5s0l1aw.StartingEquipmentEntryData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5s0l1aw.StartingEquipmentEntryDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _choiceOptionEntry!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    syncId,
    characterId,
    sourceType,
    sourceId,
    sourceEntryId,
    choiceOptionEntryId,
    isSelected,
    selectionIndex,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    if (relationField == 'sourceEntry') {
      return sourceEntry;
    }
    if (relationField == 'choiceOptionEntry') {
      return choiceOptionEntry;
    }
    return null;
  }
}

class CharacterStartingEquipmentSelectionRecordInclude
    extends _is.IncludeObject {
  CharacterStartingEquipmentSelectionRecordInclude._({
    _i50rgqfs.CharacterRecordInclude? character,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? sourceEntry,
    _i5s0l1aw.StartingEquipmentEntryDataInclude? choiceOptionEntry,
  }) {
    _character = character;
    _sourceEntry = sourceEntry;
    _choiceOptionEntry = choiceOptionEntry;
  }

  _i50rgqfs.CharacterRecordInclude? _character;

  _i5s0l1aw.StartingEquipmentEntryDataInclude? _sourceEntry;

  _i5s0l1aw.StartingEquipmentEntryDataInclude? _choiceOptionEntry;

  @override
  Map<String, _is.Include?> get includes => {
    'character': _character,
    'sourceEntry': _sourceEntry,
    'choiceOptionEntry': _choiceOptionEntry,
  };

  @override
  _is.Table<int?> get table => CharacterStartingEquipmentSelectionRecord.t;
}

class CharacterStartingEquipmentSelectionRecordIncludeList
    extends _is.IncludeList {
  CharacterStartingEquipmentSelectionRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterStartingEquipmentSelectionRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterStartingEquipmentSelectionRecord.t;
}

class CharacterStartingEquipmentSelectionRecordRepository {
  const CharacterStartingEquipmentSelectionRecordRepository._();

  final attachRow =
      const CharacterStartingEquipmentSelectionRecordAttachRowRepository._();

  final detachRow =
      const CharacterStartingEquipmentSelectionRecordDetachRowRepository._();

  /// Returns a list of [CharacterStartingEquipmentSelectionRecord]s matching the given query parameters.
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
  Future<List<CharacterStartingEquipmentSelectionRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterStartingEquipmentSelectionRecord] matching the given query parameters.
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
  Future<CharacterStartingEquipmentSelectionRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    where,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterStartingEquipmentSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterStartingEquipmentSelectionRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterStartingEquipmentSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterStartingEquipmentSelectionRecord]s will have their `id` fields set.
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
  Future<List<CharacterStartingEquipmentSelectionRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterStartingEquipmentSelectionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterStartingEquipmentSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterStartingEquipmentSelectionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentSelectionRecord> insertRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterStartingEquipmentSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentSelectionRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    required _is.ColumnSelections<
      CharacterStartingEquipmentSelectionRecordTable
    >
    conflictColumns,
    _is.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
    updateColumns,
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterStartingEquipmentSelectionRecord>(
      rows,
      conflictColumns: conflictColumns(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      updateColumns: updateColumns?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      updateWhere: updateWhere?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterStartingEquipmentSelectionRecord] and returns the resulting row.
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
  /// The returned [CharacterStartingEquipmentSelectionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentSelectionRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord row, {
    required _is.ColumnSelections<
      CharacterStartingEquipmentSelectionRecordTable
    >
    conflictColumns,
    _is.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
    updateColumns,
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      conflictColumns: conflictColumns(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      updateColumns: updateColumns?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      updateWhere: updateWhere?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentSelectionRecord>> update(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _is.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
    columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterStartingEquipmentSelectionRecord>(
      rows,
      columns: columns?.call(CharacterStartingEquipmentSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterStartingEquipmentSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterStartingEquipmentSelectionRecord> updateRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord row, {
    _is.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
    columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      columns: columns?.call(CharacterStartingEquipmentSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterStartingEquipmentSelectionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterStartingEquipmentSelectionRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      CharacterStartingEquipmentSelectionRecordUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterStartingEquipmentSelectionRecord>(
      id,
      columnValues: columnValues(
        CharacterStartingEquipmentSelectionRecord.t.updateTable,
      ),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentSelectionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterStartingEquipmentSelectionRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      CharacterStartingEquipmentSelectionRecordUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentSelectionRecordTable
    >
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterStartingEquipmentSelectionRecord>(
      columnValues: columnValues(
        CharacterStartingEquipmentSelectionRecord.t.updateTable,
      ),
      where: where(CharacterStartingEquipmentSelectionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterStartingEquipmentSelectionRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterStartingEquipmentSelectionRecord>(
      rows,
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterStartingEquipmentSelectionRecord].
  Future<CharacterStartingEquipmentSelectionRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterStartingEquipmentSelectionRecord>(
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
  Future<List<CharacterStartingEquipmentSelectionRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentSelectionRecordTable
    >
    where,
    _is.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterStartingEquipmentSelectionRecord>(
      where: where(CharacterStartingEquipmentSelectionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList: orderByList?.call(
        CharacterStartingEquipmentSelectionRecord.t,
      ),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
    where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterStartingEquipmentSelectionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<
      CharacterStartingEquipmentSelectionRecordTable
    >
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterStartingEquipmentSelectionRecord>(
      where: where(CharacterStartingEquipmentSelectionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentSelectionRecordAttachRowRepository {
  const CharacterStartingEquipmentSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterStartingEquipmentSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord
    characterStartingEquipmentSelectionRecord,
    _i50rgqfs.CharacterRecord character, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentSelectionRecord.id',
      );
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(
          characterId: character.id,
        );
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [CharacterStartingEquipmentSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterStartingEquipmentSelectionRecord] and [StartingEquipmentEntryData]
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `sourceEntryId` to refer to the [StartingEquipmentEntryData].
  Future<void> sourceEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord
    characterStartingEquipmentSelectionRecord,
    _i5s0l1aw.StartingEquipmentEntryData sourceEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentSelectionRecord.id',
      );
    }
    if (sourceEntry.id == null) {
      throw ArgumentError.notNull('sourceEntry.id');
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(
          sourceEntryId: sourceEntry.id,
        );
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [CharacterStartingEquipmentSelectionRecord.t.sourceEntryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterStartingEquipmentSelectionRecord] and [StartingEquipmentEntryData]
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `choiceOptionEntryId` to refer to the [StartingEquipmentEntryData].
  Future<void> choiceOptionEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord
    characterStartingEquipmentSelectionRecord,
    _i5s0l1aw.StartingEquipmentEntryData choiceOptionEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentSelectionRecord.id',
      );
    }
    if (choiceOptionEntry.id == null) {
      throw ArgumentError.notNull('choiceOptionEntry.id');
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(
          choiceOptionEntryId: choiceOptionEntry.id,
        );
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [
        CharacterStartingEquipmentSelectionRecord.t.choiceOptionEntryId,
      ],
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentSelectionRecordDetachRowRepository {
  const CharacterStartingEquipmentSelectionRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterStartingEquipmentSelectionRecord] and the [StartingEquipmentEntryData] set in `sourceEntry`
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `sourceEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sourceEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord
    characterStartingEquipmentSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentSelectionRecord.id',
      );
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(sourceEntryId: null);
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [CharacterStartingEquipmentSelectionRecord.t.sourceEntryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterStartingEquipmentSelectionRecord] and the [StartingEquipmentEntryData] set in `choiceOptionEntry`
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `choiceOptionEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> choiceOptionEntry(
    _is.DatabaseSession session,
    CharacterStartingEquipmentSelectionRecord
    characterStartingEquipmentSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
        'characterStartingEquipmentSelectionRecord.id',
      );
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(
          choiceOptionEntryId: null,
        );
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [
        CharacterStartingEquipmentSelectionRecord.t.choiceOptionEntryId,
      ],
      transaction: transaction,
    );
  }
}
