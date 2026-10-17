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
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/class/subclass_data.dart' as _i6yrac43;
import '../../../enums/hit_point_mode.dart' as _ivn6s9bn;

abstract class CharacterClassEntryRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterClassEntryRecord._({
    this.id,
    this.syncId,
    required this.characterId,
    this.character,
    required this.classDataId,
    this.classData,
    this.subclassId,
    this.subclass,
    required this.level,
    this.isStartingClass,
    this.classOrder,
    this.hpMode,
    this.hpRolledValues,
    this.notes,
    this.updatedAt,
  });

  factory CharacterClassEntryRecord({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    required int classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassId,
    _i6yrac43.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
  }) = _CharacterClassEntryRecordImpl;

  factory CharacterClassEntryRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterClassEntryRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i50rgqfs.CharacterRecord>(
              jsonSerialization['character'],
            ),
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['classData'],
            ),
      subclassId: jsonSerialization['subclassId'] as int?,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6yrac43.SubclassData>(
              jsonSerialization['subclass'],
            ),
      level: jsonSerialization['level'] as int,
      isStartingClass: jsonSerialization['isStartingClass'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['isStartingClass'],
            ),
      classOrder: jsonSerialization['classOrder'] as int?,
      hpMode: jsonSerialization['hpMode'] == null
          ? null
          : _ivn6s9bn.HitPointMode.fromJson(
              (jsonSerialization['hpMode'] as String),
            ),
      hpRolledValues: jsonSerialization['hpRolledValues'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<int>>(
              jsonSerialization['hpRolledValues'],
            ),
      notes: jsonSerialization['notes'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterClassEntryRecordTable();

  static const db = CharacterClassEntryRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i50rgqfs.CharacterRecord? character;

  int classDataId;

  _i7s9vfyh.ClassData? classData;

  int? subclassId;

  _i6yrac43.SubclassData? subclass;

  int level;

  bool? isStartingClass;

  int? classOrder;

  _ivn6s9bn.HitPointMode? hpMode;

  List<int>? hpRolledValues;

  String? notes;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterClassEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterClassEntryRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassId,
    _i6yrac43.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterClassEntryRecord',
      if (id != null) 'id': id,
      if (syncId != null) 'syncId': syncId,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      if (subclassId != null) 'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJson(),
      'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterClassEntryRecordInclude include({
    _i50rgqfs.CharacterRecordInclude? character,
    _i7s9vfyh.ClassDataInclude? classData,
    _i6yrac43.SubclassDataInclude? subclass,
  }) {
    return CharacterClassEntryRecordInclude._(
      character: character,
      classData: classData,
      subclass: subclass,
    );
  }

  static CharacterClassEntryRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    CharacterClassEntryRecordInclude? include,
  }) {
    return CharacterClassEntryRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassEntryRecordImpl extends CharacterClassEntryRecord {
  _CharacterClassEntryRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    required int classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassId,
    _i6yrac43.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _ivn6s9bn.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         syncId: syncId,
         characterId: characterId,
         character: character,
         classDataId: classDataId,
         classData: classData,
         subclassId: subclassId,
         subclass: subclass,
         level: level,
         isStartingClass: isStartingClass,
         classOrder: classOrder,
         hpMode: hpMode,
         hpRolledValues: hpRolledValues,
         notes: notes,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterClassEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterClassEntryRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    Object? subclassId = _Undefined,
    Object? subclass = _Undefined,
    int? level,
    Object? isStartingClass = _Undefined,
    Object? classOrder = _Undefined,
    Object? hpMode = _Undefined,
    Object? hpRolledValues = _Undefined,
    Object? notes = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterClassEntryRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i50rgqfs.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData: classData is _i7s9vfyh.ClassData?
          ? classData
          : this.classData?.copyWith(),
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      subclass: subclass is _i6yrac43.SubclassData?
          ? subclass
          : this.subclass?.copyWith(),
      level: level ?? this.level,
      isStartingClass: isStartingClass is bool?
          ? isStartingClass
          : this.isStartingClass,
      classOrder: classOrder is int? ? classOrder : this.classOrder,
      hpMode: hpMode is _ivn6s9bn.HitPointMode? ? hpMode : this.hpMode,
      hpRolledValues: hpRolledValues is List<int>?
          ? hpRolledValues
          : this.hpRolledValues?.map((e0) => e0).toList(),
      notes: notes is String? ? notes : this.notes,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterClassEntryRecordUpdateTable
    extends _is.UpdateTable<CharacterClassEntryRecordTable> {
  CharacterClassEntryRecordUpdateTable(super.table);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> classDataId(int value) =>
      _is.ColumnValue(table.classDataId, value);

  _is.ColumnValue<int, int> subclassId(int? value) =>
      _is.ColumnValue(table.subclassId, value);

  _is.ColumnValue<int, int> level(int value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<bool, bool> isStartingClass(bool? value) =>
      _is.ColumnValue(table.isStartingClass, value);

  _is.ColumnValue<int, int> classOrder(int? value) =>
      _is.ColumnValue(table.classOrder, value);

  _is.ColumnValue<_ivn6s9bn.HitPointMode, _ivn6s9bn.HitPointMode> hpMode(
    _ivn6s9bn.HitPointMode? value,
  ) => _is.ColumnValue(table.hpMode, value);

  _is.ColumnValue<List<int>, List<int>> hpRolledValues(List<int>? value) =>
      _is.ColumnValue(table.hpRolledValues, value);

  _is.ColumnValue<String, String> notes(String? value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterClassEntryRecordTable extends _is.Table<int?> {
  CharacterClassEntryRecordTable({super.tableRelation})
    : super(tableName: 'character_class_relation') {
    updateTable = CharacterClassEntryRecordUpdateTable(this);
    syncId = _is.ColumnString('syncId', this);
    characterId = _is.ColumnInt('characterId', this);
    classDataId = _is.ColumnInt('classDataId', this);
    subclassId = _is.ColumnInt('subclassId', this);
    level = _is.ColumnInt('level', this);
    isStartingClass = _is.ColumnBool('isStartingClass', this);
    classOrder = _is.ColumnInt('classOrder', this);
    hpMode = _is.ColumnEnum('hpMode', this, _is.EnumSerialization.byName);
    hpRolledValues = _is.ColumnSerializable<List<int>>('hpRolledValues', this);
    notes = _is.ColumnString('notes', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterClassEntryRecordUpdateTable updateTable;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt characterId;

  _i50rgqfs.CharacterRecordTable? _character;

  late final _is.ColumnInt classDataId;

  _i7s9vfyh.ClassDataTable? _classData;

  late final _is.ColumnInt subclassId;

  _i6yrac43.SubclassDataTable? _subclass;

  late final _is.ColumnInt level;

  late final _is.ColumnBool isStartingClass;

  late final _is.ColumnInt classOrder;

  late final _is.ColumnEnum<_ivn6s9bn.HitPointMode> hpMode;

  late final _is.ColumnSerializable<List<int>> hpRolledValues;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime updatedAt;

  _i50rgqfs.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _is.createRelationTable(
      relationFieldName: 'character',
      field: CharacterClassEntryRecord.t.characterId,
      foreignField: _i50rgqfs.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i50rgqfs.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i7s9vfyh.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _is.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterClassEntryRecord.t.classDataId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _i6yrac43.SubclassDataTable get subclass {
    if (_subclass != null) return _subclass!;
    _subclass = _is.createRelationTable(
      relationFieldName: 'subclass',
      field: CharacterClassEntryRecord.t.subclassId,
      foreignField: _i6yrac43.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6yrac43.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _subclass!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    syncId,
    characterId,
    classDataId,
    subclassId,
    level,
    isStartingClass,
    classOrder,
    hpMode,
    hpRolledValues,
    notes,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    if (relationField == 'classData') {
      return classData;
    }
    if (relationField == 'subclass') {
      return subclass;
    }
    return null;
  }
}

class CharacterClassEntryRecordInclude extends _is.IncludeObject {
  CharacterClassEntryRecordInclude._({
    _i50rgqfs.CharacterRecordInclude? character,
    _i7s9vfyh.ClassDataInclude? classData,
    _i6yrac43.SubclassDataInclude? subclass,
  }) {
    _character = character;
    _classData = classData;
    _subclass = subclass;
  }

  _i50rgqfs.CharacterRecordInclude? _character;

  _i7s9vfyh.ClassDataInclude? _classData;

  _i6yrac43.SubclassDataInclude? _subclass;

  @override
  Map<String, _is.Include?> get includes => {
    'character': _character,
    'classData': _classData,
    'subclass': _subclass,
  };

  @override
  _is.Table<int?> get table => CharacterClassEntryRecord.t;
}

class CharacterClassEntryRecordIncludeList extends _is.IncludeList {
  CharacterClassEntryRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterClassEntryRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterClassEntryRecord.t;
}

class CharacterClassEntryRecordRepository {
  const CharacterClassEntryRecordRepository._();

  final attachRow = const CharacterClassEntryRecordAttachRowRepository._();

  final detachRow = const CharacterClassEntryRecordDetachRowRepository._();

  /// Returns a list of [CharacterClassEntryRecord]s matching the given query parameters.
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
  Future<List<CharacterClassEntryRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterClassEntryRecord] matching the given query parameters.
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
  Future<CharacterClassEntryRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterClassEntryRecord] by its [id] or null if no such row exists.
  Future<CharacterClassEntryRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterClassEntryRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterClassEntryRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterClassEntryRecord]s will have their `id` fields set.
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
  Future<List<CharacterClassEntryRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterClassEntryRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterClassEntryRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterClassEntryRecord] and returns the inserted row.
  ///
  /// The returned [CharacterClassEntryRecord] will have its `id` field set.
  Future<CharacterClassEntryRecord> insertRow(
    _is.DatabaseSession session,
    CharacterClassEntryRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterClassEntryRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterClassEntryRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterClassEntryRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterClassEntryRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterClassEntryRecord> rows, {
    required _is.ColumnSelections<CharacterClassEntryRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterClassEntryRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterClassEntryRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterClassEntryRecord.t),
      updateColumns: updateColumns?.call(CharacterClassEntryRecord.t),
      updateWhere: updateWhere?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterClassEntryRecord] and returns the resulting row.
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
  /// The returned [CharacterClassEntryRecord] will have its `id` field set.
  Future<CharacterClassEntryRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterClassEntryRecord row, {
    required _is.ColumnSelections<CharacterClassEntryRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterClassEntryRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterClassEntryRecord>(
      row,
      conflictColumns: conflictColumns(CharacterClassEntryRecord.t),
      updateColumns: updateColumns?.call(CharacterClassEntryRecord.t),
      updateWhere: updateWhere?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterClassEntryRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterClassEntryRecord>> update(
    _is.DatabaseSession session,
    List<CharacterClassEntryRecord> rows, {
    _is.ColumnSelections<CharacterClassEntryRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterClassEntryRecord>(
      rows,
      columns: columns?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterClassEntryRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterClassEntryRecord> updateRow(
    _is.DatabaseSession session,
    CharacterClassEntryRecord row, {
    _is.ColumnSelections<CharacterClassEntryRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterClassEntryRecord>(
      row,
      columns: columns?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterClassEntryRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterClassEntryRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CharacterClassEntryRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterClassEntryRecord>(
      id,
      columnValues: columnValues(CharacterClassEntryRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterClassEntryRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterClassEntryRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CharacterClassEntryRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CharacterClassEntryRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterClassEntryRecord>(
      columnValues: columnValues(CharacterClassEntryRecord.t.updateTable),
      where: where(CharacterClassEntryRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterClassEntryRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterClassEntryRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterClassEntryRecord> rows, {
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterClassEntryRecord>(
      rows,
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterClassEntryRecord].
  Future<CharacterClassEntryRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterClassEntryRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterClassEntryRecord>(
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
  Future<List<CharacterClassEntryRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterClassEntryRecordTable> where,
    _is.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterClassEntryRecord>(
      where: where(CharacterClassEntryRecord.t),
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterClassEntryRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterClassEntryRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterClassEntryRecord>(
      where: where(CharacterClassEntryRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterClassEntryRecordAttachRowRepository {
  const CharacterClassEntryRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterClassEntryRecord] and [CharacterRecord]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _is.DatabaseSession session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i50rgqfs.CharacterRecord character, {
    _is.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterClassEntryRecord = characterClassEntryRecord.copyWith(
      characterId: character.id,
    );
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryRecord] and [ClassData]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _is.DatabaseSession session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i7s9vfyh.ClassData classData, {
    _is.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterClassEntryRecord = characterClassEntryRecord.copyWith(
      classDataId: classData.id,
    );
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryRecord] and [SubclassData]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `subclassId` to refer to the [SubclassData].
  Future<void> subclass(
    _is.DatabaseSession session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i6yrac43.SubclassData subclass, {
    _is.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (subclass.id == null) {
      throw ArgumentError.notNull('subclass.id');
    }

    var $characterClassEntryRecord = characterClassEntryRecord.copyWith(
      subclassId: subclass.id,
    );
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.subclassId],
      transaction: transaction,
    );
  }
}

class CharacterClassEntryRecordDetachRowRepository {
  const CharacterClassEntryRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterClassEntryRecord] and the [SubclassData] set in `subclass`
  /// by setting the [CharacterClassEntryRecord]'s foreign key `subclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclass(
    _is.DatabaseSession session,
    CharacterClassEntryRecord characterClassEntryRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }

    var $characterClassEntryRecord = characterClassEntryRecord.copyWith(
      subclassId: null,
    );
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.subclassId],
      transaction: transaction,
    );
  }
}
