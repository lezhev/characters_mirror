/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class SpellData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SpellData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.school,
    this.castingTime,
    this.range,
    this.duration,
    this.components,
    this.concentration,
    this.ritual,
    this.higherLevel,
    this.availableForClasses,
  })  : _charactersPreparedspellsCharactersId = null,
        _charactersWrittenspellsCharactersId = null;

  factory SpellData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    String? school,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClasses,
  }) = _SpellDataImpl;

  factory SpellData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellDataImplicit._(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      level: jsonSerialization['level'] as int?,
      school: jsonSerialization['school'] as String?,
      castingTime: jsonSerialization['castingTime'] as String?,
      range: jsonSerialization['range'] as String?,
      duration: jsonSerialization['duration'] as String?,
      components: (jsonSerialization['components'] as List?)
          ?.map((e) => e as String)
          .toList(),
      concentration: jsonSerialization['concentration'] as bool?,
      ritual: jsonSerialization['ritual'] as bool?,
      higherLevel: jsonSerialization['higherLevel'] as String?,
      availableForClasses: (jsonSerialization['availableForClasses'] as List?)
          ?.map((e) => e as int)
          .toList(),
      $_charactersPreparedspellsCharactersId:
          jsonSerialization['_charactersPreparedspellsCharactersId'] as int?,
      $_charactersWrittenspellsCharactersId:
          jsonSerialization['_charactersWrittenspellsCharactersId'] as int?,
    );
  }

  static final t = SpellDataTable();

  static const db = SpellDataRepository._();

  @override
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  String? school;

  String? castingTime;

  String? range;

  String? duration;

  List<String>? components;

  bool? concentration;

  bool? ritual;

  String? higherLevel;

  List<int>? availableForClasses;

  final int? _charactersPreparedspellsCharactersId;

  final int? _charactersWrittenspellsCharactersId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    String? school,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClasses,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (school != null) 'school': school,
      if (castingTime != null) 'castingTime': castingTime,
      if (range != null) 'range': range,
      if (duration != null) 'duration': duration,
      if (components != null) 'components': components?.toJson(),
      if (concentration != null) 'concentration': concentration,
      if (ritual != null) 'ritual': ritual,
      if (higherLevel != null) 'higherLevel': higherLevel,
      if (availableForClasses != null)
        'availableForClasses': availableForClasses?.toJson(),
      if (_charactersPreparedspellsCharactersId != null)
        '_charactersPreparedspellsCharactersId':
            _charactersPreparedspellsCharactersId,
      if (_charactersWrittenspellsCharactersId != null)
        '_charactersWrittenspellsCharactersId':
            _charactersWrittenspellsCharactersId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (school != null) 'school': school,
      if (castingTime != null) 'castingTime': castingTime,
      if (range != null) 'range': range,
      if (duration != null) 'duration': duration,
      if (components != null) 'components': components?.toJson(),
      if (concentration != null) 'concentration': concentration,
      if (ritual != null) 'ritual': ritual,
      if (higherLevel != null) 'higherLevel': higherLevel,
      if (availableForClasses != null)
        'availableForClasses': availableForClasses?.toJson(),
    };
  }

  static SpellDataInclude include() {
    return SpellDataInclude._();
  }

  static SpellDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    SpellDataInclude? include,
  }) {
    return SpellDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SpellData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SpellData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellDataImpl extends SpellData {
  _SpellDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    String? school,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClasses,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          school: school,
          castingTime: castingTime,
          range: range,
          duration: duration,
          components: components,
          concentration: concentration,
          ritual: ritual,
          higherLevel: higherLevel,
          availableForClasses: availableForClasses,
        );

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? school = _Undefined,
    Object? castingTime = _Undefined,
    Object? range = _Undefined,
    Object? duration = _Undefined,
    Object? components = _Undefined,
    Object? concentration = _Undefined,
    Object? ritual = _Undefined,
    Object? higherLevel = _Undefined,
    Object? availableForClasses = _Undefined,
  }) {
    return SpellDataImplicit._(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      school: school is String? ? school : this.school,
      castingTime: castingTime is String? ? castingTime : this.castingTime,
      range: range is String? ? range : this.range,
      duration: duration is String? ? duration : this.duration,
      components: components is List<String>?
          ? components
          : this.components?.map((e0) => e0).toList(),
      concentration:
          concentration is bool? ? concentration : this.concentration,
      ritual: ritual is bool? ? ritual : this.ritual,
      higherLevel: higherLevel is String? ? higherLevel : this.higherLevel,
      availableForClasses: availableForClasses is List<int>?
          ? availableForClasses
          : this.availableForClasses?.map((e0) => e0).toList(),
      $_charactersPreparedspellsCharactersId:
          this._charactersPreparedspellsCharactersId,
      $_charactersWrittenspellsCharactersId:
          this._charactersWrittenspellsCharactersId,
    );
  }
}

class SpellDataImplicit extends _SpellDataImpl {
  SpellDataImplicit._({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    String? school,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClasses,
    int? $_charactersPreparedspellsCharactersId,
    int? $_charactersWrittenspellsCharactersId,
  })  : _charactersPreparedspellsCharactersId =
            $_charactersPreparedspellsCharactersId,
        _charactersWrittenspellsCharactersId =
            $_charactersWrittenspellsCharactersId,
        super(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          school: school,
          castingTime: castingTime,
          range: range,
          duration: duration,
          components: components,
          concentration: concentration,
          ritual: ritual,
          higherLevel: higherLevel,
          availableForClasses: availableForClasses,
        );

