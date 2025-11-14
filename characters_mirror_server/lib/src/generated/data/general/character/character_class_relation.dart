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

abstract class CharacterClassRelation
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterClassRelation._({
    this.id,
    required this.characterId,
    this.character,
    required this.classDataId,
    this.classData,
    required this.subclassId,
    this.subclass,
    required this.level,
    this.spellcastingProgression,
  });

  factory CharacterClassRelation({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    required int subclassId,
    _i4.SubclassData? subclass,
    required int level,
    String? spellcastingProgression,
  }) = _CharacterClassRelationImpl;

  factory CharacterClassRelation.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterClassRelation(
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
      subclassId: jsonSerialization['subclassId'] as int,
      subclass: jsonSerialization['subclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['subclass'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] as String?,
    );
  }

  static final t = CharacterClassRelationTable();

  static const db = CharacterClassRelationRepository._();

  @override
  int? id;

  int characterId;

  _i2.CharacterData? character;

  int classDataId;

  _i3.ClassData? classData;

  int subclassId;

  _i4.SubclassData? subclass;

  int level;

  String? spellcastingProgression;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterClassRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterClassRelation copyWith({
    int? id,
    int? characterId,
    _i2.CharacterData? character,
    int? classDataId,
    _i3.ClassData? classData,
    int? subclassId,
    _i4.SubclassData? subclass,
    int? level,
    String? spellcastingProgression,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'characterId': characterId,
      if (character != null) 'character': character?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJson(),
      'level': level,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression,
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
      'subclassId': subclassId,
      if (subclass != null) 'subclass': subclass?.toJsonForProtocol(),
      'level': level,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression,
    };
  }

  static CharacterClassRelationInclude include({
    _i2.CharacterDataInclude? character,
    _i3.ClassDataInclude? classData,
    _i4.SubclassDataInclude? subclass,
  }) {
    return CharacterClassRelationInclude._(
      character: character,
      classData: classData,
      subclass: subclass,
    );
  }

  static CharacterClassRelationIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterClassRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassRelationTable>? orderByList,
    CharacterClassRelationInclude? include,
  }) {
    return CharacterClassRelationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterClassRelation.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterClassRelation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterClassRelationImpl extends CharacterClassRelation {
  _CharacterClassRelationImpl({
    int? id,
    required int characterId,
    _i2.CharacterData? character,
    required int classDataId,
    _i3.ClassData? classData,
    required int subclassId,
    _i4.SubclassData? subclass,
    required int level,
    String? spellcastingProgression,
  }) : super._(
          id: id,
          characterId: characterId,
          character: character,
          classDataId: classDataId,
          classData: classData,
          subclassId: subclassId,
          subclass: subclass,
          level: level,
          spellcastingProgression: spellcastingProgression,
        );

  /// Returns a shallow copy of this [CharacterClassRelation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterClassRelation copyWith({
    Object? id = _Undefined,
    int? characterId,
    Object? character = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    int? subclassId,
    Object? subclass = _Undefined,
    int? level,
    Object? spellcastingProgression = _Undefined,
  }) {
    return CharacterClassRelation(
      id: id is int? ? id : this.id,
      characterId: characterId ?? this.characterId,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      subclassId: subclassId ?? this.subclassId,
      subclass:
          subclass is _i4.SubclassData? ? subclass : this.subclass?.copyWith(),
      level: level ?? this.level,
      spellcastingProgression: spellcastingProgression is String?
          ? spellcastingProgression
          : this.spellcastingProgression,
    );
  }
}

