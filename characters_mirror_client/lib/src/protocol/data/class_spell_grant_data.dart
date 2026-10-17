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
import '../data/general/choice_option_data.dart' as _ivap0b5b;
import '../data/general/class/class_data.dart' as _iazz3r73;
import '../data/general/class/class_feature_data.dart' as _ikfzlvib;
import '../data/general/class/subclass_data.dart' as _ijcb6jld;
import '../data/general/class/subclass_feature_data.dart' as _itaxdcfb;
import '../data/general/spell_activation_data.dart' as _iyix4imv;
import '../data/spell_data.dart' as _iavpgfjb;
import '../enums/ability.dart' as _i26h74c2;

abstract class ClassSpellGrantData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClassSpellGrantData._({
    this.id,
    this.spellId,
    this.spell,
    this.spellReferenceKey,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    this.grantedAtLevel,
    this.activation,
    this.castingAbility,
    this.alwaysPrepared,
    this.choiceOptionId,
    this.choiceOption,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassSpellGrantData({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassSpellGrantDataImpl;

  factory ClassSpellGrantData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassSpellGrantData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iavpgfjb.SpellData>(
              jsonSerialization['spell'],
            ),
      spellReferenceKey: jsonSerialization['spellReferenceKey'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iazz3r73.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ijcb6jld.SubclassData>(
              jsonSerialization['sourceSubclass'],
            ),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ikfzlvib.ClassFeatureData>(
              jsonSerialization['sourceFeature'],
            ),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_itaxdcfb.SubclassFeatureData>(
              jsonSerialization['sourceSubclassFeature'],
            ),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      activation: jsonSerialization['activation'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iyix4imv.SpellActivationData>(
              jsonSerialization['activation'],
            ),
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _i26h74c2.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String),
            ),
      alwaysPrepared: jsonSerialization['alwaysPrepared'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['alwaysPrepared'],
            ),
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_ivap0b5b.ChoiceOptionData>(
              jsonSerialization['choiceOption'],
            ),
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

  int? spellId;

  _iavpgfjb.SpellData? spell;

  String? spellReferenceKey;

  int? sourceClassId;

  _iazz3r73.ClassData? sourceClass;

  int? sourceSubclassId;

  _ijcb6jld.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _ikfzlvib.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _itaxdcfb.SubclassFeatureData? sourceSubclassFeature;

  int? grantedAtLevel;

  _iyix4imv.SpellActivationData? activation;

  _i26h74c2.Ability? castingAbility;

  bool? alwaysPrepared;

  int? choiceOptionId;

  _ivap0b5b.ChoiceOptionData? choiceOption;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClassSpellGrantData copyWith({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassSpellGrantData',
      if (id != null) 'id': id,
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJson(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null) 'choiceOption': choiceOption?.toJson(),
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
      '__className__': 'ClassSpellGrantData',
      if (id != null) 'id': id,
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJsonForProtocol(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null)
        'sourceSubclass': sourceSubclass?.toJsonForProtocol(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null)
        'sourceFeature': sourceFeature?.toJsonForProtocol(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJsonForProtocol(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (activation != null) 'activation': activation?.toJsonForProtocol(),
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null)
        'choiceOption': choiceOption?.toJsonForProtocol(),
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

class _ClassSpellGrantDataImpl extends ClassSpellGrantData {
  _ClassSpellGrantDataImpl({
    int? id,
    int? spellId,
    _iavpgfjb.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _iazz3r73.ClassData? sourceClass,
    int? sourceSubclassId,
    _ijcb6jld.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _ikfzlvib.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _itaxdcfb.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    _iyix4imv.SpellActivationData? activation,
    _i26h74c2.Ability? castingAbility,
    bool? alwaysPrepared,
    int? choiceOptionId,
    _ivap0b5b.ChoiceOptionData? choiceOption,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         spellId: spellId,
         spell: spell,
         spellReferenceKey: spellReferenceKey,
         sourceClassId: sourceClassId,
         sourceClass: sourceClass,
         sourceSubclassId: sourceSubclassId,
         sourceSubclass: sourceSubclass,
         sourceFeatureId: sourceFeatureId,
         sourceFeature: sourceFeature,
         sourceSubclassFeatureId: sourceSubclassFeatureId,
         sourceSubclassFeature: sourceSubclassFeature,
         grantedAtLevel: grantedAtLevel,
         activation: activation,
         castingAbility: castingAbility,
         alwaysPrepared: alwaysPrepared,
         choiceOptionId: choiceOptionId,
         choiceOption: choiceOption,
         notes: notes,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClassSpellGrantData copyWith({
    Object? id = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? spellReferenceKey = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? activation = _Undefined,
    Object? castingAbility = _Undefined,
    Object? alwaysPrepared = _Undefined,
    Object? choiceOptionId = _Undefined,
    Object? choiceOption = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassSpellGrantData(
      id: id is int? ? id : this.id,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _iavpgfjb.SpellData? ? spell : this.spell?.copyWith(),
      spellReferenceKey: spellReferenceKey is String?
          ? spellReferenceKey
          : this.spellReferenceKey,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _iazz3r73.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId: sourceSubclassId is int?
          ? sourceSubclassId
          : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _ijcb6jld.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId: sourceFeatureId is int?
          ? sourceFeatureId
          : this.sourceFeatureId,
      sourceFeature: sourceFeature is _ikfzlvib.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature:
          sourceSubclassFeature is _itaxdcfb.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      grantedAtLevel: grantedAtLevel is int?
          ? grantedAtLevel
          : this.grantedAtLevel,
      activation: activation is _iyix4imv.SpellActivationData?
          ? activation
          : this.activation?.copyWith(),
      castingAbility: castingAbility is _i26h74c2.Ability?
          ? castingAbility
          : this.castingAbility,
      alwaysPrepared: alwaysPrepared is bool?
          ? alwaysPrepared
          : this.alwaysPrepared,
      choiceOptionId: choiceOptionId is int?
          ? choiceOptionId
          : this.choiceOptionId,
      choiceOption: choiceOption is _ivap0b5b.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
