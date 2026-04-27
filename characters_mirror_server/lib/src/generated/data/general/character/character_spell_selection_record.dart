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
import '../../../data/spell_data.dart' as _i5;
import '../../../enums/character_spell_selection_kind.dart' as _i6;

abstract class CharacterSpellSelectionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterSpellSelectionRecord._({
    this.id,
    this.syncId,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.classDataId,
    this.classData,
    this.spellId,
    this.spell,
    this.spellKey,
    this.kind,
    this.selectionIndex,
    this.updatedAt,
  });

  factory CharacterSpellSelectionRecord({
    int? id,
    String? syncId,
    required int characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? spellId,
    _i5.SpellData? spell,
    String? spellKey,
    _i6.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterSpellSelectionRecordImpl;

  factory CharacterSpellSelectionRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSpellSelectionRecord(
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
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i5.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      spellKey: jsonSerialization['spellKey'] as String?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i6.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterSpellSelectionRecordTable();

  static const db = CharacterSpellSelectionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i2.CharacterRecord? character;

  int? classEntryId;

  _i3.CharacterClassEntryRecord? classEntry;

  int? classDataId;

  _i4.ClassData? classData;

  int? spellId;

  _i5.SpellData? spell;

  String? spellKey;

  _i6.CharacterSpellSelectionKind? kind;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSpellSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSpellSelectionRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? spellId,
    _i5.SpellData? spell,
    String? spellKey,
    _i6.CharacterSpellSelectionKind? kind,
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
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellKey != null) 'spellKey': spellKey,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterSpellSelectionRecordInclude include({
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
    _i4.ClassDataInclude? classData,
    _i5.SpellDataInclude? spell,
  }) {
    return CharacterSpellSelectionRecordInclude._(
      character: character,
      classEntry: classEntry,
      classData: classData,
      spell: spell,
    );
  }

  static CharacterSpellSelectionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    CharacterSpellSelectionRecordInclude? include,
  }) {
    return CharacterSpellSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSpellSelectionRecordImpl extends CharacterSpellSelectionRecord {
  _CharacterSpellSelectionRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i4.ClassData? classData,
    int? spellId,
    _i5.SpellData? spell,
    String? spellKey,
    _i6.CharacterSpellSelectionKind? kind,
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
          spellId: spellId,
          spell: spell,
          spellKey: spellKey,
          kind: kind,
          selectionIndex: selectionIndex,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterSpellSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSpellSelectionRecord copyWith({
    Object? id = _Undefined,
    Object? syncId = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? classDataId = _Undefined,
    Object? classData = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? spellKey = _Undefined,
    Object? kind = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSpellSelectionRecord(
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
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _i5.SpellData? ? spell : this.spell?.copyWith(),
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      kind: kind is _i6.CharacterSpellSelectionKind? ? kind : this.kind,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterSpellSelectionRecordTable extends _i1.Table<int?> {
  CharacterSpellSelectionRecordTable({super.tableRelation})
      : super(tableName: 'character_spell_selection_data') {
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
    spellId = _i1.ColumnInt(
      'spellId',
      this,
    );
    spellKey = _i1.ColumnString(
      'spellKey',
      this,
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

  late final _i1.ColumnInt spellId;

  _i5.SpellDataTable? _spell;

  late final _i1.ColumnString spellKey;

  late final _i1.ColumnEnum<_i6.CharacterSpellSelectionKind> kind;

  late final _i1.ColumnInt selectionIndex;

  late final _i1.ColumnDateTime updatedAt;

  _i2.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterSpellSelectionRecord.t.characterId,
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
      field: CharacterSpellSelectionRecord.t.classEntryId,
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
      field: CharacterSpellSelectionRecord.t.classDataId,
      foreignField: _i4.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _i5.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _i1.createRelationTable(
      relationFieldName: 'spell',
      field: CharacterSpellSelectionRecord.t.spellId,
      foreignField: _i5.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        syncId,
        characterId,
        classEntryId,
        classDataId,
        spellId,
        spellKey,
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
    if (relationField == 'spell') {
      return spell;
    }
    return null;
  }
}

class CharacterSpellSelectionRecordInclude extends _i1.IncludeObject {
  CharacterSpellSelectionRecordInclude._({
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
    _i4.ClassDataInclude? classData,
    _i5.SpellDataInclude? spell,
  }) {
    _character = character;
    _classEntry = classEntry;
    _classData = classData;
    _spell = spell;
  }

  _i2.CharacterRecordInclude? _character;

  _i3.CharacterClassEntryRecordInclude? _classEntry;

  _i4.ClassDataInclude? _classData;

  _i5.SpellDataInclude? _spell;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classEntry': _classEntry,
        'classData': _classData,
        'spell': _spell,
      };

  @override
  _i1.Table<int?> get table => CharacterSpellSelectionRecord.t;
}

class CharacterSpellSelectionRecordIncludeList extends _i1.IncludeList {
  CharacterSpellSelectionRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSpellSelectionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterSpellSelectionRecord.t;
}

class CharacterSpellSelectionRecordRepository {
  const CharacterSpellSelectionRecordRepository._();

  final attachRow = const CharacterSpellSelectionRecordAttachRowRepository._();

  final detachRow = const CharacterSpellSelectionRecordDetachRowRepository._();

  /// Returns a list of [CharacterSpellSelectionRecord]s matching the given query parameters.
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
  Future<List<CharacterSpellSelectionRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
  }) async {
    return session.db.find<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterSpellSelectionRecord] matching the given query parameters.
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
  Future<CharacterSpellSelectionRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterSpellSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterSpellSelectionRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
  }) async {
    return session.db.findById<CharacterSpellSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterSpellSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSpellSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterSpellSelectionRecord>> insert(
    _i1.Session session,
    List<CharacterSpellSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterSpellSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterSpellSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSpellSelectionRecord] will have its `id` field set.
  Future<CharacterSpellSelectionRecord> insertRow(
    _i1.Session session,
    CharacterSpellSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSpellSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSpellSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterSpellSelectionRecord>> update(
    _i1.Session session,
    List<CharacterSpellSelectionRecord> rows, {
    _i1.ColumnSelections<CharacterSpellSelectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterSpellSelectionRecord>(
      rows,
      columns: columns?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSpellSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSpellSelectionRecord> updateRow(
    _i1.Session session,
    CharacterSpellSelectionRecord row, {
    _i1.ColumnSelections<CharacterSpellSelectionRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSpellSelectionRecord>(
      row,
      columns: columns?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterSpellSelectionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterSpellSelectionRecord>> delete(
    _i1.Session session,
    List<CharacterSpellSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterSpellSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterSpellSelectionRecord].
  Future<CharacterSpellSelectionRecord> deleteRow(
    _i1.Session session,
    CharacterSpellSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSpellSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterSpellSelectionRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterSpellSelectionRecord>(
      where: where(CharacterSpellSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterSpellSelectionRecordAttachRowRepository {
  const CharacterSpellSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _i1.Session session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i2.CharacterRecord character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterSpellSelectionRecord =
        characterSpellSelectionRecord.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _i1.Session session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i3.CharacterClassEntryRecord classEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterSpellSelectionRecord =
        characterSpellSelectionRecord.copyWith(classEntryId: classEntry.id);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [ClassData]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i4.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterSpellSelectionRecord =
        characterSpellSelectionRecord.copyWith(classDataId: classData.id);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [SpellData]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _i1.Session session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i5.SpellData spell, {
    _i1.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $characterSpellSelectionRecord =
        characterSpellSelectionRecord.copyWith(spellId: spell.id);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.spellId],
      transaction: transaction,
    );
  }
}

class CharacterSpellSelectionRecordDetachRowRepository {
  const CharacterSpellSelectionRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterSpellSelectionRecord] and the [CharacterClassEntryRecord] set in `classEntry`
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classEntry(
    _i1.Session session,
    CharacterSpellSelectionRecord characterspellselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterspellselectionrecord.id == null) {
      throw ArgumentError.notNull('characterspellselectionrecord.id');
    }

    var $characterspellselectionrecord =
        characterspellselectionrecord.copyWith(classEntryId: null);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterspellselectionrecord,
      columns: [CharacterSpellSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterSpellSelectionRecord] and the [ClassData] set in `classData`
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classDataId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classData(
    _i1.Session session,
    CharacterSpellSelectionRecord characterspellselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterspellselectionrecord.id == null) {
      throw ArgumentError.notNull('characterspellselectionrecord.id');
    }

    var $characterspellselectionrecord =
        characterspellselectionrecord.copyWith(classDataId: null);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterspellselectionrecord,
      columns: [CharacterSpellSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterSpellSelectionRecord] and the [SpellData] set in `spell`
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `spellId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spell(
    _i1.Session session,
    CharacterSpellSelectionRecord characterspellselectionrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterspellselectionrecord.id == null) {
      throw ArgumentError.notNull('characterspellselectionrecord.id');
    }

    var $characterspellselectionrecord =
        characterspellselectionrecord.copyWith(spellId: null);
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterspellselectionrecord,
      columns: [CharacterSpellSelectionRecord.t.spellId],
      transaction: transaction,
    );
  }
}
