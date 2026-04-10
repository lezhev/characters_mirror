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
import '../../../enums/choice_source_type.dart' as _i3;

abstract class CharacterStartingEquipmentSelectionRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterStartingEquipmentSelectionRecord._({
    this.id,
    required this.characterId,
    this.character,
    this.sourceType,
    this.sourceId,
    this.blockKey,
    this.optionKey,
    this.selectionIndex,
  });

  factory CharacterStartingEquipmentSelectionRecord({
    int? id,
    required int characterId,
    _i2.CharacterRecord? character,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
  }) = _CharacterStartingEquipmentSelectionRecordImpl;

  factory CharacterStartingEquipmentSelectionRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterStartingEquipmentSelectionRecord(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterRecord.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i3.ChoiceSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      blockKey: jsonSerialization['blockKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
    );
  }

  static final t = CharacterStartingEquipmentSelectionRecordTable();

  static const db = CharacterStartingEquipmentSelectionRecordRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterRecord? character;

  _i3.ChoiceSourceType? sourceType;

  int? sourceId;

  String? blockKey;

  String? optionKey;

  int? selectionIndex;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterStartingEquipmentSelectionRecord copyWith({
    int? id,
    int? characterId,
    _i2.CharacterRecord? character,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (blockKey != null) 'blockKey': blockKey,
      if (optionKey != null) 'optionKey': optionKey,
      if (selectionIndex != null) 'selectionIndex': selectionIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterStartingEquipmentSelectionRecordInclude include(
      {_i2.CharacterRecordInclude? character}) {
    return CharacterStartingEquipmentSelectionRecordInclude._(
        character: character);
  }

  static CharacterStartingEquipmentSelectionRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        orderByList,
    CharacterStartingEquipmentSelectionRecordInclude? include,
  }) {
    return CharacterStartingEquipmentSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderDescending: orderDescending,
      orderByList:
          orderByList?.call(CharacterStartingEquipmentSelectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentSelectionRecordImpl
    extends CharacterStartingEquipmentSelectionRecord {
  _CharacterStartingEquipmentSelectionRecordImpl({
    int? id,
    required int characterId,
    _i2.CharacterRecord? character,
    _i3.ChoiceSourceType? sourceType,
    int? sourceId,
    String? blockKey,
    String? optionKey,
    int? selectionIndex,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          sourceType: sourceType,
          sourceId: sourceId,
          blockKey: blockKey,
          optionKey: optionKey,
          selectionIndex: selectionIndex,
        );

  /// Returns a shallow copy of this [CharacterStartingEquipmentSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterStartingEquipmentSelectionRecord copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? blockKey = _Undefined,
    Object? optionKey = _Undefined,
    Object? selectionIndex = _Undefined,
  }) {
    return CharacterStartingEquipmentSelectionRecord(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      sourceType:
          sourceType is _i3.ChoiceSourceType? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      blockKey: blockKey is String? ? blockKey : this.blockKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      selectionIndex:
          selectionIndex is int? ? selectionIndex : this.selectionIndex,
    );
  }
}

class CharacterStartingEquipmentSelectionRecordTable extends _i1.Table<int?> {
  CharacterStartingEquipmentSelectionRecordTable({super.tableRelation})
      : super(tableName: 'character_starting_equipment_selection_data') {
    characterId = _i1.ColumnInt(
      'characterId',
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
    blockKey = _i1.ColumnString(
      'blockKey',
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
  }

  late final _i1.ColumnInt characterId;

  _i2.CharacterRecordTable? _character;

  late final _i1.ColumnEnum<_i3.ChoiceSourceType> sourceType;

  late final _i1.ColumnInt sourceId;

  late final _i1.ColumnString blockKey;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnInt selectionIndex;

  _i2.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterStartingEquipmentSelectionRecord.t.characterId,
      foreignField: _i2.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        characterId,
        sourceType,
        sourceId,
        blockKey,
        optionKey,
        selectionIndex,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'character') {
      return character;
    }
    return null;
  }
}

class CharacterStartingEquipmentSelectionRecordInclude
    extends _i1.IncludeObject {
  CharacterStartingEquipmentSelectionRecordInclude._(
      {_i2.CharacterRecordInclude? character}) {
    _character = character;
  }

  _i2.CharacterRecordInclude? _character;

  @override
  Map<String, _i1.Include?> get includes => {'character': _character};

  @override
  _i1.Table<int?> get table => CharacterStartingEquipmentSelectionRecord.t;
}

class CharacterStartingEquipmentSelectionRecordIncludeList
    extends _i1.IncludeList {
  CharacterStartingEquipmentSelectionRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterStartingEquipmentSelectionRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterStartingEquipmentSelectionRecord.t;
}

class CharacterStartingEquipmentSelectionRecordRepository {
  const CharacterStartingEquipmentSelectionRecordRepository._();

  final attachRow =
      const CharacterStartingEquipmentSelectionRecordAttachRowRepository._();

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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        orderByList,
    _i1.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
  }) async {
    return session.db.find<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList:
          orderByList?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        where,
    int? offset,
    _i1.OrderByBuilder<CharacterStartingEquipmentSelectionRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        orderByList,
    _i1.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderBy: orderBy?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderByList:
          orderByList?.call(CharacterStartingEquipmentSelectionRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterStartingEquipmentSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterStartingEquipmentSelectionRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterStartingEquipmentSelectionRecordInclude? include,
  }) async {
    return session.db.findById<CharacterStartingEquipmentSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterStartingEquipmentSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterStartingEquipmentSelectionRecord>> insert(
    _i1.Session session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterStartingEquipmentSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterStartingEquipmentSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterStartingEquipmentSelectionRecord] will have its `id` field set.
  Future<CharacterStartingEquipmentSelectionRecord> insertRow(
    _i1.Session session,
    CharacterStartingEquipmentSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterStartingEquipmentSelectionRecord>> update(
    _i1.Session session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _i1.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
        columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterStartingEquipmentSelectionRecord>(
      rows,
      columns: columns?.call(CharacterStartingEquipmentSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterStartingEquipmentSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterStartingEquipmentSelectionRecord> updateRow(
    _i1.Session session,
    CharacterStartingEquipmentSelectionRecord row, {
    _i1.ColumnSelections<CharacterStartingEquipmentSelectionRecordTable>?
        columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      columns: columns?.call(CharacterStartingEquipmentSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterStartingEquipmentSelectionRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterStartingEquipmentSelectionRecord>> delete(
    _i1.Session session,
    List<CharacterStartingEquipmentSelectionRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterStartingEquipmentSelectionRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterStartingEquipmentSelectionRecord].
  Future<CharacterStartingEquipmentSelectionRecord> deleteRow(
    _i1.Session session,
    CharacterStartingEquipmentSelectionRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterStartingEquipmentSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterStartingEquipmentSelectionRecord>> deleteWhere(
    _i1.Session session, {
    required _i1
        .WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>
        where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterStartingEquipmentSelectionRecord>(
      where: where(CharacterStartingEquipmentSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterStartingEquipmentSelectionRecordTable>?
        where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterStartingEquipmentSelectionRecord>(
      where: where?.call(CharacterStartingEquipmentSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterStartingEquipmentSelectionRecordAttachRowRepository {
  const CharacterStartingEquipmentSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterStartingEquipmentSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterStartingEquipmentSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _i1.Session session,
    CharacterStartingEquipmentSelectionRecord
        characterStartingEquipmentSelectionRecord,
    _i2.CharacterRecord character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterStartingEquipmentSelectionRecord.id == null) {
      throw ArgumentError.notNull(
          'characterStartingEquipmentSelectionRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterStartingEquipmentSelectionRecord =
        characterStartingEquipmentSelectionRecord.copyWith(
            characterId: character.id);
    await session.db.updateRow<CharacterStartingEquipmentSelectionRecord>(
      $characterStartingEquipmentSelectionRecord,
      columns: [CharacterStartingEquipmentSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }
}
