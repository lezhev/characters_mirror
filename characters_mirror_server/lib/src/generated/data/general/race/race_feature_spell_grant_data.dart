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
import '../../../data/general/race/race_feature_data.dart' as _i2;
import '../../../data/spell_data.dart' as _i3;
import '../../../enums/ability.dart' as _i4;
import '../../../enums/rest_type.dart' as _i5;

abstract class RaceFeatureSpellGrantData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  RaceFeatureSpellGrantData._({
    this.id,
    required this.featureId,
    this.feature,
    required this.spellId,
    this.spell,
    this.grantedAtLevel,
    this.castingAbility,
    this.freeCastsPerRest,
    this.freeCastsFormula,
    this.castAtSpellLevel,
    this.canAlsoCastWithSpellSlots,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  }) : _raceFeatureDataSpellgrantsRaceFeatureDataId = null;

  factory RaceFeatureSpellGrantData({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    required int spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceFeatureSpellGrantDataImpl;

  factory RaceFeatureSpellGrantData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return RaceFeatureSpellGrantDataImplicit._(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i2.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i3.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _i4.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String)),
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _i5.RestType.fromJson(
              (jsonSerialization['freeCastsPerRest'] as String)),
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      canAlsoCastWithSpellSlots:
          jsonSerialization['canAlsoCastWithSpellSlots'] as bool?,
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      $_raceFeatureDataSpellgrantsRaceFeatureDataId:
          jsonSerialization['_raceFeatureDataSpellgrantsRaceFeatureDataId']
              as int?,
    );
  }

  static final t = RaceFeatureSpellGrantDataTable();

  static const db = RaceFeatureSpellGrantDataRepository._();

  @override
  int? id;

  int featureId;

  _i2.RaceFeatureData? feature;

  int spellId;

  _i3.SpellData? spell;

  int? grantedAtLevel;

  _i4.Ability? castingAbility;

  _i5.RestType? freeCastsPerRest;

  String? freeCastsFormula;

  int? castAtSpellLevel;

  bool? canAlsoCastWithSpellSlots;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  final int? _raceFeatureDataSpellgrantsRaceFeatureDataId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceFeatureSpellGrantData copyWith({
    int? id,
    int? featureId,
    _i2.RaceFeatureData? feature,
    int? spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (canAlsoCastWithSpellSlots != null)
        'canAlsoCastWithSpellSlots': canAlsoCastWithSpellSlots,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (_raceFeatureDataSpellgrantsRaceFeatureDataId != null)
        '_raceFeatureDataSpellgrantsRaceFeatureDataId':
            _raceFeatureDataSpellgrantsRaceFeatureDataId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJsonForProtocol(),
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (canAlsoCastWithSpellSlots != null)
        'canAlsoCastWithSpellSlots': canAlsoCastWithSpellSlots,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  static RaceFeatureSpellGrantDataInclude include({
    _i2.RaceFeatureDataInclude? feature,
    _i3.SpellDataInclude? spell,
  }) {
    return RaceFeatureSpellGrantDataInclude._(
      feature: feature,
      spell: spell,
    );
  }

  static RaceFeatureSpellGrantDataIncludeList includeList({
    _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    RaceFeatureSpellGrantDataInclude? include,
  }) {
    return RaceFeatureSpellGrantDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceFeatureSpellGrantDataImpl extends RaceFeatureSpellGrantData {
  _RaceFeatureSpellGrantDataImpl({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    required int spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          featureId: featureId,
          feature: feature,
          spellId: spellId,
          spell: spell,
          grantedAtLevel: grantedAtLevel,
          castingAbility: castingAbility,
          freeCastsPerRest: freeCastsPerRest,
          freeCastsFormula: freeCastsFormula,
          castAtSpellLevel: castAtSpellLevel,
          canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceFeatureSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceFeatureSpellGrantData copyWith({
    Object? id = _Undefined,
    int? featureId,
    Object? feature = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? castingAbility = _Undefined,
    Object? freeCastsPerRest = _Undefined,
    Object? freeCastsFormula = _Undefined,
    Object? castAtSpellLevel = _Undefined,
    Object? canAlsoCastWithSpellSlots = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceFeatureSpellGrantDataImplicit._(
      id: id is int? ? id : this.id,
      featureId: featureId ?? this.featureId,
      feature:
          feature is _i2.RaceFeatureData? ? feature : this.feature?.copyWith(),
      spellId: spellId ?? this.spellId,
      spell: spell is _i3.SpellData? ? spell : this.spell?.copyWith(),
      grantedAtLevel:
          grantedAtLevel is int? ? grantedAtLevel : this.grantedAtLevel,
      castingAbility:
          castingAbility is _i4.Ability? ? castingAbility : this.castingAbility,
      freeCastsPerRest: freeCastsPerRest is _i5.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      castAtSpellLevel:
          castAtSpellLevel is int? ? castAtSpellLevel : this.castAtSpellLevel,
      canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots is bool?
          ? canAlsoCastWithSpellSlots
          : this.canAlsoCastWithSpellSlots,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      $_raceFeatureDataSpellgrantsRaceFeatureDataId:
          this._raceFeatureDataSpellgrantsRaceFeatureDataId,
    );
  }
}

class RaceFeatureSpellGrantDataImplicit extends _RaceFeatureSpellGrantDataImpl {
  RaceFeatureSpellGrantDataImplicit._({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    required int spellId,
    _i3.SpellData? spell,
    int? grantedAtLevel,
    _i4.Ability? castingAbility,
    _i5.RestType? freeCastsPerRest,
    String? freeCastsFormula,
    int? castAtSpellLevel,
    bool? canAlsoCastWithSpellSlots,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? $_raceFeatureDataSpellgrantsRaceFeatureDataId,
  })  : _raceFeatureDataSpellgrantsRaceFeatureDataId =
            $_raceFeatureDataSpellgrantsRaceFeatureDataId,
        super(
          id: id,
          featureId: featureId,
          feature: feature,
          spellId: spellId,
          spell: spell,
          grantedAtLevel: grantedAtLevel,
          castingAbility: castingAbility,
          freeCastsPerRest: freeCastsPerRest,
          freeCastsFormula: freeCastsFormula,
          castAtSpellLevel: castAtSpellLevel,
          canAlsoCastWithSpellSlots: canAlsoCastWithSpellSlots,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory RaceFeatureSpellGrantDataImplicit(
    RaceFeatureSpellGrantData raceFeatureSpellGrantData, {
    int? $_raceFeatureDataSpellgrantsRaceFeatureDataId,
  }) {
    return RaceFeatureSpellGrantDataImplicit._(
      id: raceFeatureSpellGrantData.id,
      featureId: raceFeatureSpellGrantData.featureId,
      feature: raceFeatureSpellGrantData.feature,
      spellId: raceFeatureSpellGrantData.spellId,
      spell: raceFeatureSpellGrantData.spell,
      grantedAtLevel: raceFeatureSpellGrantData.grantedAtLevel,
      castingAbility: raceFeatureSpellGrantData.castingAbility,
      freeCastsPerRest: raceFeatureSpellGrantData.freeCastsPerRest,
      freeCastsFormula: raceFeatureSpellGrantData.freeCastsFormula,
      castAtSpellLevel: raceFeatureSpellGrantData.castAtSpellLevel,
      canAlsoCastWithSpellSlots:
          raceFeatureSpellGrantData.canAlsoCastWithSpellSlots,
      notes: raceFeatureSpellGrantData.notes,
      source: raceFeatureSpellGrantData.source,
      version: raceFeatureSpellGrantData.version,
      createdAt: raceFeatureSpellGrantData.createdAt,
      updatedAt: raceFeatureSpellGrantData.updatedAt,
      $_raceFeatureDataSpellgrantsRaceFeatureDataId:
          $_raceFeatureDataSpellgrantsRaceFeatureDataId,
    );
  }

  @override
  final int? _raceFeatureDataSpellgrantsRaceFeatureDataId;
}

class RaceFeatureSpellGrantDataTable extends _i1.Table<int?> {
  RaceFeatureSpellGrantDataTable({super.tableRelation})
      : super(tableName: 'race_feature_spell_grant_data') {
    featureId = _i1.ColumnInt(
      'featureId',
      this,
    );
    spellId = _i1.ColumnInt(
      'spellId',
      this,
    );
    grantedAtLevel = _i1.ColumnInt(
      'grantedAtLevel',
      this,
    );
    castingAbility = _i1.ColumnEnum(
      'castingAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    freeCastsPerRest = _i1.ColumnEnum(
      'freeCastsPerRest',
      this,
      _i1.EnumSerialization.byName,
    );
    freeCastsFormula = _i1.ColumnString(
      'freeCastsFormula',
      this,
    );
    castAtSpellLevel = _i1.ColumnInt(
      'castAtSpellLevel',
      this,
    );
    canAlsoCastWithSpellSlots = _i1.ColumnBool(
      'canAlsoCastWithSpellSlots',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
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
    $_raceFeatureDataSpellgrantsRaceFeatureDataId = _i1.ColumnInt(
      '_raceFeatureDataSpellgrantsRaceFeatureDataId',
      this,
    );
  }

  late final _i1.ColumnInt featureId;

  _i2.RaceFeatureDataTable? _feature;

  late final _i1.ColumnInt spellId;

  _i3.SpellDataTable? _spell;

  late final _i1.ColumnInt grantedAtLevel;

  late final _i1.ColumnEnum<_i4.Ability> castingAbility;

  late final _i1.ColumnEnum<_i5.RestType> freeCastsPerRest;

  late final _i1.ColumnString freeCastsFormula;

  late final _i1.ColumnInt castAtSpellLevel;

  late final _i1.ColumnBool canAlsoCastWithSpellSlots;

  late final _i1.ColumnString notes;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt $_raceFeatureDataSpellgrantsRaceFeatureDataId;

  _i2.RaceFeatureDataTable get feature {
    if (_feature != null) return _feature!;
    _feature = _i1.createRelationTable(
      relationFieldName: 'feature',
      field: RaceFeatureSpellGrantData.t.featureId,
      foreignField: _i2.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _feature!;
  }

  _i3.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _i1.createRelationTable(
      relationFieldName: 'spell',
      field: RaceFeatureSpellGrantData.t.spellId,
      foreignField: _i3.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        featureId,
        spellId,
        grantedAtLevel,
        castingAbility,
        freeCastsPerRest,
        freeCastsFormula,
        castAtSpellLevel,
        canAlsoCastWithSpellSlots,
        notes,
        source,
        version,
        createdAt,
        updatedAt,
        $_raceFeatureDataSpellgrantsRaceFeatureDataId,
      ];

  @override
  List<_i1.Column> get managedColumns => [
        id,
        featureId,
        spellId,
        grantedAtLevel,
        castingAbility,
        freeCastsPerRest,
        freeCastsFormula,
        castAtSpellLevel,
        canAlsoCastWithSpellSlots,
        notes,
        source,
        version,
        createdAt,
        updatedAt,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'feature') {
      return feature;
    }
    if (relationField == 'spell') {
      return spell;
    }
    return null;
  }
}

class RaceFeatureSpellGrantDataInclude extends _i1.IncludeObject {
  RaceFeatureSpellGrantDataInclude._({
    _i2.RaceFeatureDataInclude? feature,
    _i3.SpellDataInclude? spell,
  }) {
    _feature = feature;
    _spell = spell;
  }

  _i2.RaceFeatureDataInclude? _feature;

  _i3.SpellDataInclude? _spell;

  @override
  Map<String, _i1.Include?> get includes => {
        'feature': _feature,
        'spell': _spell,
      };

  @override
  _i1.Table<int?> get table => RaceFeatureSpellGrantData.t;
}

class RaceFeatureSpellGrantDataIncludeList extends _i1.IncludeList {
  RaceFeatureSpellGrantDataIncludeList._({
    _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RaceFeatureSpellGrantData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => RaceFeatureSpellGrantData.t;
}

class RaceFeatureSpellGrantDataRepository {
  const RaceFeatureSpellGrantDataRepository._();

  final attachRow = const RaceFeatureSpellGrantDataAttachRowRepository._();

  /// Returns a list of [RaceFeatureSpellGrantData]s matching the given query parameters.
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
  Future<List<RaceFeatureSpellGrantData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
  }) async {
    return session.db.find<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [RaceFeatureSpellGrantData] matching the given query parameters.
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
  Future<RaceFeatureSpellGrantData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<RaceFeatureSpellGrantDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RaceFeatureSpellGrantDataTable>? orderByList,
    _i1.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
  }) async {
    return session.db.findFirstRow<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      orderBy: orderBy?.call(RaceFeatureSpellGrantData.t),
      orderByList: orderByList?.call(RaceFeatureSpellGrantData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [RaceFeatureSpellGrantData] by its [id] or null if no such row exists.
  Future<RaceFeatureSpellGrantData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    RaceFeatureSpellGrantDataInclude? include,
  }) async {
    return session.db.findById<RaceFeatureSpellGrantData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [RaceFeatureSpellGrantData]s in the list and returns the inserted rows.
  ///
  /// The returned [RaceFeatureSpellGrantData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<RaceFeatureSpellGrantData>> insert(
    _i1.Session session,
    List<RaceFeatureSpellGrantData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<RaceFeatureSpellGrantData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [RaceFeatureSpellGrantData] and returns the inserted row.
  ///
  /// The returned [RaceFeatureSpellGrantData] will have its `id` field set.
  Future<RaceFeatureSpellGrantData> insertRow(
    _i1.Session session,
    RaceFeatureSpellGrantData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<RaceFeatureSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [RaceFeatureSpellGrantData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<RaceFeatureSpellGrantData>> update(
    _i1.Session session,
    List<RaceFeatureSpellGrantData> rows, {
    _i1.ColumnSelections<RaceFeatureSpellGrantDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<RaceFeatureSpellGrantData>(
      rows,
      columns: columns?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RaceFeatureSpellGrantData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RaceFeatureSpellGrantData> updateRow(
    _i1.Session session,
    RaceFeatureSpellGrantData row, {
    _i1.ColumnSelections<RaceFeatureSpellGrantDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<RaceFeatureSpellGrantData>(
      row,
      columns: columns?.call(RaceFeatureSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [RaceFeatureSpellGrantData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<RaceFeatureSpellGrantData>> delete(
    _i1.Session session,
    List<RaceFeatureSpellGrantData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<RaceFeatureSpellGrantData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [RaceFeatureSpellGrantData].
  Future<RaceFeatureSpellGrantData> deleteRow(
    _i1.Session session,
    RaceFeatureSpellGrantData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RaceFeatureSpellGrantData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<RaceFeatureSpellGrantData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<RaceFeatureSpellGrantData>(
      where: where(RaceFeatureSpellGrantData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RaceFeatureSpellGrantDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<RaceFeatureSpellGrantData>(
      where: where?.call(RaceFeatureSpellGrantData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class RaceFeatureSpellGrantDataAttachRowRepository {
  const RaceFeatureSpellGrantDataAttachRowRepository._();

  /// Creates a relation between the given [RaceFeatureSpellGrantData] and [RaceFeatureData]
  /// by setting the [RaceFeatureSpellGrantData]'s foreign key `featureId` to refer to the [RaceFeatureData].
  Future<void> feature(
    _i1.Session session,
    RaceFeatureSpellGrantData raceFeatureSpellGrantData,
    _i2.RaceFeatureData feature, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.id == null) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (feature.id == null) {
      throw ArgumentError.notNull('feature.id');
    }

    var $raceFeatureSpellGrantData =
        raceFeatureSpellGrantData.copyWith(featureId: feature.id);
    await session.db.updateRow<RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [RaceFeatureSpellGrantData.t.featureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [RaceFeatureSpellGrantData] and [SpellData]
  /// by setting the [RaceFeatureSpellGrantData]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _i1.Session session,
    RaceFeatureSpellGrantData raceFeatureSpellGrantData,
    _i3.SpellData spell, {
    _i1.Transaction? transaction,
  }) async {
    if (raceFeatureSpellGrantData.id == null) {
      throw ArgumentError.notNull('raceFeatureSpellGrantData.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $raceFeatureSpellGrantData =
        raceFeatureSpellGrantData.copyWith(spellId: spell.id);
    await session.db.updateRow<RaceFeatureSpellGrantData>(
      $raceFeatureSpellGrantData,
      columns: [RaceFeatureSpellGrantData.t.spellId],
      transaction: transaction,
    );
  }
}
