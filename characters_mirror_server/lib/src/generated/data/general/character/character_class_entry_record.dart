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
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../data/general/class/subclass_data.dart' as _i4;
import '../../../enums/hit_point_mode.dart' as _i5;

abstract class CharacterClassEntryRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterClassEntryRecord._({
    this.id,
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
  });

  factory CharacterClassEntryRecord({
    int? id,
    required int characterId,
    _i2.CharacterRecord? character,
    required int classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) = _CharacterClassEntryRecordImpl;

  factory CharacterClassEntryRecord.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassEntryRecord(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterRecord.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      subclassId: jsonSerialization['subclassId'] as int?,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      isStartingClass: jsonSerialization['isStartingClass'] as bool?,
      classOrder: jsonSerialization['classOrder'] as int?,
      hpMode: jsonSerialization['hpMode'] == null
          ? null
          : _i5.HitPointMode.fromJson((jsonSerialization['hpMode'] as String)),
      hpRolledValues: (jsonSerialization['hpRolledValues'] as List?)
          ?.map((e) => e as int)
          .toList(),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = CharacterClassEntryRecordTable();

  static const db = CharacterClassEntryRecordRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterRecord? character;

  int classDataId;

  _i3.ClassData? classData;

  int? subclassId;

  _i4.SubclassData? subclass;

  int level;

  bool? isStartingClass;

  int? classOrder;

  _i5.HitPointMode? hpMode;

  List<int>? hpRolledValues;

  String? notes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterClassEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassEntryRecord copyWith({
    int? id,
    int? characterId,
    _i2.CharacterRecord? character,
    int? classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    int? level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
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
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterClassEntryRecordInclude include({
    _i2.CharacterRecordInclude? character,
    _i3.ClassDataInclude? classData,
    _i4.SubclassDataInclude? subclass,
  }) {
    return CharacterClassEntryRecordInclude._(
      character: character,
      classData: classData,
      subclass: subclass,
    );
  }

  static CharacterClassEntryRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    CharacterClassEntryRecordInclude? include,
  }) {
    return CharacterClassEntryRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassEntryRecordImpl extends CharacterClassEntryRecord {
  _CharacterClassEntryRecordImpl({
    int? id,
    required int characterId,
    _i2.CharacterRecord? character,
    required int classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    required int level,
    bool? isStartingClass,
    int? classOrder,
    _i5.HitPointMode? hpMode,
    List<int>? hpRolledValues,
    String? notes,
  }) : super._(
          id: id,
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
        );

  /// Returns a shallow copy of this [CharacterClassEntryRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterClassEntryRecord copyWith({
    Object? id = _Undefined,
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
  }) {
    return CharacterClassEntryRecord(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      subclassId: subclassId is int? ? subclassId : this.subclassId,
      subclass:
          subclass is _i4.SubclassData? ? subclass : this.subclass?.copyWith(),
      level: level ?? this.level,
      isStartingClass:
          isStartingClass is bool? ? isStartingClass : this.isStartingClass,
      classOrder: classOrder is int? ? classOrder : this.classOrder,
      hpMode: hpMode is _i5.HitPointMode? ? hpMode : this.hpMode,
      hpRolledValues: hpRolledValues is List<int>?
          ? hpRolledValues
          : this.hpRolledValues?.map((e0) => e0).toList(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class CharacterClassEntryRecordTable extends _i1.Table<int?> {
  CharacterClassEntryRecordTable({super.tableRelation})
      : super(tableName: 'character_class_relation') {
    characterId = _i1.ColumnInt(
      'characterId',
      this,
    );
    classDataId = _i1.ColumnInt(
      'classDataId',
      this,
    );
    subclassId = _i1.ColumnInt(
      'subclassId',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    isStartingClass = _i1.ColumnBool(
      'isStartingClass',
      this,
    );
    classOrder = _i1.ColumnInt(
      'classOrder',
      this,
    );
    hpMode = _i1.ColumnEnum(
      'hpMode',
      this,
      _i1.EnumSerialization.byName,
    );
    hpRolledValues = _i1.ColumnSerializable(
      'hpRolledValues',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final _i1.ColumnInt characterId;

  _i2.CharacterRecordTable? _character;

  late final _i1.ColumnInt classDataId;

  _i3.ClassDataTable? _classData;

  late final _i1.ColumnInt subclassId;

  _i4.SubclassDataTable? _subclass;

  late final _i1.ColumnInt level;

  late final _i1.ColumnBool isStartingClass;

  late final _i1.ColumnInt classOrder;

  late final _i1.ColumnEnum<_i5.HitPointMode> hpMode;

  late final _i1.ColumnSerializable hpRolledValues;

  late final _i1.ColumnString notes;

  _i2.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterClassEntryRecord.t.characterId,
      foreignField: _i2.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i3.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _i1.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterClassEntryRecord.t.classDataId,
      foreignField: _i3.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _i4.SubclassDataTable get subclass {
    if (_subclass != null) return _subclass!;
    _subclass = _i1.createRelationTable(
      relationFieldName: 'subclass',
      field: CharacterClassEntryRecord.t.subclassId,
      foreignField: _i4.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _subclass!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        characterId,
        classDataId,
        subclassId,
        level,
        isStartingClass,
        classOrder,
        hpMode,
        hpRolledValues,
        notes,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
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

class CharacterClassEntryRecordInclude extends _i1.IncludeObject {
  CharacterClassEntryRecordInclude._({
    _i2.CharacterRecordInclude? character,
    _i3.ClassDataInclude? classData,
    _i4.SubclassDataInclude? subclass,
  }) {
    _character = character;
    _classData = classData;
    _subclass = subclass;
  }

  _i2.CharacterRecordInclude? _character;

  _i3.ClassDataInclude? _classData;

  _i4.SubclassDataInclude? _subclass;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classData': _classData,
        'subclass': _subclass,
      };

  @override
  _i1.Table<int?> get table => CharacterClassEntryRecord.t;
}

class CharacterClassEntryRecordIncludeList extends _i1.IncludeList {
  CharacterClassEntryRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterClassEntryRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterClassEntryRecord.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
  }) async {
    return session.db.find<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      orderBy: orderBy?.call(CharacterClassEntryRecord.t),
      orderByList: orderByList?.call(CharacterClassEntryRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterClassEntryRecord] by its [id] or null if no such row exists.
  Future<CharacterClassEntryRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterClassEntryRecordInclude? include,
  }) async {
    return session.db.findById<CharacterClassEntryRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterClassEntryRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterClassEntryRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterClassEntryRecord>> insert(
    _i1.Session session,
    List<CharacterClassEntryRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterClassEntryRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterClassEntryRecord] and returns the inserted row.
  ///
  /// The returned [CharacterClassEntryRecord] will have its `id` field set.
  Future<CharacterClassEntryRecord> insertRow(
    _i1.Session session,
    CharacterClassEntryRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterClassEntryRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterClassEntryRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterClassEntryRecord>> update(
    _i1.Session session,
    List<CharacterClassEntryRecord> rows, {
    _i1.ColumnSelections<CharacterClassEntryRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterClassEntryRecord>(
      rows,
      columns: columns?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterClassEntryRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterClassEntryRecord> updateRow(
    _i1.Session session,
    CharacterClassEntryRecord row, {
    _i1.ColumnSelections<CharacterClassEntryRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterClassEntryRecord>(
      row,
      columns: columns?.call(CharacterClassEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterClassEntryRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterClassEntryRecord>> delete(
    _i1.Session session,
    List<CharacterClassEntryRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterClassEntryRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterClassEntryRecord].
  Future<CharacterClassEntryRecord> deleteRow(
    _i1.Session session,
    CharacterClassEntryRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterClassEntryRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterClassEntryRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterClassEntryRecord>(
      where: where(CharacterClassEntryRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterClassEntryRecord>(
      where: where?.call(CharacterClassEntryRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterClassEntryRecordAttachRowRepository {
  const CharacterClassEntryRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterClassEntryRecord] and [CharacterRecord]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _i1.Session session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i2.CharacterRecord character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterClassEntryRecord =
        characterClassEntryRecord.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryRecord] and [ClassData]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i3.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterClassEntryRecord =
        characterClassEntryRecord.copyWith(classDataId: classData.id);
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterClassEntryRecord,
      columns: [CharacterClassEntryRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryRecord] and [SubclassData]
  /// by setting the [CharacterClassEntryRecord]'s foreign key `subclassId` to refer to the [SubclassData].
  Future<void> subclass(
    _i1.Session session,
    CharacterClassEntryRecord characterClassEntryRecord,
    _i4.SubclassData subclass, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryRecord.id == null) {
      throw ArgumentError.notNull('characterClassEntryRecord.id');
    }
    if (subclass.id == null) {
      throw ArgumentError.notNull('subclass.id');
    }

    var $characterClassEntryRecord =
        characterClassEntryRecord.copyWith(subclassId: subclass.id);
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
    _i1.Session session,
    CharacterClassEntryRecord characterclassentryrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterclassentryrecord.id == null) {
      throw ArgumentError.notNull('characterclassentryrecord.id');
    }

    var $characterclassentryrecord =
        characterclassentryrecord.copyWith(subclassId: null);
    await session.db.updateRow<CharacterClassEntryRecord>(
      $characterclassentryrecord,
      columns: [CharacterClassEntryRecord.t.subclassId],
      transaction: transaction,
    );
  }
}
