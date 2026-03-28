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
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../data/general/class/subclass_data.dart' as _i4;
import '../../../enums/hit_point_mode.dart' as _i5;

abstract class CharacterClassEntryData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterClassEntryData._({
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

  factory CharacterClassEntryData({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
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
  }) = _CharacterClassEntryDataImpl;

  factory CharacterClassEntryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassEntryData(
      id: jsonSerialization['id'] as int?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
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
          : _i5.HitPointMode.fromJson((jsonSerialization['hpMode'] as int)),
      hpRolledValues: (jsonSerialization['hpRolledValues'] as List?)
          ?.map((e) => e as int)
          .toList(),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = CharacterClassEntryDataTable();

  static const db = CharacterClassEntryDataRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterData? character;

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

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassEntryData copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
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
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJsonForProtocol(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (subclassId != null) 'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJsonForProtocol(),
      'level': level,
      if (isStartingClass != null) 'isStartingClass': isStartingClass,
      if (classOrder != null) 'classOrder': classOrder,
      if (hpMode != null) 'hpMode': hpMode?.toJson(),
      if (hpRolledValues != null) 'hpRolledValues': hpRolledValues?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  static CharacterClassEntryDataInclude include({
    _i2.CharacterDataInclude? character,
    _i3.ClassDataInclude? classData,
    _i4.SubclassDataInclude? subclass,
  }) {
    return CharacterClassEntryDataInclude._(
      character: character,
      classData: classData,
      subclass: subclass,
    );
  }

  static CharacterClassEntryDataIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterClassEntryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryDataTable>? orderByList,
    CharacterClassEntryDataInclude? include,
  }) {
    return CharacterClassEntryDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterClassEntryData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterClassEntryData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassEntryDataImpl extends CharacterClassEntryData {
  _CharacterClassEntryDataImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
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

  /// Returns a shallow copy of this [CharacterClassEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterClassEntryData copyWith({
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
    return CharacterClassEntryData(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
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

class CharacterClassEntryDataTable extends _i1.Table<int?> {
  CharacterClassEntryDataTable({super.tableRelation})
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
      _i1.EnumSerialization.byIndex,
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

  _i2.CharacterDataTable? _character;

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

  _i2.CharacterDataTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterClassEntryData.t.characterId,
      foreignField: _i2.CharacterData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.CharacterDataTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _i3.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _i1.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterClassEntryData.t.classDataId,
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
      field: CharacterClassEntryData.t.subclassId,
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

class CharacterClassEntryDataInclude extends _i1.IncludeObject {
  CharacterClassEntryDataInclude._({
    _i2.CharacterDataInclude? character,
    _i3.ClassDataInclude? classData,
    _i4.SubclassDataInclude? subclass,
  }) {
    _character = character;
    _classData = classData;
    _subclass = subclass;
  }

  _i2.CharacterDataInclude? _character;

  _i3.ClassDataInclude? _classData;

  _i4.SubclassDataInclude? _subclass;

  @override
  Map<String, _i1.Include?> get includes => {
        'character': _character,
        'classData': _classData,
        'subclass': _subclass,
      };

  @override
  _i1.Table<int?> get table => CharacterClassEntryData.t;
}

class CharacterClassEntryDataIncludeList extends _i1.IncludeList {
  CharacterClassEntryDataIncludeList._({
    _i1.WhereExpressionBuilder<CharacterClassEntryDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterClassEntryData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterClassEntryData.t;
}

class CharacterClassEntryDataRepository {
  const CharacterClassEntryDataRepository._();

  final attachRow = const CharacterClassEntryDataAttachRowRepository._();

  final detachRow = const CharacterClassEntryDataDetachRowRepository._();

  /// Returns a list of [CharacterClassEntryData]s matching the given query parameters.
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
  Future<List<CharacterClassEntryData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassEntryDataInclude? include,
  }) async {
    return session.db.find<CharacterClassEntryData>(
      where: where?.call(CharacterClassEntryData.t),
      orderBy: orderBy?.call(CharacterClassEntryData.t),
      orderByList: orderByList?.call(CharacterClassEntryData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterClassEntryData] matching the given query parameters.
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
  Future<CharacterClassEntryData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterClassEntryDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassEntryDataTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassEntryDataInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterClassEntryData>(
      where: where?.call(CharacterClassEntryData.t),
      orderBy: orderBy?.call(CharacterClassEntryData.t),
      orderByList: orderByList?.call(CharacterClassEntryData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterClassEntryData] by its [id] or null if no such row exists.
  Future<CharacterClassEntryData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterClassEntryDataInclude? include,
  }) async {
    return session.db.findById<CharacterClassEntryData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterClassEntryData]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterClassEntryData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterClassEntryData>> insert(
    _i1.Session session,
    List<CharacterClassEntryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterClassEntryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterClassEntryData] and returns the inserted row.
  ///
  /// The returned [CharacterClassEntryData] will have its `id` field set.
  Future<CharacterClassEntryData> insertRow(
    _i1.Session session,
    CharacterClassEntryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterClassEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterClassEntryData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterClassEntryData>> update(
    _i1.Session session,
    List<CharacterClassEntryData> rows, {
    _i1.ColumnSelections<CharacterClassEntryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterClassEntryData>(
      rows,
      columns: columns?.call(CharacterClassEntryData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterClassEntryData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterClassEntryData> updateRow(
    _i1.Session session,
    CharacterClassEntryData row, {
    _i1.ColumnSelections<CharacterClassEntryDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterClassEntryData>(
      row,
      columns: columns?.call(CharacterClassEntryData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterClassEntryData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterClassEntryData>> delete(
    _i1.Session session,
    List<CharacterClassEntryData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterClassEntryData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterClassEntryData].
  Future<CharacterClassEntryData> deleteRow(
    _i1.Session session,
    CharacterClassEntryData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterClassEntryData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterClassEntryData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterClassEntryDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterClassEntryData>(
      where: where(CharacterClassEntryData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassEntryDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterClassEntryData>(
      where: where?.call(CharacterClassEntryData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterClassEntryDataAttachRowRepository {
  const CharacterClassEntryDataAttachRowRepository._();

  /// Creates a relation between the given [CharacterClassEntryData] and [CharacterData]
  /// by setting the [CharacterClassEntryData]'s foreign key `characterId` to refer to the [CharacterData].
  Future<void> character(
    _i1.Session session,
    CharacterClassEntryData characterClassEntryData,
    _i2.CharacterData character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryData.id == null) {
      throw ArgumentError.notNull('characterClassEntryData.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterClassEntryData =
        characterClassEntryData.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterClassEntryData>(
      $characterClassEntryData,
      columns: [CharacterClassEntryData.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryData] and [ClassData]
  /// by setting the [CharacterClassEntryData]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    CharacterClassEntryData characterClassEntryData,
    _i3.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryData.id == null) {
      throw ArgumentError.notNull('characterClassEntryData.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterClassEntryData =
        characterClassEntryData.copyWith(classDataId: classData.id);
    await session.db.updateRow<CharacterClassEntryData>(
      $characterClassEntryData,
      columns: [CharacterClassEntryData.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassEntryData] and [SubclassData]
  /// by setting the [CharacterClassEntryData]'s foreign key `subclassId` to refer to the [SubclassData].
  Future<void> subclass(
    _i1.Session session,
    CharacterClassEntryData characterClassEntryData,
    _i4.SubclassData subclass, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassEntryData.id == null) {
      throw ArgumentError.notNull('characterClassEntryData.id');
    }
    if (subclass.id == null) {
      throw ArgumentError.notNull('subclass.id');
    }

    var $characterClassEntryData =
        characterClassEntryData.copyWith(subclassId: subclass.id);
    await session.db.updateRow<CharacterClassEntryData>(
      $characterClassEntryData,
      columns: [CharacterClassEntryData.t.subclassId],
      transaction: transaction,
    );
  }
}

class CharacterClassEntryDataDetachRowRepository {
  const CharacterClassEntryDataDetachRowRepository._();

  /// Detaches the relation between this [CharacterClassEntryData] and the [SubclassData] set in `subclass`
  /// by setting the [CharacterClassEntryData]'s foreign key `subclassId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclass(
    _i1.Session session,
    CharacterClassEntryData characterclassentrydata, {
    _i1.Transaction? transaction,
  }) async {
    if (characterclassentrydata.id == null) {
      throw ArgumentError.notNull('characterclassentrydata.id');
    }

    var $characterclassentrydata =
        characterclassentrydata.copyWith(subclassId: null);
    await session.db.updateRow<CharacterClassEntryData>(
      $characterclassentrydata,
      columns: [CharacterClassEntryData.t.subclassId],
      transaction: transaction,
    );
  }
}
