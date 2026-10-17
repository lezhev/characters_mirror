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
import '../../../data/general/character/character_class_entry_record.dart'
    as _igs591f3;
import '../../../data/general/character/character_record.dart' as _i50rgqfs;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../enums/character_skill_selection_kind.dart' as _if0i9g7r;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class CharacterSkillSelectionRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterSkillSelectionRecord._({
    this.id,
    this.syncId,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.classDataId,
    this.classData,
    this.backgroundDataId,
    this.backgroundData,
    this.skill,
    this.kind,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterSkillSelectionRecord({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? backgroundDataId,
    _i1utzyju.BackgroundData? backgroundData,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSkillSelectionRecordImpl;

  factory CharacterSkillSelectionRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSkillSelectionRecord(
      id: jsonSerialization['id'] as int?,
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
      classDataId: jsonSerialization['classDataId'] as int?,
      classData: jsonSerialization['classData'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['classData'],
            ),
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      backgroundData: jsonSerialization['backgroundData'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i1utzyju.BackgroundData>(
              jsonSerialization['backgroundData'],
            ),
      skill: jsonSerialization['skill'] == null
          ? null
          : _iqrhamom.Skill.fromJson((jsonSerialization['skill'] as String)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _if0i9g7r.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterSkillSelectionRecordTable();

  static const db = CharacterSkillSelectionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i50rgqfs.CharacterRecord? character;

  int? classEntryId;

  _igs591f3.CharacterClassEntryRecord? classEntry;

  int? classDataId;

  _i7s9vfyh.ClassData? classData;

  int? backgroundDataId;

  _i1utzyju.BackgroundData? backgroundData;

  _iqrhamom.Skill? skill;

  _if0i9g7r.CharacterSkillSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSkillSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSkillSelectionRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? backgroundDataId,
    _i1utzyju.BackgroundData? backgroundData,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSkillSelectionRecord',
      if (id != null) 'id': id,
      if (syncId != null) 'syncId': syncId,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (classEntryId != null) 'classEntryId': classEntryId,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (classDataId != null) 'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      if (backgroundDataId != null) 'backgroundDataId': backgroundDataId,
      if (backgroundData != null) 'backgroundData': backgroundData?.toJson(),
      if (skill != null) 'skill': skill?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterSkillSelectionRecordInclude include({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
    _i7s9vfyh.ClassDataInclude? classData,
    _i1utzyju.BackgroundDataInclude? backgroundData,
  }) {
    return CharacterSkillSelectionRecordInclude._(
      character: character,
      classEntry: classEntry,
      classData: classData,
      backgroundData: backgroundData,
    );
  }

  static CharacterSkillSelectionRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    CharacterSkillSelectionRecordInclude? include,
  }) {
    return CharacterSkillSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSkillSelectionRecordImpl extends CharacterSkillSelectionRecord {
  _CharacterSkillSelectionRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? backgroundDataId,
    _i1utzyju.BackgroundData? backgroundData,
    _iqrhamom.Skill? skill,
    _if0i9g7r.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         syncId: syncId,
         characterId: characterId,
         character: character,
         classEntryId: classEntryId,
         classEntry: classEntry,
         classDataId: classDataId,
         classData: classData,
         backgroundDataId: backgroundDataId,
         backgroundData: backgroundData,
         skill: skill,
         kind: kind,
         selectionIndex: selectionIndex,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterSkillSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterSkillSelectionRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? classDataId = _Undefined,
    Object? classData = _Undefined,
    Object? backgroundDataId = _Undefined,
    Object? backgroundData = _Undefined,
    Object? skill = _Undefined,
    Object? kind = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSkillSelectionRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i50rgqfs.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _igs591f3.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      classData: classData is _i7s9vfyh.ClassData?
          ? classData
          : this.classData?.copyWith(),
      backgroundDataId: backgroundDataId is int?
          ? backgroundDataId
          : this.backgroundDataId,
      backgroundData: backgroundData is _i1utzyju.BackgroundData?
          ? backgroundData
          : this.backgroundData?.copyWith(),
      skill: skill is _iqrhamom.Skill? ? skill : this.skill,
      kind: kind is _if0i9g7r.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterSkillSelectionRecordUpdateTable
    extends _is.UpdateTable<CharacterSkillSelectionRecordTable> {
  CharacterSkillSelectionRecordUpdateTable(super.table);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> classEntryId(int? value) =>
      _is.ColumnValue(table.classEntryId, value);

  _is.ColumnValue<int, int> classDataId(int? value) =>
      _is.ColumnValue(table.classDataId, value);

  _is.ColumnValue<int, int> backgroundDataId(int? value) =>
      _is.ColumnValue(table.backgroundDataId, value);

  _is.ColumnValue<_iqrhamom.Skill, _iqrhamom.Skill> skill(
    _iqrhamom.Skill? value,
  ) => _is.ColumnValue(table.skill, value);

  _is.ColumnValue<
    _if0i9g7r.CharacterSkillSelectionKind,
    _if0i9g7r.CharacterSkillSelectionKind
  >
  kind(_if0i9g7r.CharacterSkillSelectionKind? value) =>
      _is.ColumnValue(table.kind, value);

  _is.ColumnValue<int, int> selectionIndex(int? value) =>
      _is.ColumnValue(table.selectionIndex, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterSkillSelectionRecordTable extends _is.Table<int?> {
  CharacterSkillSelectionRecordTable({super.tableRelation})
    : super(tableName: 'character_skill_selection_data') {
    updateTable = CharacterSkillSelectionRecordUpdateTable(this);
    syncId = _is.ColumnString('syncId', this);
    characterId = _is.ColumnInt('characterId', this);
    classEntryId = _is.ColumnInt('classEntryId', this);
    classDataId = _is.ColumnInt('classDataId', this);
    backgroundDataId = _is.ColumnInt('backgroundDataId', this);
    skill = _is.ColumnEnum('skill', this, _is.EnumSerialization.byName);
    kind = _is.ColumnEnum('kind', this, _is.EnumSerialization.byName);
    selectionIndex = _is.ColumnInt('selectionIndex', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterSkillSelectionRecordUpdateTable updateTable;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt characterId;

  _i50rgqfs.CharacterRecordTable? _character;

  late final _is.ColumnInt classEntryId;

  _igs591f3.CharacterClassEntryRecordTable? _classEntry;

  late final _is.ColumnInt classDataId;

  _i7s9vfyh.ClassDataTable? _classData;

  late final _is.ColumnInt backgroundDataId;

  _i1utzyju.BackgroundDataTable? _backgroundData;

  late final _is.ColumnEnum<_iqrhamom.Skill> skill;

  late final _is.ColumnEnum<_if0i9g7r.CharacterSkillSelectionKind> kind;

  late final _is.ColumnInt selectionIndex;

  late final _is.ColumnDateTime updatedAt;

  _i50rgqfs.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _is.createRelationTable(
      relationFieldName: 'character',
      field: CharacterSkillSelectionRecord.t.characterId,
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
      field: CharacterSkillSelectionRecord.t.classEntryId,
      foreignField: _igs591f3.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _igs591f3.CharacterClassEntryRecordTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _classEntry!;
  }

  _i7s9vfyh.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _is.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterSkillSelectionRecord.t.classDataId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _i1utzyju.BackgroundDataTable get backgroundData {
    if (_backgroundData != null) return _backgroundData!;
    _backgroundData = _is.createRelationTable(
      relationFieldName: 'backgroundData',
      field: CharacterSkillSelectionRecord.t.backgroundDataId,
      foreignField: _i1utzyju.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1utzyju.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _backgroundData!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    syncId,
    characterId,
    classEntryId,
    classDataId,
    backgroundDataId,
    skill,
    kind,
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
    if (relationField == 'classData') {
      return classData;
    }
    if (relationField == 'backgroundData') {
      return backgroundData;
    }
    return null;
  }
}

class CharacterSkillSelectionRecordInclude extends _is.IncludeObject {
  CharacterSkillSelectionRecordInclude._({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
    _i7s9vfyh.ClassDataInclude? classData,
    _i1utzyju.BackgroundDataInclude? backgroundData,
  }) {
    _character = character;
    _classEntry = classEntry;
    _classData = classData;
    _backgroundData = backgroundData;
  }

  _i50rgqfs.CharacterRecordInclude? _character;

  _igs591f3.CharacterClassEntryRecordInclude? _classEntry;

  _i7s9vfyh.ClassDataInclude? _classData;

  _i1utzyju.BackgroundDataInclude? _backgroundData;

  @override
  Map<String, _is.Include?> get includes => {
    'character': _character,
    'classEntry': _classEntry,
    'classData': _classData,
    'backgroundData': _backgroundData,
  };

  @override
  _is.Table<int?> get table => CharacterSkillSelectionRecord.t;
}

class CharacterSkillSelectionRecordIncludeList extends _is.IncludeList {
  CharacterSkillSelectionRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSkillSelectionRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterSkillSelectionRecord.t;
}

class CharacterSkillSelectionRecordRepository {
  const CharacterSkillSelectionRecordRepository._();

  final attachRow = const CharacterSkillSelectionRecordAttachRowRepository._();

  final detachRow = const CharacterSkillSelectionRecordDetachRowRepository._();

  /// Returns a list of [CharacterSkillSelectionRecord]s matching the given query parameters.
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
  Future<List<CharacterSkillSelectionRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterSkillSelectionRecord] matching the given query parameters.
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
  Future<CharacterSkillSelectionRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterSkillSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterSkillSelectionRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterSkillSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterSkillSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSkillSelectionRecord]s will have their `id` fields set.
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
  Future<List<CharacterSkillSelectionRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterSkillSelectionRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterSkillSelectionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterSkillSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSkillSelectionRecord] will have its `id` field set.
  Future<CharacterSkillSelectionRecord> insertRow(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSkillSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterSkillSelectionRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterSkillSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSkillSelectionRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterSkillSelectionRecord> rows, {
    required _is.ColumnSelections<CharacterSkillSelectionRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSkillSelectionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterSkillSelectionRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterSkillSelectionRecord.t),
      updateColumns: updateColumns?.call(CharacterSkillSelectionRecord.t),
      updateWhere: updateWhere?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterSkillSelectionRecord] and returns the resulting row.
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
  /// The returned [CharacterSkillSelectionRecord] will have its `id` field set.
  Future<CharacterSkillSelectionRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord row, {
    required _is.ColumnSelections<CharacterSkillSelectionRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSkillSelectionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterSkillSelectionRecord>(
      row,
      conflictColumns: conflictColumns(CharacterSkillSelectionRecord.t),
      updateColumns: updateColumns?.call(CharacterSkillSelectionRecord.t),
      updateWhere: updateWhere?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSkillSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSkillSelectionRecord>> update(
    _is.DatabaseSession session,
    List<CharacterSkillSelectionRecord> rows, {
    _is.ColumnSelections<CharacterSkillSelectionRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterSkillSelectionRecord>(
      rows,
      columns: columns?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterSkillSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSkillSelectionRecord> updateRow(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord row, {
    _is.ColumnSelections<CharacterSkillSelectionRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSkillSelectionRecord>(
      row,
      columns: columns?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSkillSelectionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterSkillSelectionRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      CharacterSkillSelectionRecordUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterSkillSelectionRecord>(
      id,
      columnValues: columnValues(CharacterSkillSelectionRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSkillSelectionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSkillSelectionRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      CharacterSkillSelectionRecordUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterSkillSelectionRecord>(
      columnValues: columnValues(CharacterSkillSelectionRecord.t.updateTable),
      where: where(CharacterSkillSelectionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterSkillSelectionRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterSkillSelectionRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterSkillSelectionRecord> rows, {
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterSkillSelectionRecord>(
      rows,
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterSkillSelectionRecord].
  Future<CharacterSkillSelectionRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSkillSelectionRecord>(
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
  Future<List<CharacterSkillSelectionRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>
    where,
    _is.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterSkillSelectionRecord>(
      where: where(CharacterSkillSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterSkillSelectionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterSkillSelectionRecord>(
      where: where(CharacterSkillSelectionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterSkillSelectionRecordAttachRowRepository {
  const CharacterSkillSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i50rgqfs.CharacterRecord character, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      characterId: character.id,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _igs591f3.CharacterClassEntryRecord classEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      classEntryId: classEntry.id,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [ClassData]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i7s9vfyh.ClassData classData, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      classDataId: classData.id,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [BackgroundData]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `backgroundDataId` to refer to the [BackgroundData].
  Future<void> backgroundData(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i1utzyju.BackgroundData backgroundData, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (backgroundData.id == null) {
      throw ArgumentError.notNull('backgroundData.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      backgroundDataId: backgroundData.id,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.backgroundDataId],
      transaction: transaction,
    );
  }
}

class CharacterSkillSelectionRecordDetachRowRepository {
  const CharacterSkillSelectionRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterSkillSelectionRecord] and the [CharacterClassEntryRecord] set in `classEntry`
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classEntry(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      classEntryId: null,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterSkillSelectionRecord] and the [ClassData] set in `classData`
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classData(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      classDataId: null,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterSkillSelectionRecord] and the [BackgroundData] set in `backgroundData`
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `backgroundDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> backgroundData(
    _is.DatabaseSession session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
      backgroundDataId: null,
    );
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.backgroundDataId],
      transaction: transaction,
    );
  }
}
