/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../enums/character_alignment.dart' as _i2;
import '../../../data/general/race/race_data.dart' as _i3;
import '../../../data/general/race/subrace_data.dart' as _i4;
import '../../../data/background_data.dart' as _i5;

abstract class CharacterData implements _i1.SerializableModel {
  CharacterData._({
    this.id,
    this.name,
    this.age,
    this.height,
    this.weight,
    this.eyes,
    this.skin,
    this.hair,
    this.appearance,
    this.backstory,
    this.goals,
    this.alliesOrganizations,
    this.personalityTraits,
    this.ideals,
    this.bonds,
    this.flaws,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.experience,
    this.alignmentValue,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.backgroundId,
    this.background,
    this.baseAbilityScores,
    this.temporaryHp,
    this.currentHp,
    this.inspiration,
    this.notes,
  });

  factory CharacterData({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    int? raceId,
    _i3.RaceData? race,
    int? subraceId,
    _i4.SubraceData? subrace,
    int? backgroundId,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    String? notes,
  }) = _CharacterDataImpl;

  factory CharacterData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      age: jsonSerialization['age'] as String?,
      height: jsonSerialization['height'] as String?,
      weight: jsonSerialization['weight'] as String?,
      eyes: jsonSerialization['eyes'] as String?,
      skin: jsonSerialization['skin'] as String?,
      hair: jsonSerialization['hair'] as String?,
      appearance: jsonSerialization['appearance'] as String?,
      backstory: jsonSerialization['backstory'] as String?,
      goals: jsonSerialization['goals'] as String?,
      alliesOrganizations: jsonSerialization['alliesOrganizations'] as String?,
      personalityTraits: jsonSerialization['personalityTraits'] as String?,
      ideals: jsonSerialization['ideals'] as String?,
      bonds: jsonSerialization['bonds'] as String?,
      flaws: jsonSerialization['flaws'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      userId: jsonSerialization['userId'] as int?,
      experience: jsonSerialization['experience'] as int?,
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _i2.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String)),
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _i3.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i4.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      backgroundId: jsonSerialization['backgroundId'] as int?,
      background: jsonSerialization['background'] == null
          ? null
          : _i5.BackgroundData.fromJson(
              (jsonSerialization['background'] as Map<String, dynamic>)),
      baseAbilityScores: (jsonSerialization['baseAbilityScores'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      inspiration: jsonSerialization['inspiration'] as bool?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  String? age;

  String? height;

  String? weight;

  String? eyes;

  String? skin;

  String? hair;

  String? appearance;

  String? backstory;

  String? goals;

  String? alliesOrganizations;

  String? personalityTraits;

  String? ideals;

  String? bonds;

  String? flaws;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? userId;

  int? experience;

  _i2.CharacterAlignment? alignmentValue;

  int? raceId;

  _i3.RaceData? race;

  int? subraceId;

  _i4.SubraceData? subrace;

  int? backgroundId;

  _i5.BackgroundData? background;

  Map<String, int>? baseAbilityScores;

  int? temporaryHp;

  int? currentHp;

  bool? inspiration;

  String? notes;

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterData copyWith({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    int? raceId,
    _i3.RaceData? race,
    int? subraceId,
    _i4.SubraceData? subrace,
    int? backgroundId,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (eyes != null) 'eyes': eyes,
      if (skin != null) 'skin': skin,
      if (hair != null) 'hair': hair,
      if (appearance != null) 'appearance': appearance,
      if (backstory != null) 'backstory': backstory,
      if (goals != null) 'goals': goals,
      if (alliesOrganizations != null)
        'alliesOrganizations': alliesOrganizations,
      if (personalityTraits != null) 'personalityTraits': personalityTraits,
      if (ideals != null) 'ideals': ideals,
      if (bonds != null) 'bonds': bonds,
      if (flaws != null) 'flaws': flaws,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (userId != null) 'userId': userId,
      if (experience != null) 'experience': experience,
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (backgroundId != null) 'backgroundId': backgroundId,
      if (background != null) 'background': background?.toJson(),
      if (baseAbilityScores != null)
        'baseAbilityScores': baseAbilityScores?.toJson(),
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (inspiration != null) 'inspiration': inspiration,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDataImpl extends CharacterData {
  _CharacterDataImpl({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    int? raceId,
    _i3.RaceData? race,
    int? subraceId,
    _i4.SubraceData? subrace,
    int? backgroundId,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    String? notes,
  }) : super._(
          id: id,
          name: name,
          age: age,
          height: height,
          weight: weight,
          eyes: eyes,
          skin: skin,
          hair: hair,
          appearance: appearance,
          backstory: backstory,
          goals: goals,
          alliesOrganizations: alliesOrganizations,
          personalityTraits: personalityTraits,
          ideals: ideals,
          bonds: bonds,
          flaws: flaws,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          userId: userId,
          experience: experience,
          alignmentValue: alignmentValue,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          backgroundId: backgroundId,
          background: background,
          baseAbilityScores: baseAbilityScores,
          temporaryHp: temporaryHp,
          currentHp: currentHp,
          inspiration: inspiration,
          notes: notes,
        );

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? age = _Undefined,
    Object? height = _Undefined,
    Object? weight = _Undefined,
    Object? eyes = _Undefined,
    Object? skin = _Undefined,
    Object? hair = _Undefined,
    Object? appearance = _Undefined,
    Object? backstory = _Undefined,
    Object? goals = _Undefined,
    Object? alliesOrganizations = _Undefined,
    Object? personalityTraits = _Undefined,
    Object? ideals = _Undefined,
    Object? bonds = _Undefined,
    Object? flaws = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? userId = _Undefined,
    Object? experience = _Undefined,
    Object? alignmentValue = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? backgroundId = _Undefined,
    Object? background = _Undefined,
    Object? baseAbilityScores = _Undefined,
    Object? temporaryHp = _Undefined,
    Object? currentHp = _Undefined,
    Object? inspiration = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CharacterData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      age: age is String? ? age : this.age,
      height: height is String? ? height : this.height,
      weight: weight is String? ? weight : this.weight,
      eyes: eyes is String? ? eyes : this.eyes,
      skin: skin is String? ? skin : this.skin,
      hair: hair is String? ? hair : this.hair,
      appearance: appearance is String? ? appearance : this.appearance,
      backstory: backstory is String? ? backstory : this.backstory,
      goals: goals is String? ? goals : this.goals,
      alliesOrganizations: alliesOrganizations is String?
          ? alliesOrganizations
          : this.alliesOrganizations,
      personalityTraits: personalityTraits is String?
          ? personalityTraits
          : this.personalityTraits,
      ideals: ideals is String? ? ideals : this.ideals,
      bonds: bonds is String? ? bonds : this.bonds,
      flaws: flaws is String? ? flaws : this.flaws,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      userId: userId is int? ? userId : this.userId,
      experience: experience is int? ? experience : this.experience,
      alignmentValue: alignmentValue is _i2.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i3.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i4.SubraceData? ? subrace : this.subrace?.copyWith(),
      backgroundId: backgroundId is int? ? backgroundId : this.backgroundId,
      background: background is _i5.BackgroundData?
          ? background
          : this.background?.copyWith(),
      baseAbilityScores: baseAbilityScores is Map<String, int>?
          ? baseAbilityScores
          : this.baseAbilityScores?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      temporaryHp: temporaryHp is int? ? temporaryHp : this.temporaryHp,
      currentHp: currentHp is int? ? currentHp : this.currentHp,
      inspiration: inspiration is bool? ? inspiration : this.inspiration,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
