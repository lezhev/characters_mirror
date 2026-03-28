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
import '../../../data/general/character/character_data.dart' as _i2;
import '../../../data/general/character/character_class_entry_data.dart' as _i3;
import '../../../enums/choice_source_type.dart' as _i4;

abstract class CharacterChoiceData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterChoiceData._({
    this.id,
    required this.characterId,
    this.character,
    this.classEntryId,
    this.classEntry,
    this.sourceType,
    this.sourceId,
    this.groupKey,
    this.optionKey,
    this.selectedSpellKey,
    this.selectedItemKey,
    this.selectedText,
    this.selectedCount,
  });

  factory CharacterChoiceData({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
    String? selectedText,
    int? selectedCount,
  }) = _CharacterChoiceDataImpl;

  factory CharacterChoiceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChoiceData(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _i3.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntry'] as Map<String, dynamic>)),
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i4.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as int)),
      sourceId: jsonSerialization['sourceId'] as int?,
      groupKey: jsonSerialization['groupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectedSpellKey: jsonSerialization['selectedSpellKey'] as String?,
      selectedItemKey: jsonSerialization['selectedItemKey'] as String?,
      selectedText: jsonSerialization['selectedText'] as String?,
      selectedCount: jsonSerialization['selectedCount'] as int?,
    );
  }

  static final t = CharacterChoiceDataTable();

  static const db = CharacterChoiceDataRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterData? character;

  int? classEntryId;

  _i3.CharacterClassEntryData? classEntry;

  _i4.ChoiceSourceType? sourceType;

  int? sourceId;

  String? groupKey;

  String? optionKey;

  String? selectedSpellKey;

  String? selectedItemKey;

  String? selectedText;

  int? selectedCount;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChoiceData copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
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
      if (selectedSpellKey != null) 'selectedSpellKey': selectedSpellKey,
      if (selectedItemKey != null) 'selectedItemKey': selectedItemKey,
      if (selectedText != null) 'selectedText': selectedText,
      if (selectedCount != null) 'selectedCount': selectedCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJsonForProtocol(),
      if (classEntryId != null) 'classEntryId': classEntryId,
      if (classEntry != null) 'classEntry': classEntry?.toJsonForProtocol(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (groupKey != null) 'groupKey': groupKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectedSpellKey != null) 'selectedSpellKey': selectedSpellKey,
      if (selectedItemKey != null) 'selectedItemKey': selectedItemKey,
      if (selectedText != null) 'selectedText': selectedText,
      if (selectedCount != null) 'selectedCount': selectedCount,
    };
  }

  static CharacterChoiceDataInclude include({
    _i2.CharacterDataInclude? character,
    _i3.CharacterClassEntryDataInclude? classEntry,
  }) {
    return CharacterChoiceDataInclude._(
      character: character,
      classEntry: classEntry,
    );
  }

  static CharacterChoiceDataIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterChoiceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceDataTable>? orderByList,
    CharacterChoiceDataInclude? include,
  }) {
    return CharacterChoiceDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterChoiceData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterChoiceData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChoiceDataImpl extends CharacterChoiceData {
  _CharacterChoiceDataImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    int? classEntryId,
    _i3.CharacterClassEntryData? classEntry,
    _i4.ChoiceSourceType? sourceType,
    int? sourceId,
    String? groupKey,
    String? optionKey,
    String? selectedSpellKey,
    String? selectedItemKey,
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
          selectedSpellKey: selectedSpellKey,
          selectedItemKey: selectedItemKey,
          selectedText: selectedText,
          selectedCount: selectedCount,
        );

  /// Returns a shallow copy of this [CharacterChoiceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterChoiceData copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? classEntryId = _Undefined,
    Object? classEntry = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? groupKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectedSpellKey = _Undefined,
    Object? selectedItemKey = _Undefined,
    Object? selectedText = _Undefined,
    Object? selectedCount = _Undefined,
  }) {
    return CharacterChoiceData(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _i3.CharacterClassEntryData?
          ? classEntry
          : this.classEntry?.copyWith(),
      sourceType:
          sourceType is _i4.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      groupKey: groupKey is String? ? groupKey : this.groupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectedSpellKey: selectedSpellKey is String?
          ? selectedSpellKey
          : this.selectedSpellKey,
      selectedItemKey:
          selectedItemKey is String? ? selectedItemKey : this.selectedItemKey,
      selectedText: selectedText is String? ? selectedText : this.selectedText,
      selectedCount: selectedCount is int? ? selectedCount : this.selectedCount,
    );
  }
}

