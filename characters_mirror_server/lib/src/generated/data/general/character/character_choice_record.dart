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
import '../../../data/general/character/choice_replacement_history_data.dart'
    as _i2;
import '../../../data/general/character/character_record.dart' as _i3;
import '../../../data/general/character/character_class_entry_record.dart'
    as _i4;

abstract class CharacterChoiceRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    required int characterId,
    _i3.CharacterRecord? character,
    int? classEntryId,
    _i4.CharacterClassEntryRecord? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  }) = _CharacterChoiceRecordImpl;

  factory CharacterChoiceRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceRecord(
      id: jsonSerialization['id'] as int?,
      replacementHistory: (jsonSerialization['replacementHistory'] as List?)
          ?.map((e) => _i2.ChoiceReplacementHistoryData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i3.CharacterRecord.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i4.CharacterClassEntryRecord.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterChoiceRecordTable();

  static const db = CharacterChoiceRecordRepository._();

  @override
  int? id;

  List<_i2.ChoiceReplacementHistoryData>? replacementHistory;

  String? syncId;

  int characterId;

  _i3.CharacterRecord? character;

  int? classEntryId;

  _i4.CharacterClassEntryRecord? classEntry;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterChoiceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceRecord copyWith({
    int? id,
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    int? characterId,
    _i3.CharacterRecord? character,
    int? classEntryId,
    _i4.CharacterClassEntryRecord? classEntry,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (replacementHistory != null)
        'replacementHistory':
            replacementHistory?.toJson(valueToJson: (v) => v.toJson()),
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
    return {if (id != null) 'id': id};
  }

  static CharacterChoiceRecordInclude include({
    _i3.CharacterRecordInclude? character,
    _i4.CharacterClassEntryRecordInclude? classEntry,
  }) {
    return CharacterChoiceRecordInclude._(
      character: character,
      classEntry: classEntry,
    );
  }

  static CharacterChoiceRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    CharacterChoiceRecordInclude? include,
  }) {
    return CharacterChoiceRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChoiceRecordImpl extends CharacterChoiceRecord {
  _CharacterChoiceRecordImpl({
    int? id,
    List<_i2.ChoiceReplacementHistoryData>? replacementHistory,
    String? syncId,
    required int characterId,
    _i3.CharacterRecord? character,
    int? classEntryId,
    _i4.CharacterClassEntryRecord? classEntry,
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
  @_i1.useResult
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
          replacementHistory is List<_i2.ChoiceReplacementHistoryData>?
              ? replacementHistory
              : this.replacementHistory?.map((e0) => e0.copyWith()).toList(),
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i3.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _i4.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterChoiceRecordTable extends _i1.Table<int?> {
  CharacterChoiceRecordTable({super.tableRelation})
      : super(tableName: 'character_choice_data') {
    replacementHistory = _i1.ColumnSerializable(
      'replacementHistory',
      this,
    );
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
    groupKey = _i1.ColumnString(
      'groupKey',
      this,
    );
    optionKey = _i1.ColumnString(
      'optionKey',
      this,
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

  late final _i1.ColumnSerializable replacementHistory;

  late final _i1.ColumnString syncId;

  late final _i1.ColumnInt characterId;

  _i3.CharacterRecordTable? _character;

  late final _i1.ColumnInt classEntryId;

  _i4.CharacterClassEntryRecordTable? _classEntry;

  late final _i1.ColumnString groupKey;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnInt selectionIndex;

  late final _i1.ColumnDateTime updatedAt;

  _i3.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterChoiceRecord.t.characterId,
      foreignField: _i3.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i4.CharacterClassEntryRecordTable get classEntry {
    if (_classEntry != null) return _classEntry!;
    _classEntry = _i1.createRelationTable(
      relationFieldName: 'classEntry',
      field: CharacterChoiceRecord.t.classEntryId,
      foreignField: _i4.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i4.CharacterClassEntryRecordTable(
          tableRelation: foreignTableRelation),
    );
    return _classEntry!;
  }

  @override
  List<_i1.Column> get columns => [
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
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    if (relationField == 'classEntry') {
      return classEntry;
    }
    return null;
  }
}

class CharacterChoiceRecordInclude extends _i1.IncludeObject {
  CharacterChoiceRecordInclude._({
    _i3.CharacterRecordInclude? character,
    _i4.CharacterClassEntryRecordInclude? classEntry,
  }) {
    _character = character;
    _classEntry = classEntry;
  }

  _i3.CharacterRecordInclude? _character;

  _i4.CharacterClassEntryRecordInclude? _classEntry;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classEntry': _classEntry,
      };

  @override
  _i1.Table<int?> get table => CharacterChoiceRecord.t;
}

class CharacterChoiceRecordIncludeList extends _i1.IncludeList {
  CharacterChoiceRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterChoiceRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterChoiceRecord.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
  }) async {
    return session.db.find<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      orderBy: orderBy?.call(CharacterChoiceRecord.t),
      orderByList: orderByList?.call(CharacterChoiceRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterChoiceRecord] by its [id] or null if no such row exists.
  Future<CharacterChoiceRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterChoiceRecordInclude? include,
  }) async {
    return session.db.findById<CharacterChoiceRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterChoiceRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterChoiceRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterChoiceRecord>> insert(
    _i1.Session session,
    List<CharacterChoiceRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterChoiceRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterChoiceRecord] and returns the inserted row.
  ///
  /// The returned [CharacterChoiceRecord] will have its `id` field set.
  Future<CharacterChoiceRecord> insertRow(
    _i1.Session session,
    CharacterChoiceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterChoiceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterChoiceRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterChoiceRecord>> update(
    _i1.Session session,
    List<CharacterChoiceRecord> rows, {
    _i1.ColumnSelections<CharacterChoiceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterChoiceRecord>(
      rows,
      columns: columns?.call(CharacterChoiceRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterChoiceRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterChoiceRecord> updateRow(
    _i1.Session session,
    CharacterChoiceRecord row, {
    _i1.ColumnSelections<CharacterChoiceRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterChoiceRecord>(
      row,
      columns: columns?.call(CharacterChoiceRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterChoiceRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterChoiceRecord>> delete(
    _i1.Session session,
    List<CharacterChoiceRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterChoiceRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterChoiceRecord].
  Future<CharacterChoiceRecord> deleteRow(
    _i1.Session session,
    CharacterChoiceRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterChoiceRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterChoiceRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterChoiceRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterChoiceRecord>(
      where: where(CharacterChoiceRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterChoiceRecord>(
      where: where?.call(CharacterChoiceRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterChoiceRecordAttachRowRepository {
  const CharacterChoiceRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterChoiceRecord] and [CharacterRecord]
  /// by setting the [CharacterChoiceRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _i1.Session session,
    CharacterChoiceRecord characterChoiceRecord,
    _i3.CharacterRecord character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterChoiceRecord.id == null) {
      throw ArgumentError.notNull('characterChoiceRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterChoiceRecord =
        characterChoiceRecord.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterChoiceRecord>(
      $characterChoiceRecord,
      columns: [CharacterChoiceRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterChoiceRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterChoiceRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _i1.Session session,
    CharacterChoiceRecord characterChoiceRecord,
    _i4.CharacterClassEntryRecord classEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (characterChoiceRecord.id == null) {
      throw ArgumentError.notNull('characterChoiceRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterChoiceRecord =
        characterChoiceRecord.copyWith(classEntryId: classEntry.id);
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
    _i1.Session session,
    CharacterChoiceRecord characterchoicerecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterchoicerecord.id == null) {
      throw ArgumentError.notNull('characterchoicerecord.id');
    }

    var $characterchoicerecord =
        characterchoicerecord.copyWith(classEntryId: null);
    await session.db.updateRow<CharacterChoiceRecord>(
      $characterchoicerecord,
      columns: [CharacterChoiceRecord.t.classEntryId],
      transaction: transaction,
    );
  }
}
