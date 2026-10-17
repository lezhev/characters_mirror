/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/character/character_class_entry_record.dart'
    as _igs591f3;
import '../../../data/general/character/character_record.dart' as _i50rgqfs;
import '../../../data/general/character/spell_selection_replacement_history_data.dart'
    as _iks8679o;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;
import '../../../data/spell_data.dart' as _isenpj1r;
import '../../../enums/character_spell_selection_kind.dart' as _ioezer4n;

abstract class CharacterSpellSelectionRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    this.selectionFilter,
    this.selectionRuleLevel,
    this.selectionUnrestricted,
    this.spellReplacementHistory,
    this.updatedAt,
  });

  factory CharacterSpellSelectionRecord({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? spellId,
    _isenpj1r.SpellData? spell,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
    DateTime? updatedAt,
  }) = _CharacterSpellSelectionRecordImpl;

  factory CharacterSpellSelectionRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSpellSelectionRecord(
      id: jsonSerialization['id'] as int?,
      syncId: jsonSerialization['syncId'] as String?,
      characterId: jsonSerialization['characterId'] as int,
      character: jsonSerialization['character'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i50rgqfs.CharacterRecord>(
              jsonSerialization['character'],
            ),
      classEntryId: jsonSerialization['classEntryId'] as int?,
      classEntry: jsonSerialization['classEntry'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_igs591f3.CharacterClassEntryRecord>(
                  jsonSerialization['classEntry'],
                ),
      classDataId: jsonSerialization['classDataId'] as int?,
      classData: jsonSerialization['classData'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['classData'],
            ),
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_isenpj1r.SpellData>(
              jsonSerialization['spell'],
            ),
      spellKey: jsonSerialization['spellKey'] as String?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _ioezer4n.CharacterSpellSelectionKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      selectionIndex: jsonSerialization['selectionIndex'] as int?,
      selectionFilter: jsonSerialization['selectionFilter'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iv73j5oi.SpellSelectionFilterData>(
                  jsonSerialization['selectionFilter'],
                ),
      selectionRuleLevel: jsonSerialization['selectionRuleLevel'] as int?,
      selectionUnrestricted: jsonSerialization['selectionUnrestricted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['selectionUnrestricted'],
            ),
      spellReplacementHistory:
          jsonSerialization['spellReplacementHistory'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              List<_iks8679o.SpellSelectionReplacementHistoryData>
            >(jsonSerialization['spellReplacementHistory']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CharacterSpellSelectionRecordTable();

  static const db = CharacterSpellSelectionRecordRepository._();

  @override
  int? id;

  String? syncId;

  int characterId;

  _i50rgqfs.CharacterRecord? character;

  int? classEntryId;

  _igs591f3.CharacterClassEntryRecord? classEntry;

  int? classDataId;

  _i7s9vfyh.ClassData? classData;

  int? spellId;

  _isenpj1r.SpellData? spell;

  String? spellKey;

  _ioezer4n.CharacterSpellSelectionKind? kind;

  int? selectionIndex;

  _iv73j5oi.SpellSelectionFilterData? selectionFilter;

  int? selectionRuleLevel;

  bool? selectionUnrestricted;

  List<_iks8679o.SpellSelectionReplacementHistoryData>? spellReplacementHistory;

  DateTime? updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterSpellSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSpellSelectionRecord copyWith({
    int? id,
    String? syncId,
    int? characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? spellId,
    _isenpj1r.SpellData? spell,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSpellSelectionRecord',
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
      if (selectionFilter != null) 'selectionFilter': selectionFilter?.toJson(),
      if (selectionRuleLevel != null) 'selectionRuleLevel': selectionRuleLevel,
      if (selectionUnrestricted != null)
        'selectionUnrestricted': selectionUnrestricted,
      if (spellReplacementHistory != null)
        'spellReplacementHistory': spellReplacementHistory?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterSpellSelectionRecordInclude include({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
    _i7s9vfyh.ClassDataInclude? classData,
    _isenpj1r.SpellDataInclude? spell,
  }) {
    return CharacterSpellSelectionRecordInclude._(
      character: character,
      classEntry: classEntry,
      classData: classData,
      spell: spell,
    );
  }

  static CharacterSpellSelectionRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    CharacterSpellSelectionRecordInclude? include,
  }) {
    return CharacterSpellSelectionRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSpellSelectionRecordImpl extends CharacterSpellSelectionRecord {
  _CharacterSpellSelectionRecordImpl({
    int? id,
    String? syncId,
    required int characterId,
    _i50rgqfs.CharacterRecord? character,
    int? classEntryId,
    _igs591f3.CharacterClassEntryRecord? classEntry,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? spellId,
    _isenpj1r.SpellData? spell,
    String? spellKey,
    _ioezer4n.CharacterSpellSelectionKind? kind,
    int? selectionIndex,
    _iv73j5oi.SpellSelectionFilterData? selectionFilter,
    int? selectionRuleLevel,
    bool? selectionUnrestricted,
    List<_iks8679o.SpellSelectionReplacementHistoryData>?
    spellReplacementHistory,
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
         selectionFilter: selectionFilter,
         selectionRuleLevel: selectionRuleLevel,
         selectionUnrestricted: selectionUnrestricted,
         spellReplacementHistory: spellReplacementHistory,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterSpellSelectionRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? selectionFilter = _Undefined,
    Object? selectionRuleLevel = _Undefined,
    Object? selectionUnrestricted = _Undefined,
    Object? spellReplacementHistory = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterSpellSelectionRecord(
      id: id is int? ? id : this.id,
      syncId: syncId is String? ? syncId : this.syncId,
      characterId: characterId ?? this.characterId,
      character: character is _i50rgqfs.CharacterRecord?
          ? character
          : this.character?.copyWith(),
      classEntryId: classEntryId is int? ? classEntryId : this.classEntryId,
      classEntry: classEntry is _igs591f3.CharacterClassEntryRecord?
          ? classEntry
          : this.classEntry?.copyWith(),
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      classData: classData is _i7s9vfyh.ClassData?
          ? classData
          : this.classData?.copyWith(),
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _isenpj1r.SpellData? ? spell : this.spell?.copyWith(),
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      kind: kind is _ioezer4n.CharacterSpellSelectionKind? ? kind : this.kind,
      selectionIndex: selectionIndex is int?
          ? selectionIndex
          : this.selectionIndex,
      selectionFilter: selectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? selectionFilter
          : this.selectionFilter?.copyWith(),
      selectionRuleLevel: selectionRuleLevel is int?
          ? selectionRuleLevel
          : this.selectionRuleLevel,
      selectionUnrestricted: selectionUnrestricted is bool?
          ? selectionUnrestricted
          : this.selectionUnrestricted,
      spellReplacementHistory:
          spellReplacementHistory
              is List<_iks8679o.SpellSelectionReplacementHistoryData>?
          ? spellReplacementHistory
          : this.spellReplacementHistory?.map((e0) => e0.copyWith()).toList(),
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class CharacterSpellSelectionRecordUpdateTable
    extends _is.UpdateTable<CharacterSpellSelectionRecordTable> {
  CharacterSpellSelectionRecordUpdateTable(super.table);

  _is.ColumnValue<String, String> syncId(String? value) =>
      _is.ColumnValue(table.syncId, value);

  _is.ColumnValue<int, int> characterId(int value) =>
      _is.ColumnValue(table.characterId, value);

  _is.ColumnValue<int, int> classEntryId(int? value) =>
      _is.ColumnValue(table.classEntryId, value);

  _is.ColumnValue<int, int> classDataId(int? value) =>
      _is.ColumnValue(table.classDataId, value);

  _is.ColumnValue<int, int> spellId(int? value) =>
      _is.ColumnValue(table.spellId, value);

  _is.ColumnValue<String, String> spellKey(String? value) =>
      _is.ColumnValue(table.spellKey, value);

  _is.ColumnValue<
    _ioezer4n.CharacterSpellSelectionKind,
    _ioezer4n.CharacterSpellSelectionKind
  >
  kind(_ioezer4n.CharacterSpellSelectionKind? value) =>
      _is.ColumnValue(table.kind, value);

  _is.ColumnValue<int, int> selectionIndex(int? value) =>
      _is.ColumnValue(table.selectionIndex, value);

  _is.ColumnValue<
    _iv73j5oi.SpellSelectionFilterData,
    _iv73j5oi.SpellSelectionFilterData
  >
  selectionFilter(_iv73j5oi.SpellSelectionFilterData? value) =>
      _is.ColumnValue(table.selectionFilter, value);

  _is.ColumnValue<int, int> selectionRuleLevel(int? value) =>
      _is.ColumnValue(table.selectionRuleLevel, value);

  _is.ColumnValue<bool, bool> selectionUnrestricted(bool? value) =>
      _is.ColumnValue(table.selectionUnrestricted, value);

  _is.ColumnValue<
    List<_iks8679o.SpellSelectionReplacementHistoryData>,
    List<_iks8679o.SpellSelectionReplacementHistoryData>
  >
  spellReplacementHistory(
    List<_iks8679o.SpellSelectionReplacementHistoryData>? value,
  ) => _is.ColumnValue(table.spellReplacementHistory, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class CharacterSpellSelectionRecordTable extends _is.Table<int?> {
  CharacterSpellSelectionRecordTable({super.tableRelation})
    : super(tableName: 'character_spell_selection_data') {
    updateTable = CharacterSpellSelectionRecordUpdateTable(this);
    syncId = _is.ColumnString('syncId', this);
    characterId = _is.ColumnInt('characterId', this);
    classEntryId = _is.ColumnInt('classEntryId', this);
    classDataId = _is.ColumnInt('classDataId', this);
    spellId = _is.ColumnInt('spellId', this);
    spellKey = _is.ColumnString('spellKey', this);
    kind = _is.ColumnEnum('kind', this, _is.EnumSerialization.byName);
    selectionIndex = _is.ColumnInt('selectionIndex', this);
    selectionFilter =
        _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>(
          'selectionFilter',
          this,
        );
    selectionRuleLevel = _is.ColumnInt('selectionRuleLevel', this);
    selectionUnrestricted = _is.ColumnBool('selectionUnrestricted', this);
    spellReplacementHistory =
        _is.ColumnSerializable<
          List<_iks8679o.SpellSelectionReplacementHistoryData>
        >('spellReplacementHistory', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final CharacterSpellSelectionRecordUpdateTable updateTable;

  late final _is.ColumnString syncId;

  late final _is.ColumnInt characterId;

  _i50rgqfs.CharacterRecordTable? _character;

  late final _is.ColumnInt classEntryId;

  _igs591f3.CharacterClassEntryRecordTable? _classEntry;

  late final _is.ColumnInt classDataId;

  _i7s9vfyh.ClassDataTable? _classData;

  late final _is.ColumnInt spellId;

  _isenpj1r.SpellDataTable? _spell;

  late final _is.ColumnString spellKey;

  late final _is.ColumnEnum<_ioezer4n.CharacterSpellSelectionKind> kind;

  late final _is.ColumnInt selectionIndex;

  late final _is.ColumnSerializable<_iv73j5oi.SpellSelectionFilterData>
  selectionFilter;

  late final _is.ColumnInt selectionRuleLevel;

  late final _is.ColumnBool selectionUnrestricted;

  late final _is.ColumnSerializable<
    List<_iks8679o.SpellSelectionReplacementHistoryData>
  >
  spellReplacementHistory;

  late final _is.ColumnDateTime updatedAt;

  _i50rgqfs.CharacterRecordTable get character {
    if (_character != null) return _character!;
    _character = _is.createRelationTable(
      relationFieldName: 'character',
      field: CharacterSpellSelectionRecord.t.characterId,
      foreignField: _i50rgqfs.CharacterRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i50rgqfs.CharacterRecordTable(tableRelation: foreignTableRelation),
    );
    return _character!;
  }

  _igs591f3.CharacterClassEntryRecordTable get classEntry {
    if (_classEntry != null) return _classEntry!;
    _classEntry = _is.createRelationTable(
      relationFieldName: 'classEntry',
      field: CharacterSpellSelectionRecord.t.classEntryId,
      foreignField: _igs591f3.CharacterClassEntryRecord.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _igs591f3.CharacterClassEntryRecordTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return _classEntry!;
  }

  _i7s9vfyh.ClassDataTable get classData {
    if (_classData != null) return _classData!;
    _classData = _is.createRelationTable(
      relationFieldName: 'classData',
      field: CharacterSpellSelectionRecord.t.classDataId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _classData!;
  }

  _isenpj1r.SpellDataTable get spell {
    if (_spell != null) return _spell!;
    _spell = _is.createRelationTable(
      relationFieldName: 'spell',
      field: CharacterSpellSelectionRecord.t.spellId,
      foreignField: _isenpj1r.SpellData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isenpj1r.SpellDataTable(tableRelation: foreignTableRelation),
    );
    return _spell!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    syncId,
    characterId,
    classEntryId,
    classDataId,
    spellId,
    spellKey,
    kind,
    selectionIndex,
    selectionFilter,
    selectionRuleLevel,
    selectionUnrestricted,
    spellReplacementHistory,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
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

class CharacterSpellSelectionRecordInclude extends _is.IncludeObject {
  CharacterSpellSelectionRecordInclude._({
    _i50rgqfs.CharacterRecordInclude? character,
    _igs591f3.CharacterClassEntryRecordInclude? classEntry,
    _i7s9vfyh.ClassDataInclude? classData,
    _isenpj1r.SpellDataInclude? spell,
  }) {
    _character = character;
    _classEntry = classEntry;
    _classData = classData;
    _spell = spell;
  }

  _i50rgqfs.CharacterRecordInclude? _character;

  _igs591f3.CharacterClassEntryRecordInclude? _classEntry;

  _i7s9vfyh.ClassDataInclude? _classData;

  _isenpj1r.SpellDataInclude? _spell;

  @override
  Map<String, _is.Include?> get includes => {
    'character': _character,
    'classEntry': _classEntry,
    'classData': _classData,
    'spell': _spell,
  };

  @override
  _is.Table<int?> get table => CharacterSpellSelectionRecord.t;
}

class CharacterSpellSelectionRecordIncludeList extends _is.IncludeList {
  CharacterSpellSelectionRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterSpellSelectionRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterSpellSelectionRecord.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterSpellSelectionRecord] by its [id] or null if no such row exists.
  Future<CharacterSpellSelectionRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterSpellSelectionRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterSpellSelectionRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterSpellSelectionRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterSpellSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterSpellSelectionRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterSpellSelectionRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterSpellSelectionRecord] and returns the inserted row.
  ///
  /// The returned [CharacterSpellSelectionRecord] will have its `id` field set.
  Future<CharacterSpellSelectionRecord> insertRow(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterSpellSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CharacterSpellSelectionRecord]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [CharacterSpellSelectionRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterSpellSelectionRecord> rows, {
    required _is.ColumnSelections<CharacterSpellSelectionRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSpellSelectionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterSpellSelectionRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterSpellSelectionRecord.t),
      updateColumns: updateColumns?.call(CharacterSpellSelectionRecord.t),
      updateWhere: updateWhere?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterSpellSelectionRecord] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [CharacterSpellSelectionRecord] will have its `id` field set.
  Future<CharacterSpellSelectionRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord row, {
    required _is.ColumnSelections<CharacterSpellSelectionRecordTable>
    conflictColumns,
    _is.ColumnSelections<CharacterSpellSelectionRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterSpellSelectionRecord>(
      row,
      conflictColumns: conflictColumns(CharacterSpellSelectionRecord.t),
      updateColumns: updateColumns?.call(CharacterSpellSelectionRecord.t),
      updateWhere: updateWhere?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSpellSelectionRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> update(
    _is.DatabaseSession session,
    List<CharacterSpellSelectionRecord> rows, {
    _is.ColumnSelections<CharacterSpellSelectionRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterSpellSelectionRecord>(
      rows,
      columns: columns?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterSpellSelectionRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterSpellSelectionRecord> updateRow(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord row, {
    _is.ColumnSelections<CharacterSpellSelectionRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterSpellSelectionRecord>(
      row,
      columns: columns?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterSpellSelectionRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterSpellSelectionRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<
      CharacterSpellSelectionRecordUpdateTable
    >
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterSpellSelectionRecord>(
      id,
      columnValues: columnValues(CharacterSpellSelectionRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterSpellSelectionRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<
      CharacterSpellSelectionRecordUpdateTable
    >
    columnValues,
    required _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>
    where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterSpellSelectionRecord>(
      columnValues: columnValues(CharacterSpellSelectionRecord.t.updateTable),
      where: where(CharacterSpellSelectionRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterSpellSelectionRecord]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterSpellSelectionRecord> rows, {
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterSpellSelectionRecord>(
      rows,
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterSpellSelectionRecord].
  Future<CharacterSpellSelectionRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterSpellSelectionRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterSpellSelectionRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>
    where,
    _is.OrderByBuilder<CharacterSpellSelectionRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterSpellSelectionRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterSpellSelectionRecord>(
      where: where(CharacterSpellSelectionRecord.t),
      orderBy: orderBy?.call(CharacterSpellSelectionRecord.t),
      orderByList: orderByList?.call(CharacterSpellSelectionRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterSpellSelectionRecord>(
      where: where?.call(CharacterSpellSelectionRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterSpellSelectionRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterSpellSelectionRecordTable>
    where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterSpellSelectionRecord>(
      where: where(CharacterSpellSelectionRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterSpellSelectionRecordAttachRowRepository {
  const CharacterSpellSelectionRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [CharacterRecord]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `characterId` to refer to the [CharacterRecord].
  Future<void> character(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i50rgqfs.CharacterRecord character, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (character.id == null) {
      throw ArgumentError.notNull('character.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      characterId: character.id,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.characterId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [CharacterClassEntryRecord]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classEntryId` to refer to the [CharacterClassEntryRecord].
  Future<void> classEntry(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _igs591f3.CharacterClassEntryRecord classEntry, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (classEntry.id == null) {
      throw ArgumentError.notNull('classEntry.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      classEntryId: classEntry.id,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.classEntryId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [ClassData]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `classDataId` to refer to the [ClassData].
  Future<void> classData(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _i7s9vfyh.ClassData classData, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (classData.id == null) {
      throw ArgumentError.notNull('classData.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      classDataId: classData.id,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.classDataId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterSpellSelectionRecord] and [SpellData]
  /// by setting the [CharacterSpellSelectionRecord]'s foreign key `spellId` to refer to the [SpellData].
  Future<void> spell(
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord,
    _isenpj1r.SpellData spell, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }
    if (spell.id == null) {
      throw ArgumentError.notNull('spell.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      spellId: spell.id,
    );
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
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      classEntryId: null,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
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
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      classDataId: null,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
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
    _is.DatabaseSession session,
    CharacterSpellSelectionRecord characterSpellSelectionRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterSpellSelectionRecord.id == null) {
      throw ArgumentError.notNull('characterSpellSelectionRecord.id');
    }

    var $characterSpellSelectionRecord = characterSpellSelectionRecord.copyWith(
      spellId: null,
    );
    await session.db.updateRow<CharacterSpellSelectionRecord>(
      $characterSpellSelectionRecord,
      columns: [CharacterSpellSelectionRecord.t.spellId],
      transaction: transaction,
    );
  }
}
