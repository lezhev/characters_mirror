/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/class/prepared_spell_rule_data.dart' as _ir5j588e;
import '../../../data/general/class/subclass_data.dart' as _i6yrac43;

abstract class ClassLevelData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClassLevelData._({
    this.id,
    required this.classDataId,
    this.classData,
    this.subclassDataId,
    this.subclassData,
    required this.level,
    this.knownCantrips,
    this.knownSpells,
    this.spellbookSpells,
    this.knownSpellReplacements,
    this.preparedSpellRule,
    this.preparedSpellFormula,
    this.resourceSummary,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassLevelData({
    int? id,
    required int classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassDataId,
    _i6yrac43.SubclassData? subclassData,
    required int level,
    int? knownCantrips,
    int? knownSpells,
    int? spellbookSpells,
    int? knownSpellReplacements,
    _ir5j588e.PreparedSpellRuleData? preparedSpellRule,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassLevelDataImpl;

  factory ClassLevelData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassLevelData(
      id: jsonSerialization['id'] as int?,
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['classData'],
            ),
      subclassDataId: jsonSerialization['subclassDataId'] as int?,
      subclassData: jsonSerialization['subclassData'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i6yrac43.SubclassData>(
              jsonSerialization['subclassData'],
            ),
      level: jsonSerialization['level'] as int,
      knownCantrips: jsonSerialization['knownCantrips'] as int?,
      knownSpells: jsonSerialization['knownSpells'] as int?,
      spellbookSpells: jsonSerialization['spellbookSpells'] as int?,
      knownSpellReplacements:
          jsonSerialization['knownSpellReplacements'] as int?,
      preparedSpellRule: jsonSerialization['preparedSpellRule'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ir5j588e.PreparedSpellRuleData>(
              jsonSerialization['preparedSpellRule'],
            ),
      preparedSpellFormula:
          jsonSerialization['preparedSpellFormula'] as String?,
      resourceSummary: jsonSerialization['resourceSummary'] as String?,
      notes: jsonSerialization['notes'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int classDataId;

  _i7s9vfyh.ClassData? classData;

  int? subclassDataId;

  _i6yrac43.SubclassData? subclassData;

  int level;

  int? knownCantrips;

  int? knownSpells;

  int? spellbookSpells;

  int? knownSpellReplacements;

  _ir5j588e.PreparedSpellRuleData? preparedSpellRule;

  String? preparedSpellFormula;

  String? resourceSummary;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClassLevelData copyWith({
    int? id,
    int? classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassDataId,
    _i6yrac43.SubclassData? subclassData,
    int? level,
    int? knownCantrips,
    int? knownSpells,
    int? spellbookSpells,
    int? knownSpellReplacements,
    _ir5j588e.PreparedSpellRuleData? preparedSpellRule,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassLevelData',
      if (id != null) 'id': id,
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      if (subclassDataId != null) 'subclassDataId': subclassDataId,
      if (subclassData != null) 'subclassData': subclassData?.toJson(),
      'level': level,
      if (knownCantrips != null) 'knownCantrips': knownCantrips,
      if (knownSpells != null) 'knownSpells': knownSpells,
      if (spellbookSpells != null) 'spellbookSpells': spellbookSpells,
      if (knownSpellReplacements != null)
        'knownSpellReplacements': knownSpellReplacements,
      if (preparedSpellRule != null)
        'preparedSpellRule': preparedSpellRule?.toJson(),
      if (preparedSpellFormula != null)
        'preparedSpellFormula': preparedSpellFormula,
      if (resourceSummary != null) 'resourceSummary': resourceSummary,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassLevelData',
      if (id != null) 'id': id,
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJsonForProtocol(),
      if (subclassDataId != null) 'subclassDataId': subclassDataId,
      if (subclassData != null)
        'subclassData': subclassData?.toJsonForProtocol(),
      'level': level,
      if (knownCantrips != null) 'knownCantrips': knownCantrips,
      if (knownSpells != null) 'knownSpells': knownSpells,
      if (spellbookSpells != null) 'spellbookSpells': spellbookSpells,
      if (knownSpellReplacements != null)
        'knownSpellReplacements': knownSpellReplacements,
      if (preparedSpellRule != null)
        'preparedSpellRule': preparedSpellRule?.toJsonForProtocol(),
      if (preparedSpellFormula != null)
        'preparedSpellFormula': preparedSpellFormula,
      if (resourceSummary != null) 'resourceSummary': resourceSummary,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassLevelDataImpl extends ClassLevelData {
  _ClassLevelDataImpl({
    int? id,
    required int classDataId,
    _i7s9vfyh.ClassData? classData,
    int? subclassDataId,
    _i6yrac43.SubclassData? subclassData,
    required int level,
    int? knownCantrips,
    int? knownSpells,
    int? spellbookSpells,
    int? knownSpellReplacements,
    _ir5j588e.PreparedSpellRuleData? preparedSpellRule,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         classDataId: classDataId,
         classData: classData,
         subclassDataId: subclassDataId,
         subclassData: subclassData,
         level: level,
         knownCantrips: knownCantrips,
         knownSpells: knownSpells,
         spellbookSpells: spellbookSpells,
         knownSpellReplacements: knownSpellReplacements,
         preparedSpellRule: preparedSpellRule,
         preparedSpellFormula: preparedSpellFormula,
         resourceSummary: resourceSummary,
         notes: notes,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClassLevelData copyWith({
    Object? id = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    Object? subclassDataId = _Undefined,
    Object? subclassData = _Undefined,
    int? level,
    Object? knownCantrips = _Undefined,
    Object? knownSpells = _Undefined,
    Object? spellbookSpells = _Undefined,
    Object? knownSpellReplacements = _Undefined,
    Object? preparedSpellRule = _Undefined,
    Object? preparedSpellFormula = _Undefined,
    Object? resourceSummary = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassLevelData(
      id: id is int? ? id : this.id,
      classDataId: classDataId ?? this.classDataId,
      classData: classData is _i7s9vfyh.ClassData?
          ? classData
          : this.classData?.copyWith(),
      subclassDataId: subclassDataId is int?
          ? subclassDataId
          : this.subclassDataId,
      subclassData: subclassData is _i6yrac43.SubclassData?
          ? subclassData
          : this.subclassData?.copyWith(),
      level: level ?? this.level,
      knownCantrips: knownCantrips is int? ? knownCantrips : this.knownCantrips,
      knownSpells: knownSpells is int? ? knownSpells : this.knownSpells,
      spellbookSpells: spellbookSpells is int?
          ? spellbookSpells
          : this.spellbookSpells,
      knownSpellReplacements: knownSpellReplacements is int?
          ? knownSpellReplacements
          : this.knownSpellReplacements,
      preparedSpellRule: preparedSpellRule is _ir5j588e.PreparedSpellRuleData?
          ? preparedSpellRule
          : this.preparedSpellRule?.copyWith(),
      preparedSpellFormula: preparedSpellFormula is String?
          ? preparedSpellFormula
          : this.preparedSpellFormula,
      resourceSummary: resourceSummary is String?
          ? resourceSummary
          : this.resourceSummary,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