  factory SpellDataImplicit(
    SpellData spellData, {
    int? $_charactersPreparedspellsCharactersId,
    int? $_charactersWrittenspellsCharactersId,
  }) {
    return SpellDataImplicit._(
      id: spellData.id,
      name: spellData.name,
      description: spellData.description,
      source: spellData.source,
      version: spellData.version,
      createdAt: spellData.createdAt,
      updatedAt: spellData.updatedAt,
      level: spellData.level,
      school: spellData.school,
      castingTime: spellData.castingTime,
      range: spellData.range,
      duration: spellData.duration,
      components: spellData.components,
      concentration: spellData.concentration,
      ritual: spellData.ritual,
      higherLevel: spellData.higherLevel,
      availableForClasses: spellData.availableForClasses,
      $_charactersPreparedspellsCharactersId:
          $_charactersPreparedspellsCharactersId,
      $_charactersWrittenspellsCharactersId:
          $_charactersWrittenspellsCharactersId,
    );
  }

  @override
  final int? _charactersPreparedspellsCharactersId;

  @override
  final int? _charactersWrittenspellsCharactersId;
}

class SpellDataTable extends _i1.Table<int?> {
  SpellDataTable({super.tableRelation}) : super(tableName: 'spell_data') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
    level = _i1.ColumnInt(
      'level',
      this,
    );
    school = _i1.ColumnString(
      'school',
      this,
    );
    castingTime = _i1.ColumnString(
      'castingTime',
      this,
    );
    range = _i1.ColumnString(
      'range',
      this,
    );
    duration = _i1.ColumnString(
      'duration',
      this,
    );
    components = _i1.ColumnSerializable(
      'components',
      this,
    );
    concentration = _i1.ColumnBool(
      'concentration',
      this,
    );
    ritual = _i1.ColumnBool(
      'ritual',
      this,
    );
    higherLevel = _i1.ColumnString(
      'higherLevel',
      this,
    );
    availableForClasses = _i1.ColumnSerializable(
      'availableForClasses',
      this,
    );
    $_charactersPreparedspellsCharactersId = _i1.ColumnInt(
      '_charactersPreparedspellsCharactersId',
      this,
    );
    $_charactersWrittenspellsCharactersId = _i1.ColumnInt(
      '_charactersWrittenspellsCharactersId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt level;

  late final _i1.ColumnString school;

  late final _i1.ColumnString castingTime;

  late final _i1.ColumnString range;

  late final _i1.ColumnString duration;

  late final _i1.ColumnSerializable components;

  late final _i1.ColumnBool concentration;

  late final _i1.ColumnBool ritual;

  late final _i1.ColumnString higherLevel;

  late final _i1.ColumnSerializable availableForClasses;

  late final _i1.ColumnInt $_charactersPreparedspellsCharactersId;

  late final _i1.ColumnInt $_charactersWrittenspellsCharactersId;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        level,
        school,
        castingTime,
        range,
        duration,
        components,
        concentration,
        ritual,
        higherLevel,
        availableForClasses,
        $_charactersPreparedspellsCharactersId,
        $_charactersWrittenspellsCharactersId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        name,
        description,
        source,
        version,
        createdAt,
        updatedAt,
        level,
        school,
        castingTime,
        range,
        duration,
        components,
        concentration,
        ritual,
        higherLevel,
        availableForClasses,
      ];
}

class SpellDataInclude extends _i1.IncludeObject {
  SpellDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SpellData.t;
}

class SpellDataIncludeList extends _i1.IncludeList {
  SpellDataIncludeList._({
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SpellData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SpellData.t;
}

class SpellDataRepository {
  const SpellDataRepository._();

  /// Returns a list of [SpellData]s matching the given query parameters.
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
  Future<List<SpellData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SpellData] matching the given query parameters.
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
  Future<SpellData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpellDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpellDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SpellData>(
      where: where?.call(SpellData.t),
      orderBy: orderBy?.call(SpellData.t),
      orderByList: orderByList?.call(SpellData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SpellData] by its [id] or null if no such row exists.
  Future<SpellData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SpellData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SpellData]s in the list and returns the inserted rows.
  ///
  /// The returned [SpellData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SpellData>> insert(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SpellData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SpellData] and returns the inserted row.
  ///
  /// The returned [SpellData] will have its `id` field set.
  Future<SpellData> insertRow(
    _i1.Session session,
    SpellData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SpellData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SpellData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SpellData>> update(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.ColumnSelections<SpellDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SpellData>(
      rows,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SpellData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SpellData> updateRow(
    _i1.Session session,
    SpellData row, {
    _i1.ColumnSelections<SpellDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SpellData>(
      row,
      columns: columns?.call(SpellData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SpellData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SpellData>> delete(
    _i1.Session session,
    List<SpellData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SpellData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SpellData].
  Future<SpellData> deleteRow(
    _i1.Session session,
    SpellData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SpellData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SpellData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpellDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SpellData>(
      where: where(SpellData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpellDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SpellData>(
      where: where?.call(SpellData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