class CharacterChoiceDataTable extends _i1.Table<int?> {
  CharacterChoiceDataTable({super.tableRelation})
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
      _i1.EnumSerialization.byIndex,
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
    selectedSpellKey = _i1.ColumnString(
      'selectedSpellKey',
      this,
    );
    selectedItemKey = _i1.ColumnString(
      'selectedItemKey',
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

  _i2.CharacterDataTable? _character;

  late final _i1.ColumnInt classEntryId;

  _i3.CharacterClassEntryDataTable? _classEntry;

  late final _i1.ColumnEnum<_i4.ChoiceSourceType> sourceType;

  late final _i1.ColumnInt sourceId;

  late final _i1.ColumnString groupKey;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnString selectedSpellKey;

  late final _i1.ColumnString selectedItemKey;

  late final _i1.ColumnString selectedText;

  late final _i1.ColumnInt selectedCount;

  _i2.CharacterDataTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterChoiceData.t.characterId,
      foreignField: _i2.CharacterData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterDataTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i3.CharacterClassEntryDataTable get classEntry {
    if (_classEntry != null) return _classEntry!;
    _classEntry = _i1.createRelationTable(
      relationFieldName: 'classEntry',
      field: CharacterChoiceData.t.classEntryId,
      foreignField: _i3.CharacterClassEntryData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.CharacterClassEntryDataTable(tableRelation: foreignTableRelation),
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
        selectedSpellKey,
        selectedItemKey,
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

class CharacterChoiceDataInclude extends _i1.IncludeObject {
  CharacterChoiceDataInclude._({
    _i2.CharacterDataInclude? character,
    _i3.CharacterClassEntryDataInclude? classEntry,
  }) {
    _character = character;
    _classEntry = classEntry;
  }

  _i2.CharacterDataInclude? _character;

  _i3.CharacterClassEntryDataInclude? _classEntry;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classEntry': _classEntry,
      };

  @override
  _i1.Table<int?> get table => CharacterChoiceData.t;
}

class CharacterChoiceDataIncludeList extends _i1.IncludeList {
  CharacterChoiceDataIncludeList._({
    _i1.WhereExpressionBuilder<CharacterChoiceDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterChoiceData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterChoiceData.t;
}

class CharacterChoiceDataRepository {
  const CharacterChoiceDataRepository._();

  final attachRow = const CharacterChoiceDataAttachRowRepository._();

  final detachRow = const CharacterChoiceDataDetachRowRepository._();

  /// Returns a list of [CharacterChoiceData]s matching the given query parameters.
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
  Future<List<CharacterChoiceData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterChoiceDataInclude? include,
  }) async {
    return session.db.find<CharacterChoiceData>(
      where: where?.call(CharacterChoiceData.t),
      orderBy: orderBy?.call(CharacterChoiceData.t),
      orderByList: orderByList?.call(CharacterChoiceData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterChoiceData] matching the given query parameters.
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
  Future<CharacterChoiceData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterChoiceDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterChoiceDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterChoiceDataInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterChoiceData>(
      where: where?.call(CharacterChoiceData.t),
      orderBy: orderBy?.call(CharacterChoiceData.t),
      orderByList: orderByList?.call(CharacterChoiceData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterChoiceData] by its [id] or null if no such row exists.
  Future<CharacterChoiceData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterChoiceDataInclude? include,
  }) async {
    return session.db.findById<CharacterChoiceData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterChoiceData]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterChoiceData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterChoiceData>> insert(
    _i1.Session session,
    List<CharacterChoiceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterChoiceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterChoiceData] and returns the inserted row.
  ///
  /// The returned [CharacterChoiceData] will have its `id` field set.
  Future<CharacterChoiceData> insertRow(
    _i1.Session session,
    CharacterChoiceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterChoiceData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterChoiceData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterChoiceData>> update(
    _i1.Session session,
    List<CharacterChoiceData> rows, {
    _i1.ColumnSelections<CharacterChoiceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterChoiceData>(
      rows,
      columns: columns?.call(CharacterChoiceData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterChoiceData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterChoiceData> updateRow(
    _i1.Session session,
    CharacterChoiceData row, {
    _i1.ColumnSelections<CharacterChoiceDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterChoiceData>(
      row,
      columns: columns?.call(CharacterChoiceData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterChoiceData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterChoiceData>> delete(
    _i1.Session session,
    List<CharacterChoiceData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterChoiceData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterChoiceData].
  Future<CharacterChoiceData> deleteRow(
    _i1.Session session,
    CharacterChoiceData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterChoiceData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterChoiceData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterChoiceDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterChoiceData>(
      where: where(CharacterChoiceData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterChoiceDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterChoiceData>(
      where: where?.call(CharacterChoiceData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterChoiceDataAttachRowRepository {
  const CharacterChoiceDataAttachRowRepository._();

  /// Creates a relation between the given [CharacterChoiceData] and [CharacterData]
  /// by setting the [CharacterChoiceData]'s foreign key `characterId` to refer to the [CharacterData].
  Future<void> character(
    _i1.Session session,
    CharacterChoiceData characterChoiceData,
    _i2.CharacterData character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterChoiceData.id == null) {
      throw ArgumentError.notNull('characterChoiceData.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterChoiceData =
        characterChoiceData.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterChoiceData>(
      $characterChoiceData,
      columns: [CharacterChoiceData.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterChoiceData] and [CharacterClassEntryData]
  /// by setting the [CharacterChoiceData]'s foreign key `classEntryId` to refer to the [CharacterClassEntryData].
  Future<void> classEntry(
    _i1.Session session,
    CharacterChoiceData characterChoiceData,
    _i3.CharacterClassEntryData classEntry, {
    _i1.Transaction? transaction,
  }) async {
    if (characterChoiceData.id == null) {
      throw ArgumentError.notNull('characterChoiceData.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterChoiceData =
        characterChoiceData.copyWith(classEntryId: classEntry.id);
    await session.db.updateRow<CharacterChoiceData>(
      $characterChoiceData,
      columns: [CharacterChoiceData.t.classEntryId],
      transaction: transaction,
    );
  }
}

class CharacterChoiceDataDetachRowRepository {
  const CharacterChoiceDataDetachRowRepository._();

  /// Detaches the relation between this [CharacterChoiceData] and the [CharacterClassEntryData] set in `classEntry`
  /// by setting the [CharacterChoiceData]'s foreign key `classEntryId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classEntry(
    _i1.Session session,
    CharacterChoiceData characterchoicedata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterchoicedata.id == null) {
      throw ArgumentError.notNull('characterchoicedata.id');
    }

    var $characterchoicedata = characterchoicedata.copyWith(classEntryId: null);
    await session.db.updateRow<CharacterChoiceData>(
      $characterchoicedata,
      columns: [CharacterChoiceData.t.classEntryId],
      transaction: transaction,
    );
  }
}