class CharacterClassRelationTable extends _i1.Table<int?> {
  CharacterClassRelationTable({super.tableRelation})
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
    spellcastingProgression = _i1.ColumnString(
      'spellcastingProgression',
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

  late final _i1.ColumnString spellcastingProgression;

  _i2.CharacterDataTable get character {
    if (_character != null) return _character!;
    _character = _i1.createRelationTable(
      relationFieldName: 'character',
      field: CharacterClassRelation.t.characterId,
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
      field: CharacterClassRelation.t.classDataId,
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
      field: CharacterClassRelation.t.subclassId,
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
        spellcastingProgression,
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

class CharacterClassRelationInclude extends _i1.IncludeObject {
  CharacterClassRelationInclude._({
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
  _i1.Table<int?> get table => CharacterClassRelation.t;
}

class CharacterClassRelationIncludeList extends _i1.IncludeList {
  CharacterClassRelationIncludeList._({
    _i1.WhereExpressionBuilder<CharacterClassRelationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterClassRelation.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterClassRelation.t;
}

class CharacterClassRelationRepository {
  const CharacterClassRelationRepository._();

  final attachRow = const CharacterClassRelationAttachRowRepository._();

  /// Returns a list of [CharacterClassRelation]s matching the given query parameters.
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
  Future<List<CharacterClassRelation>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassRelationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterClassRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassRelationTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassRelationInclude? include,
  }) async {
    return session.db.find<CharacterClassRelation>(
      where: where?.call(CharacterClassRelation.t),
      orderBy: orderBy?.call(CharacterClassRelation.t),
      orderByList: orderByList?.call(CharacterClassRelation.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterClassRelation] matching the given query parameters.
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
  Future<CharacterClassRelation?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassRelationTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterClassRelationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterClassRelationTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterClassRelationInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterClassRelation>(
      where: where?.call(CharacterClassRelation.t),
      orderBy: orderBy?.call(CharacterClassRelation.t),
      orderByList: orderByList?.call(CharacterClassRelation.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterClassRelation] by its [id] or null if no such row exists.
  Future<CharacterClassRelation?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterClassRelationInclude? include,
  }) async {
    return session.db.findById<CharacterClassRelation>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterClassRelation]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterClassRelation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterClassRelation>> insert(
    _i1.Session session,
    List<CharacterClassRelation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterClassRelation>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterClassRelation] and returns the inserted row.
  ///
  /// The returned [CharacterClassRelation] will have its `id` field set.
  Future<CharacterClassRelation> insertRow(
    _i1.Session session,
    CharacterClassRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterClassRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterClassRelation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterClassRelation>> update(
    _i1.Session session,
    List<CharacterClassRelation> rows, {
    _i1.ColumnSelections<CharacterClassRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterClassRelation>(
      rows,
      columns: columns?.call(CharacterClassRelation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterClassRelation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterClassRelation> updateRow(
    _i1.Session session,
    CharacterClassRelation row, {
    _i1.ColumnSelections<CharacterClassRelationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterClassRelation>(
      row,
      columns: columns?.call(CharacterClassRelation.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterClassRelation]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterClassRelation>> delete(
    _i1.Session session,
    List<CharacterClassRelation> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterClassRelation>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterClassRelation].
  Future<CharacterClassRelation> deleteRow(
    _i1.Session session,
    CharacterClassRelation row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterClassRelation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterClassRelation>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterClassRelationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterClassRelation>(
      where: where(CharacterClassRelation.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterClassRelationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterClassRelation>(
      where: where?.call(CharacterClassRelation.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterClassRelationAttachRowRepository {
  const CharacterClassRelationAttachRowRepository._();

  /// Creates a relation between the given [CharacterClassRelation] and [CharacterData]
  /// by setting the [CharacterClassRelation]'s foreign key `characterId` to refer to the [CharacterData].
  Future<void> character(
    _i1.Session session,
    CharacterClassRelation characterClassRelation,
    _i2.CharacterData character, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassRelation.id == null) {
      throw ArgumentError.notNull('characterClassRelation.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterClassRelation =
        characterClassRelation.copyWith(characterId: character.id);
    await session.db.updateRow<CharacterClassRelation>(
      $characterClassRelation,
      columns: [CharacterClassRelation.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassRelation] and [ClassData]
  /// by setting the [CharacterClassRelation]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _i1.Session session,
    CharacterClassRelation characterClassRelation,
    _i3.ClassData classData, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassRelation.id == null) {
      throw ArgumentError.notNull('characterClassRelation.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterClassRelation =
        characterClassRelation.copyWith(classDataId: classData.id);
    await session.db.updateRow<CharacterClassRelation>(
      $characterClassRelation,
      columns: [CharacterClassRelation.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterClassRelation] and [SubclassData]
  /// by setting the [CharacterClassRelation]'s foreign key `subclassId` to refer to the [SubclassData].
  Future<void> subclass(
    _i1.Session session,
    CharacterClassRelation characterClassRelation,
    _i4.SubclassData subclass, {
    _i1.Transaction? transaction,
  }) async {
    if (characterClassRelation.id == null) {
      throw ArgumentError.notNull('characterClassRelation.id');
    }
    if (subclass.id == null) {
      throw ArgumentError.notNull('subclass.id');
    }

    var $characterClassRelation =
        characterClassRelation.copyWith(subclassId: subclass.id);
    await session.db.updateRow<CharacterClassRelation>(
      $characterClassRelation,
      columns: [CharacterClassRelation.t.subclassId],
      transaction: transaction,
    );
  }
}
