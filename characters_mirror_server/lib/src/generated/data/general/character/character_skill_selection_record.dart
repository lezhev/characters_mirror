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
import '../../../data/general/character/character_record.dart' as _i2;
import '../../../data/general/character/character_class_entry_record.dart'
    as _i3;
import '../../../data/general/class/class_data.dart' as _i4;
import '../../../data/background_data.dart' as _i5;
import '../../../enums/skill.dart' as _i6;
import '../../../enums/character_skill_selection_kind.dart' as _i7;

abstract class CharacterSkillSelectionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? backgroundDataId,
    _i5.BackgroundData? backgroundData,
    _i6.Skill? skill,
    _i7.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSkillSelectionRecordImpl;

  factory CharacterSkillSelectionRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSkillSelectionRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterRecord.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i3.CharacterClassEntryRecord.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int?,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i4.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      backgroundDataId: jsonSerialization['backgroundDataId'] as int?,
      backgroundData: jsonSerialization['backgroundData'] == null
          ? null
          : _i5.BackgroundData.fromJson(
              (jsonSerialization['backgroundData'] as Map<String, dynamic>)),
      skill: jsonSerialization['skill'] == null
          ? null
          : _i6.Skill.fromJson((jsonSerialization['skill'] as String)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i7.CharacterSkillSelectionKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterSkillSelectionRecordTable();

  static const db = CharacterSkillSelectionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i2.CharacterRecord? character;

  int? classEntryId;

  _i3.CharacterClassEntryRecord? classEntry;

  int? classDataId;

  _i4.ClassData? classData;

  int? backgroundDataId;

  _i5.BackgroundData? backgroundData;

  _i6.Skill? skill;

  _i7.CharacterSkillSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSkillSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSkillSelectionRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? backgroundDataId,
    _i5.BackgroundData? backgroundData,
    _i6.Skill? skill,
    _i7.CharacterSkillSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    return {if (id != null) 'id': id};
  }

  static CharacterSkillSelectionRecordInclude include({
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
    _i4.ClassDataInclude? classData,
    _i5.BackgroundDataInclude? backgroundData,
  }) {
    return CharacterSkillSelectionRecordInclude._(
      character: character,
      classEntry: classEntry,
      classData: classData,
      backgroundData: backgroundData,
    );
  }

  static CharacterSkillSelectionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    CharacterSkillSelectionRecordInclude? include,
  }) {
    return CharacterSkillSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSkillSelectionRecordImpl extends CharacterSkillSelectionRecord {
  _CharacterSkillSelectionRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? backgroundDataId,
    _i5.BackgroundData? backgroundData,
    _i6.Skill? skill,
    _i7.CharacterSkillSelectionKind? kind,
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
  @_i1.useResult
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
      character: character is _i2.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _i3.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      classData:
          classData is _i4.ClassData? ? classData : this.classData?.copyWith(),
      backgroundDataId:
          backgroundDataId is int? ? backgroundDataId : this.backgroundDataId,
      backgroundData: backgroundData is _i5.BackgroundData?
          ? backgroundData
          : this.backgroundData?.copyWith(),
      skill: skill is _i6.Skill? ? skill : this.skill,
      kind: kind is _i7.CharacterSkillSelectionKind? ? kind : this.kind,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterSkillSelectionRecordTable extends _i1.Table<int?> {
  CharacterSkillSelectionRecordTable({super.tableRelation})
      : super(tableName: 'character_skill_selection_data') {
    syncId = _i1.ColumnString(
      'syncId',
      this,
    );
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    classEntryId = _i1.ColumnInt(
      'classEntryId',
      this,
    );
    classDataId = _i1.ColumnInt(
      'classDataId',
      this,
    );
    backgroundDataId = _i1.ColumnInt(
      'backgroundDataId',
      this,
    );
    skill = _i1.ColumnEnum(
      'skill',
      this,
      _i1.EnumSerialization.byName,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
    );
    selectionIndex = _i1.ColumnInt(
      'selectionIndex',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnString syncId;

  late final _i1.ColumnInt characterId;

  _i2.CharacterRecordTable? _character;

  late final _i1.ColumnInt classEntryId;

  _i3.CharacterClassEntryRecordTable? _classEntry;

  late final _i1.ColumnInt classDataId;

  _i4.ClassDataTable? _classData;

  late final _i1.ColumnInt backgroundDataId;

  _i5.BackgroundDataTable? _backgroundData;

  late final _i1.ColumnEnum<_i6.Skill> skill;

  late final _i1.ColumnEnum<_i7.CharacterSkillSelectionKind> kind;

  late final _i1.ColumnInt selectionIndex;

  late final _i1.ColumnDateTime updatedAt;

  _i2.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterSkillSelectionRecord.t.characterId,
      foreignField: _i2.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i3.CharacterClassEntryRecordTable get classEntry {
    if (_classEntry != null) return _classEntry!;
    _classEntry = _i1.createRelationTable(
      relationFieldName: 'classEntry',
      field: CharacterSkillSelectionRecord.t.classEntryId,
      foreignField: _i3.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.CharacterClassEntryRecordTable(
          tableRelation: foreignTableRelation),
    );
    return _classEntry!;
  }

  _i4.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _i1.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterSkillSelectionRecord.t.classDataId,
      foreignField: _i4.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _i5.BackgroundDataTable get backgroundData {
    if (_backgroundData != null) return _backgroundData!;
    _backgroundData = _i1.createRelationTable(
      relationFieldName: 'backgroundData',
      field: CharacterSkillSelectionRecord.t.backgroundDataId,
      foreignField: _i5.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _backgroundData!;
  }

  @override
  List<_i1.Column> get columns => [
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
  _i1.Table? getRelationTable(String relationField) {
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

class CharacterSkillSelectionRecordInclude extends _i1.IncludeObject {
  CharacterSkillSelectionRecordInclude._({
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
    _i4.ClassDataInclude? classData,
    _i5.BackgroundDataInclude? backgroundData,
  }) {
    _character = character;
    _classEntry = classEntry;
    _classData = classData;
    _backgroundData = backgroundData;
  }

  _i2.CharacterRecordInclude? _character;

  _i3.CharacterClassEntryRecordInclude? _classEntry;

  _i4.ClassDataInclude? _classData;

  _i5.BackgroundDataInclude? _backgroundData;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classEntry': _classEntry,
        'classData': _classData,
        'backgroundData': _backgroundData,
      };

  @override
  _i1.Table<int?> get table => CharacterSkillSelectionRecord.t;
}

class CharacterSkillSelectionRecordIncludeList extends _i1.IncludeList {
  CharacterSkillSelectionRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSkillSelectionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterSkillSelectionRecord.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
  }) async {
    return session.db.find<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterSkillSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSkillSelectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSkillSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSkillSelectionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterSkillSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterSkillSelectionRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterSkillSelectionRecordInclude? include,
  }) async {
    return session.db.findById<CharacterSkillSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterSkillSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSkillSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterSkillSelectionRecord>> insert(
    _i1.Session session,
    List<CharacterSkillSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterSkillSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterSkillSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSkillSelectionRecord] will have its `id` field set.
  Future<CharacterSkillSelectionRecord> insertRow(
    _i1.Session session,
    CharacterSkillSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSkillSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSkillSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterSkillSelectionRecord>> update(
    _i1.Session session,
    List<CharacterSkillSelectionRecord> rows, {
    _i1.ColumnSelections<CharacterSkillSelectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterSkillSelectionRecord>(
      rows,
      columns: columns?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSkillSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSkillSelectionRecord> updateRow(
    _i1.Session session,
    CharacterSkillSelectionRecord row, {
    _i1.ColumnSelections<CharacterSkillSelectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSkillSelectionRecord>(
      row,
      columns: columns?.call(CharacterSkillSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterSkillSelectionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterSkillSelectionRecord>> delete(
    _i1.Session session,
    List<CharacterSkillSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterSkillSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterSkillSelectionRecord].
  Future<CharacterSkillSelectionRecord> deleteRow(
    _i1.Session session,
    CharacterSkillSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSkillSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterSkillSelectionRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterSkillSelectionRecord>(
      where: where(CharacterSkillSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSkillSelectionRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSkillSelectionRecord>(
      where: where?.call(CharacterSkillSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterSkillSelectionRecordAttachRowRepository {
  const CharacterSkillSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _i1.Session session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i2.CharacterRecord character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterSkillSelectionRecord =
        characterSkillSelectionRecord.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _i1.Session session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i3.CharacterClassEntryRecord classEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterSkillSelectionRecord =
        characterSkillSelectionRecord.copyWith(classEntryId: classEntry.id);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [ClassData]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i4.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterSkillSelectionRecord =
        characterSkillSelectionRecord.copyWith(classDataId: classData.id);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterSkillSelectionRecord,
      columns: [CharacterSkillSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSkillSelectionRecord] and [BackgroundData]
  /// by setting the [CharacterSkillSelectionRecord]'s foreign key `backgroundDataId` to refer to the [BackgroundData].
  Future<void> backgroundData(
    _i1.Session session,
    CharacterSkillSelectionRecord characterSkillSelectionRecord,
    _i5.BackgroundData backgroundData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSkillSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSkillSelectionRecord.id');
    }
    if (backgroundData.id == null) {
      throw ArgumentError.notNull('backgroundData.id');
    }

    var $characterSkillSelectionRecord = characterSkillSelectionRecord.copyWith(
        backgroundDataId: backgroundData.id);
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
    _i1.Session session,
    CharacterSkillSelectionRecord characterskillselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterskillselectionrecord.id == null) {
      throw ArgumentError.notNull('characterskillselectionrecord.id');
    }

    var $characterskillselectionrecord =
        characterskillselectionrecord.copyWith(classEntryId: null);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterskillselectionrecord,
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
    _i1.Session session,
    CharacterSkillSelectionRecord characterskillselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterskillselectionrecord.id == null) {
      throw ArgumentError.notNull('characterskillselectionrecord.id');
    }

    var $characterskillselectionrecord =
        characterskillselectionrecord.copyWith(classDataId: null);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterskillselectionrecord,
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
    _i1.Session session,
    CharacterSkillSelectionRecord characterskillselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterskillselectionrecord.id == null) {
      throw ArgumentError.notNull('characterskillselectionrecord.id');
    }

    var $characterskillselectionrecord =
        characterskillselectionrecord.copyWith(backgroundDataId: null);
    await session.db.updateRow<CharacterSkillSelectionRecord>(
      $characterskillselectionrecord,
      columns: [CharacterSkillSelectionRecord.t.backgroundDataId],
      transaction: transaction,
    );
  }
}
