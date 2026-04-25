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
import '../../../enums/character_alignment.dart' as _i2;
import '../../../data/general/race/race_data.dart' as _i3;
import '../../../data/general/race/subrace_data.dart' as _i4;
import '../../../data/background_data.dart' as _i5;
import '../../../data/general/character/character_inventory_item_data.dart'
    as _i6;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i7;
import '../../../enums/ability.dart' as _i8;
import '../../../data/general/character/character_note_data.dart' as _i9;
import '../../../data/general/character/character_attack_data.dart' as _i10;
import '../../../data/general/character/character_feature_override_data.dart'
    as _i11;

abstract class CharacterRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  CharacterRecord._({
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
    this.customAbilityBonuses,
    this.useFlexibleAbilityBonuses,
    this.temporaryHp,
    this.currentHp,
    this.inspiration,
    this.equipment,
    this.manualSkillProficiencies,
    this.manualSavingThrowProficiencies,
    this.notes,
    this.attacks,
    this.featureOverrides,
  });

  factory CharacterRecord({
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
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
  }) = _CharacterRecordImpl;

  factory CharacterRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterRecord(
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
      customAbilityBonuses: (jsonSerialization['customAbilityBonuses'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      useFlexibleAbilityBonuses:
          jsonSerialization['useFlexibleAbilityBonuses'] as bool?,
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      inspiration: jsonSerialization['inspiration'] as bool?,
      equipment: (jsonSerialization['equipment'] as List?)
          ?.map((e) => _i6.CharacterInventoryItemData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      manualSkillProficiencies:
          (jsonSerialization['manualSkillProficiencies'] as List?)
              ?.map((e) => _i7.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      manualSavingThrowProficiencies:
          (jsonSerialization['manualSavingThrowProficiencies'] as List?)
              ?.map((e) => _i8.Ability.fromJson((e as String)))
              .toList(),
      notes: (jsonSerialization['notes'] as List?)
          ?.map((e) =>
              _i9.CharacterNoteData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      attacks: (jsonSerialization['attacks'] as List?)
          ?.map((e) =>
              _i10.CharacterAttackData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureOverrides: (jsonSerialization['featureOverrides'] as List?)
          ?.map((e) => _i11.CharacterFeatureOverrideData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = CharacterRecordTable();

  static const db = CharacterRecordRepository._();

  @override
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

  Map<String, int>? customAbilityBonuses;

  bool? useFlexibleAbilityBonuses;

  int? temporaryHp;

  int? currentHp;

  bool? inspiration;

  List<_i6.CharacterInventoryItemData>? equipment;

  List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies;

  List<_i8.Ability>? manualSavingThrowProficiencies;

  List<_i9.CharacterNoteData>? notes;

  List<_i10.CharacterAttackData>? attacks;

  List<_i11.CharacterFeatureOverrideData>? featureOverrides;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterRecord copyWith({
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
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
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
      if (customAbilityBonuses != null)
        'customAbilityBonuses': customAbilityBonuses?.toJson(),
      if (useFlexibleAbilityBonuses != null)
        'useFlexibleAbilityBonuses': useFlexibleAbilityBonuses,
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (inspiration != null) 'inspiration': inspiration,
      if (equipment != null)
        'equipment': equipment?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSkillProficiencies != null)
        'manualSkillProficiencies':
            manualSkillProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSavingThrowProficiencies != null)
        'manualSavingThrowProficiencies': manualSavingThrowProficiencies
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
      if (attacks != null)
        'attacks': attacks?.toJson(valueToJson: (v) => v.toJson()),
      if (featureOverrides != null)
        'featureOverrides':
            featureOverrides?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {if (id != null) 'id': id};
  }

  static CharacterRecordInclude include({
    _i3.RaceDataInclude? race,
    _i4.SubraceDataInclude? subrace,
    _i5.BackgroundDataInclude? background,
  }) {
    return CharacterRecordInclude._(
      race: race,
      subrace: subrace,
      background: background,
    );
  }

  static CharacterRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterRecordTable>? orderByList,
    CharacterRecordInclude? include,
  }) {
    return CharacterRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CharacterRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterRecordImpl extends CharacterRecord {
  _CharacterRecordImpl({
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
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    bool? inspiration,
    List<_i6.CharacterInventoryItemData>? equipment,
    List<_i7.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i8.Ability>? manualSavingThrowProficiencies,
    List<_i9.CharacterNoteData>? notes,
    List<_i10.CharacterAttackData>? attacks,
    List<_i11.CharacterFeatureOverrideData>? featureOverrides,
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
          customAbilityBonuses: customAbilityBonuses,
          useFlexibleAbilityBonuses: useFlexibleAbilityBonuses,
          temporaryHp: temporaryHp,
          currentHp: currentHp,
          inspiration: inspiration,
          equipment: equipment,
          manualSkillProficiencies: manualSkillProficiencies,
          manualSavingThrowProficiencies: manualSavingThrowProficiencies,
          notes: notes,
          attacks: attacks,
          featureOverrides: featureOverrides,
        );

  /// Returns a shallow copy of this [CharacterRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterRecord copyWith({
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
    Object? customAbilityBonuses = _Undefined,
    Object? useFlexibleAbilityBonuses = _Undefined,
    Object? temporaryHp = _Undefined,
    Object? currentHp = _Undefined,
    Object? inspiration = _Undefined,
    Object? equipment = _Undefined,
    Object? manualSkillProficiencies = _Undefined,
    Object? manualSavingThrowProficiencies = _Undefined,
    Object? notes = _Undefined,
    Object? attacks = _Undefined,
    Object? featureOverrides = _Undefined,
  }) {
    return CharacterRecord(
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
      customAbilityBonuses: customAbilityBonuses is Map<String, int>?
          ? customAbilityBonuses
          : this.customAbilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      useFlexibleAbilityBonuses: useFlexibleAbilityBonuses is bool?
          ? useFlexibleAbilityBonuses
          : this.useFlexibleAbilityBonuses,
      temporaryHp: temporaryHp is int? ? temporaryHp : this.temporaryHp,
      currentHp: currentHp is int? ? currentHp : this.currentHp,
      inspiration: inspiration is bool? ? inspiration : this.inspiration,
      equipment: equipment is List<_i6.CharacterInventoryItemData>?
          ? equipment
          : this.equipment?.map((e0) => e0.copyWith()).toList(),
      manualSkillProficiencies: manualSkillProficiencies
              is List<_i7.CharacterSkillProficiencyState>?
          ? manualSkillProficiencies
          : this.manualSkillProficiencies?.map((e0) => e0.copyWith()).toList(),
      manualSavingThrowProficiencies:
          manualSavingThrowProficiencies is List<_i8.Ability>?
              ? manualSavingThrowProficiencies
              : this.manualSavingThrowProficiencies?.map((e0) => e0).toList(),
      notes: notes is List<_i9.CharacterNoteData>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
      attacks: attacks is List<_i10.CharacterAttackData>?
          ? attacks
          : this.attacks?.map((e0) => e0.copyWith()).toList(),
      featureOverrides:
          featureOverrides is List<_i11.CharacterFeatureOverrideData>?
              ? featureOverrides
              : this.featureOverrides?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class CharacterRecordTable extends _i1.Table<int?> {
  CharacterRecordTable({super.tableRelation}) : super(tableName: 'characters') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    age = _i1.ColumnString(
      'age',
      this,
    );
    height = _i1.ColumnString(
      'height',
      this,
    );
    weight = _i1.ColumnString(
      'weight',
      this,
    );
    eyes = _i1.ColumnString(
      'eyes',
      this,
    );
    skin = _i1.ColumnString(
      'skin',
      this,
    );
    hair = _i1.ColumnString(
      'hair',
      this,
    );
    appearance = _i1.ColumnString(
      'appearance',
      this,
    );
    backstory = _i1.ColumnString(
      'backstory',
      this,
    );
    goals = _i1.ColumnString(
      'goals',
      this,
    );
    alliesOrganizations = _i1.ColumnString(
      'alliesOrganizations',
      this,
    );
    personalityTraits = _i1.ColumnString(
      'personalityTraits',
      this,
    );
    ideals = _i1.ColumnString(
      'ideals',
      this,
    );
    bonds = _i1.ColumnString(
      'bonds',
      this,
    );
    flaws = _i1.ColumnString(
      'flaws',
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
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    experience = _i1.ColumnInt(
      'experience',
      this,
    );
    alignmentValue = _i1.ColumnEnum(
      'alignmentValue',
      this,
      _i1.EnumSerialization.byName,
    );
    raceId = _i1.ColumnInt(
      'raceId',
      this,
    );
    subraceId = _i1.ColumnInt(
      'subraceId',
      this,
    );
    backgroundId = _i1.ColumnInt(
      'backgroundId',
      this,
    );
    baseAbilityScores = _i1.ColumnSerializable(
      'baseAbilityScores',
      this,
    );
    customAbilityBonuses = _i1.ColumnSerializable(
      'customAbilityBonuses',
      this,
    );
    useFlexibleAbilityBonuses = _i1.ColumnBool(
      'useFlexibleAbilityBonuses',
      this,
    );
    temporaryHp = _i1.ColumnInt(
      'temporaryHp',
      this,
    );
    currentHp = _i1.ColumnInt(
      'currentHp',
      this,
    );
    inspiration = _i1.ColumnBool(
      'inspiration',
      this,
    );
    equipment = _i1.ColumnSerializable(
      'equipment',
      this,
    );
    manualSkillProficiencies = _i1.ColumnSerializable(
      'manualSkillProficiencies',
      this,
    );
    manualSavingThrowProficiencies = _i1.ColumnSerializable(
      'manualSavingThrowProficiencies',
      this,
    );
    notes = _i1.ColumnSerializable(
      'notes',
      this,
    );
    attacks = _i1.ColumnSerializable(
      'attacks',
      this,
    );
    featureOverrides = _i1.ColumnSerializable(
      'featureOverrides',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString age;

  late final _i1.ColumnString height;

  late final _i1.ColumnString weight;

  late final _i1.ColumnString eyes;

  late final _i1.ColumnString skin;

  late final _i1.ColumnString hair;

  late final _i1.ColumnString appearance;

  late final _i1.ColumnString backstory;

  late final _i1.ColumnString goals;

  late final _i1.ColumnString alliesOrganizations;

  late final _i1.ColumnString personalityTraits;

  late final _i1.ColumnString ideals;

  late final _i1.ColumnString bonds;

  late final _i1.ColumnString flaws;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt experience;

  late final _i1.ColumnEnum<_i2.CharacterAlignment> alignmentValue;

  late final _i1.ColumnInt raceId;

  _i3.RaceDataTable? _race;

  late final _i1.ColumnInt subraceId;

  _i4.SubraceDataTable? _subrace;

  late final _i1.ColumnInt backgroundId;

  _i5.BackgroundDataTable? _background;

  late final _i1.ColumnSerializable baseAbilityScores;

  late final _i1.ColumnSerializable customAbilityBonuses;

  late final _i1.ColumnBool useFlexibleAbilityBonuses;

  late final _i1.ColumnInt temporaryHp;

  late final _i1.ColumnInt currentHp;

  late final _i1.ColumnBool inspiration;

  late final _i1.ColumnSerializable equipment;

  late final _i1.ColumnSerializable manualSkillProficiencies;

  late final _i1.ColumnSerializable manualSavingThrowProficiencies;

  late final _i1.ColumnSerializable notes;

  late final _i1.ColumnSerializable attacks;

  late final _i1.ColumnSerializable featureOverrides;

  _i3.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _i1.createRelationTable(
      relationFieldName: 'race',
      field: CharacterRecord.t.raceId,
      foreignField: _i3.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i4.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _i1.createRelationTable(
      relationFieldName: 'subrace',
      field: CharacterRecord.t.subraceId,
      foreignField: _i4.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  _i5.BackgroundDataTable get background {
    if (_background != null) return _background!;
    _background = _i1.createRelationTable(
      relationFieldName: 'background',
      field: CharacterRecord.t.backgroundId,
      foreignField: _i5.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _background!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        age,
        height,
        weight,
        eyes,
        skin,
        hair,
        appearance,
        backstory,
        goals,
        alliesOrganizations,
        personalityTraits,
        ideals,
        bonds,
        flaws,
        version,
        createdAt,
        updatedAt,
        userId,
        experience,
        alignmentValue,
        raceId,
        subraceId,
        backgroundId,
        baseAbilityScores,
        customAbilityBonuses,
        useFlexibleAbilityBonuses,
        temporaryHp,
        currentHp,
        inspiration,
        equipment,
        manualSkillProficiencies,
        manualSavingThrowProficiencies,
        notes,
        attacks,
        featureOverrides,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    if (relationField == 'background') {
      return background;
    }
    return null;
  }
}

class CharacterRecordInclude extends _i1.IncludeObject {
  CharacterRecordInclude._({
    _i3.RaceDataInclude? race,
    _i4.SubraceDataInclude? subrace,
    _i5.BackgroundDataInclude? background,
  }) {
    _race = race;
    _subrace = subrace;
    _background = background;
  }

  _i3.RaceDataInclude? _race;

  _i4.SubraceDataInclude? _subrace;

  _i5.BackgroundDataInclude? _background;

  @override
  Map<String, _i1.Include?> get includes => {
        'race': _race,
        'subrace': _subrace,
        'background': _background,
      };

  @override
  _i1.Table<int?> get table => CharacterRecord.t;
}

class CharacterRecordIncludeList extends _i1.IncludeList {
  CharacterRecordIncludeList._({
    _i1.WhereExpressionBuilder<CharacterRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CharacterRecord.t;
}

class CharacterRecordRepository {
  const CharacterRecordRepository._();

  final attachRow = const CharacterRecordAttachRowRepository._();

  final detachRow = const CharacterRecordDetachRowRepository._();

  /// Returns a list of [CharacterRecord]s matching the given query parameters.
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
  Future<List<CharacterRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CharacterRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterRecordInclude? include,
  }) async {
    return session.db.find<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [CharacterRecord] matching the given query parameters.
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
  Future<CharacterRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<CharacterRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _i1.Transaction? transaction,
    CharacterRecordInclude? include,
  }) async {
    return session.db.findFirstRow<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [CharacterRecord] by its [id] or null if no such row exists.
  Future<CharacterRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    CharacterRecordInclude? include,
  }) async {
    return session.db.findById<CharacterRecord>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [CharacterRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<CharacterRecord>> insert(
    _i1.Session session,
    List<CharacterRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<CharacterRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [CharacterRecord] and returns the inserted row.
  ///
  /// The returned [CharacterRecord] will have its `id` field set.
  Future<CharacterRecord> insertRow(
    _i1.Session session,
    CharacterRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CharacterRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CharacterRecord>> update(
    _i1.Session session,
    List<CharacterRecord> rows, {
    _i1.ColumnSelections<CharacterRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CharacterRecord>(
      rows,
      columns: columns?.call(CharacterRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterRecord> updateRow(
    _i1.Session session,
    CharacterRecord row, {
    _i1.ColumnSelections<CharacterRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterRecord>(
      row,
      columns: columns?.call(CharacterRecord.t),
      transaction: transaction,
    );
  }

  /// Deletes all [CharacterRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CharacterRecord>> delete(
    _i1.Session session,
    List<CharacterRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CharacterRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CharacterRecord].
  Future<CharacterRecord> deleteRow(
    _i1.Session session,
    CharacterRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CharacterRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CharacterRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CharacterRecord>(
      where: where(CharacterRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class CharacterRecordAttachRowRepository {
  const CharacterRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterRecord] and [RaceData]
  /// by setting the [CharacterRecord]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _i1.Session session,
    CharacterRecord characterRecord,
    _i3.RaceData race, {
    _i1.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $characterRecord = characterRecord.copyWith(raceId: race.id);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.raceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterRecord] and [SubraceData]
  /// by setting the [CharacterRecord]'s foreign key `subraceId` to refer to the [SubraceData].
  Future<void> subrace(
    _i1.Session session,
    CharacterRecord characterRecord,
    _i4.SubraceData subrace, {
    _i1.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (subrace.id == null) {
      throw ArgumentError.notNull('subrace.id');
    }

    var $characterRecord = characterRecord.copyWith(subraceId: subrace.id);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.subraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterRecord] and [BackgroundData]
  /// by setting the [CharacterRecord]'s foreign key `backgroundId` to refer to the [BackgroundData].
  Future<void> background(
    _i1.Session session,
    CharacterRecord characterRecord,
    _i5.BackgroundData background, {
    _i1.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (background.id == null) {
      throw ArgumentError.notNull('background.id');
    }

    var $characterRecord =
        characterRecord.copyWith(backgroundId: background.id);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.backgroundId],
      transaction: transaction,
    );
  }
}

class CharacterRecordDetachRowRepository {
  const CharacterRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterRecord] and the [RaceData] set in `race`
  /// by setting the [CharacterRecord]'s foreign key `raceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> race(
    _i1.Session session,
    CharacterRecord characterrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterrecord.id == null) {
      throw ArgumentError.notNull('characterrecord.id');
    }

    var $characterrecord = characterrecord.copyWith(raceId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterrecord,
      columns: [CharacterRecord.t.raceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterRecord] and the [SubraceData] set in `subrace`
  /// by setting the [CharacterRecord]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subrace(
    _i1.Session session,
    CharacterRecord characterrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterrecord.id == null) {
      throw ArgumentError.notNull('characterrecord.id');
    }

    var $characterrecord = characterrecord.copyWith(subraceId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterrecord,
      columns: [CharacterRecord.t.subraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterRecord] and the [BackgroundData] set in `background`
  /// by setting the [CharacterRecord]'s foreign key `backgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> background(
    _i1.Session session,
    CharacterRecord characterrecord, {
    _i1.Transaction? transaction,
  }) async {
    if (characterrecord.id == null) {
      throw ArgumentError.notNull('characterrecord.id');
    }

    var $characterrecord = characterrecord.copyWith(backgroundId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterrecord,
      columns: [CharacterRecord.t.backgroundId],
      transaction: transaction,
    );
  }
}
