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
import '../../../enums/choice_source_type.dart' as _i4;
import '../../../enums/ability.dart' as _i5;
import '../../../enums/language.dart' as _i6;

abstract class CharacterChoiceRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterChoiceRecord._({
    this.id,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.sourceType,
    this.sourceId,
    this.groupKey,
    this.optionKey,
    this.selectionIndex,
    this.selectedAbility,
    this.selectedLanguage,
    this.selectedToolKey,
    this.selectedSpellKey,
    this.selectedFeatId,
    this.selectedText,
    this.selectedCount,
  });

  factory CharacterChoiceRecord({
    int? id,
    required int characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i5.Ability? selectedAbility,
    _i6.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  }) = _CharacterChoiceRecordImpl;

  factory CharacterChoiceRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceRecord(
      id: jsonSerialization['id'] as int?,
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
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i4.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      selectedAbility: jsonSerialization['selectedAbility'] == null
          ? null
          : _i5.Ability.fromJson(
              (jsonSerialization['selectedAbility'] as String)),
      selectedLanguage: jsonSerialization['selectedLanguage'] == null
          ? null
          : _i6.Language.fromJson(
              (jsonSerialization['selectedLanguage'] as String)),
      selectedToolKey: jsonSerialization['selectedToolKey'] as String?,
      selectedSpellKey: jsonSerialization['selectedSpellKey'] as String?,
      selectedFeatId: jsonSerialization['selectedFeatId'] as int?,
      selectedText: jsonSerialization['selectedText'] as String?,
      selectedCount: jsonSerialization['selectedCount'] as int?,
    );
  }

  static final t = CharacterChoiceRecordTable();

  static const db = CharacterChoiceRecordRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterRecord? character;

  int? classEntryId;

  _i3.CharacterClassEntryRecord? classEntry;

  _i4.ChoiceSourceType? sourceType;

  int? sourceId;

  String? groupKey;

  String? optionKey;

  int? selectionIndex;

  _i5.Ability? selectedAbility;

  _i6.Language? selectedLanguage;

  String? selectedToolKey;

  String? selectedSpellKey;

  int? selectedFeatId;

  String? selectedText;

  int? selectedCount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterChoiceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceRecord copyWith({
    int? id,
    int? characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i5.Ability? selectedAbility,
    _i6.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (classEntryId != null) 'classEntryId': classEntryId,
      if (classEntry != null) 'classEntry': classEntry?.toJson(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
      if (selectedAbility != null) 'selectedAbility': selectedAbility?.toJson(),
      if (selectedLanguage != null)
        'selectedLanguage': selectedLanguage?.toJson(),
      if (selectedToolKey != null) 'selectedToolKey': selectedToolKey,
      if (selectedSpellKey != null) 'selectedSpellKey': selectedSpellKey,
      if (selectedFeatId != null) 'selectedFeatId': selectedFeatId,
      if (selectedText != null) 'selectedText': selectedText,
      if (selectedCount != null) 'selectedCount': selectedCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterChoiceRecordInclude include({
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
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
    required int characterId,
    _i2.CharacterRecord? character,
    int? classEntryId,
    _i3.CharacterClassEntryRecord? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    int? selectionIndex,
    _i5.Ability? selectedAbility,
    _i6.Language? selectedLanguage,
    String? selectedToolKey,
    String? selectedSpellKey,
    int? selectedFeatId,
    String? selectedText,
    int? selectedCount,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          classEntryId: classEntryId,
          classEntry: classEntry,
          sourceType: sourceType,
          sourceId: sourceId,
          groupKey: groupKey,
          optionKey: optionKey,
          selectionIndex: selectionIndex,
          selectedAbility: selectedAbility,
          selectedLanguage: selectedLanguage,
          selectedToolKey: selectedToolKey,
          selectedSpellKey: selectedSpellKey,
          selectedFeatId: selectedFeatId,
          selectedText: selectedText,
          selectedCount: selectedCount,
        );

  /// Returns a shallow copy of this [CharacterChoiceRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterChoiceRecord copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
    Object? selectedAbility = _Undefined,
    Object? selectedLanguage = _Undefined,
    Object? selectedToolKey = _Undefined,
    Object? selectedSpellKey = _Undefined,
    Object? selectedFeatId = _Undefined,
    Object? selectedText = _Undefined,
    Object? selectedCount = _Undefined,
  }) {
    return CharacterChoiceRecord(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _i3.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      sourceType:
          sourceType is _i4.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
      selectedAbility: selectedAbility is _i5.Ability?
          ? selectedAbility
          : this.selectedAbility,
      selectedLanguage: selectedLanguage is _i6.Language?
          ? selectedLanguage
          : this.selectedLanguage,
      selectedToolKey:
          selectedToolKey is String? ? selectedToolKey : this.selectedToolKey,
      selectedSpellKey: selectedSpellKey is String?
          ? selectedSpellKey
          : this.selectedSpellKey,
      selectedFeatId:
          selectedFeatId is int? ? selectedFeatId : this.selectedFeatId,
      selectedText: selectedText is String? ? selectedText : this.selectedText,
      selectedCount: selectedCount is int? ? selectedCount : this.selectedCount,
    );
  }
}

class CharacterChoiceRecordTable extends _i1.Table<int?> {
  CharacterChoiceRecordTable({super.tableRelation})
      : super(tableName: 'character_choice_data') {
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    classEntryId = _i1.ColumnInt(
      'classEntryId',
      this,
    );
    sourceType = _i1.ColumnEnum(
      'sourceType',
      this,
      _i1.EnumSerialization.byName,
    );
    sourceId = _i1.ColumnInt(
      'sourceId',
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
    selectedAbility = _i1.ColumnEnum(
      'selectedAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    selectedLanguage = _i1.ColumnEnum(
      'selectedLanguage',
      this,
      _i1.EnumSerialization.byName,
    );
    selectedToolKey = _i1.ColumnString(
      'selectedToolKey',
      this,
    );
    selectedSpellKey = _i1.ColumnString(
      'selectedSpellKey',
      this,
    );
    selectedFeatId = _i1.ColumnInt(
      'selectedFeatId',
      this,
    );
    selectedText = _i1.ColumnString(
      'selectedText',
      this,
    );
    selectedCount = _i1.ColumnInt(
      'selectedCount',
      this,
    );
  }

  late final _i1.ColumnInt characterId;

  _i2.CharacterRecordTable? _character;

  late final _i1.ColumnInt classEntryId;

  _i3.CharacterClassEntryRecordTable? _classEntry;

  late final _i1.ColumnEnum<_i4.ChoiceSourceType> sourceType;

  late final _i1.ColumnInt sourceId;

  late final _i1.ColumnString groupKey;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnInt selectionIndex;

  late final _i1.ColumnEnum<_i5.Ability> selectedAbility;

  late final _i1.ColumnEnum<_i6.Language> selectedLanguage;

  late final _i1.ColumnString selectedToolKey;

  late final _i1.ColumnString selectedSpellKey;

  late final _i1.ColumnInt selectedFeatId;

  late final _i1.ColumnString selectedText;

  late final _i1.ColumnInt selectedCount;

  _i2.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterChoiceRecord.t.characterId,
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
      field: CharacterChoiceRecord.t.classEntryId,
      foreignField: _i3.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i3.CharacterClassEntryRecordTable(
          tableRelation: foreignTableRelation),
    );
    return _classEntry!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        characterId,
        classEntryId,
        sourceType,
        sourceId,
        groupKey,
        optionKey,
        selectionIndex,
        selectedAbility,
        selectedLanguage,
        selectedToolKey,
        selectedSpellKey,
        selectedFeatId,
        selectedText,
        selectedCount,
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
    _i2.CharacterRecordInclude? character,
    _i3.CharacterClassEntryRecordInclude? classEntry,
  }) {
    _character = character;
    _classEntry = classEntry;
  }

  _i2.CharacterRecordInclude? _character;

  _i3.CharacterClassEntryRecordInclude? _classEntry;

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
    _i2.CharacterRecord character, {
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
    _i3.CharacterClassEntryRecord classEntry, {
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
