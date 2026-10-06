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
import 'dart:async' as _i2;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i3;
import 'package:characters_mirror_client/src/protocol/auth/auth_action_result.dart'
    as _i4;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i5;
import 'package:characters_mirror_client/src/protocol/views/background_step_view.dart'
    as _i6;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i7;
import 'package:characters_mirror_client/src/protocol/views/level_up_preview.dart'
    as _i8;
import 'package:characters_mirror_client/src/protocol/data/general/character/level_up_request.dart'
    as _i9;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i10;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_result.dart'
    as _i11;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_response.dart'
    as _i12;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_request.dart'
    as _i13;
import 'package:characters_mirror_client/src/protocol/data/general/choice_group_data.dart'
    as _i14;
import 'package:characters_mirror_client/src/protocol/data/general/choice_option_data.dart'
    as _i15;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i16;
import 'package:characters_mirror_client/src/protocol/views/class_step_view.dart'
    as _i17;
import 'package:characters_mirror_client/src/protocol/views/class_spell_delta_view.dart'
    as _i18;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i19;
import 'package:characters_mirror_client/src/protocol/data/class_spell_grant_data.dart'
    as _i20;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i21;
import 'package:characters_mirror_client/src/protocol/data/general/class/spell_slot_progression_data.dart'
    as _i22;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i23;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i24;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i25;
import 'package:characters_mirror_client/src/protocol/views/race_step_view.dart'
    as _i26;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i27;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i28;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i29;
import 'package:characters_mirror_client/src/protocol/data/general/tool_data.dart'
    as _i30;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i31;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i32;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i33;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i34;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i35;
import 'protocol.dart' as _i36;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<List<_i3.UserInfo>> getAllUsers() =>
      caller.callServerEndpoint<List<_i3.UserInfo>>(
        'admin',
        'getAllUsers',
        {},
      );

  _i2.Future<void> setAdminRole(
    int userId,
    bool isAdmin,
  ) =>
      caller.callServerEndpoint<void>(
        'admin',
        'setAdminRole',
        {
          'userId': userId,
          'isAdmin': isAdmin,
        },
      );

  /// Imports declarative choice options by stable group and option keys.
  /// Existing rows are replaced by key; omitted requirements are preserved.
  _i2.Future<int> importChoiceOptions(String json) =>
      caller.callServerEndpoint<int>(
        'admin',
        'importChoiceOptions',
        {'json': json},
      );

  /// Imports data-driven modifiers by stable feature and modifier keys.
  _i2.Future<int> importFeatureModifiers(String json) =>
      caller.callServerEndpoint<int>(
        'admin',
        'importFeatureModifiers',
        {'json': json},
      );
}

/// {@category Endpoint}
class EndpointAppAuth extends _i1.EndpointRef {
  EndpointAppAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appAuth';

  _i2.Future<_i4.AuthActionResult> register(
    String userName,
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<_i4.AuthActionResult>(
        'appAuth',
        'register',
        {
          'userName': userName,
          'email': email,
          'password': password,
        },
      );
}

/// {@category Endpoint}
class EndpointCharacterPortrait extends _i1.EndpointRef {
  EndpointCharacterPortrait(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterPortrait';

  _i2.Future<String> createUploadUrl(int characterId) =>
      caller.callServerEndpoint<String>(
        'characterPortrait',
        'createUploadUrl',
        {'characterId': characterId},
      );

  _i2.Future<int> confirmUpload(int characterId) =>
      caller.callServerEndpoint<int>(
        'characterPortrait',
        'confirmUpload',
        {'characterId': characterId},
      );

  _i2.Future<String?> getUrl(int characterId) =>
      caller.callServerEndpoint<String?>(
        'characterPortrait',
        'getUrl',
        {'characterId': characterId},
      );

  _i2.Future<void> deletePortrait(int characterId) =>
      caller.callServerEndpoint<void>(
        'characterPortrait',
        'deletePortrait',
        {'characterId': characterId},
      );
}

/// {@category Endpoint}
class EndpointBackgroundData extends _i1.EndpointRef {
  EndpointBackgroundData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'backgroundData';

  _i2.Future<List<_i5.BackgroundData>> getAll() =>
      caller.callServerEndpoint<List<_i5.BackgroundData>>(
        'backgroundData',
        'getAll',
        {},
      );

  _i2.Future<_i6.BackgroundStepView> getStepView(int backgroundId) =>
      caller.callServerEndpoint<_i6.BackgroundStepView>(
        'backgroundData',
        'getStepView',
        {'backgroundId': backgroundId},
      );

  _i2.Future<_i5.BackgroundData> add(_i5.BackgroundData background) =>
      caller.callServerEndpoint<_i5.BackgroundData>(
        'backgroundData',
        'add',
        {'background': background},
      );

  _i2.Future<_i5.BackgroundData> upsert(_i5.BackgroundData background) =>
      caller.callServerEndpoint<_i5.BackgroundData>(
        'backgroundData',
        'upsert',
        {'background': background},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'backgroundData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointFeatData extends _i1.EndpointRef {
  EndpointFeatData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'featData';

  _i2.Future<List<_i7.FeatData>> getAll() =>
      caller.callServerEndpoint<List<_i7.FeatData>>(
        'featData',
        'getAll',
        {},
      );

  _i2.Future<_i7.FeatData> add(_i7.FeatData feat) =>
      caller.callServerEndpoint<_i7.FeatData>(
        'featData',
        'add',
        {'feat': feat},
      );

  _i2.Future<_i7.FeatData> upsert(_i7.FeatData feat) =>
      caller.callServerEndpoint<_i7.FeatData>(
        'featData',
        'upsert',
        {'feat': feat},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'featData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointCharacterData extends _i1.EndpointRef {
  EndpointCharacterData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterData';

  _i2.Future<_i8.LevelUpPreview> previewLevelUp(_i9.LevelUpRequest request) =>
      caller.callServerEndpoint<_i8.LevelUpPreview>(
        'characterData',
        'previewLevelUp',
        {'request': request},
      );

  _i2.Future<_i10.CharacterData> applyLevelUp(_i9.LevelUpRequest request) =>
      caller.callServerEndpoint<_i10.CharacterData>(
        'characterData',
        'applyLevelUp',
        {'request': request},
      );

  _i2.Future<List<_i10.CharacterData>> getAll() =>
      caller.callServerEndpoint<List<_i10.CharacterData>>(
        'characterData',
        'getAll',
        {},
      );

  _i2.Future<_i10.CharacterData> saveCharacter(_i10.CharacterData character) =>
      caller.callServerEndpoint<_i10.CharacterData>(
        'characterData',
        'saveCharacter',
        {'character': character},
      );

  _i2.Future<_i11.CharacterSyncResult> syncSaveCharacter(
    _i10.CharacterData character,
    int? expectedVersion,
  ) =>
      caller.callServerEndpoint<_i11.CharacterSyncResult>(
        'characterData',
        'syncSaveCharacter',
        {
          'character': character,
          'expectedVersion': expectedVersion,
        },
      );

  _i2.Future<_i12.CharacterSyncResponse> syncCharacters(
          _i13.CharacterSyncRequest request) =>
      caller.callServerEndpoint<_i12.CharacterSyncResponse>(
        'characterData',
        'syncCharacters',
        {'request': request},
      );

  _i2.Future<_i10.CharacterData> getCharacter(int id) =>
      caller.callServerEndpoint<_i10.CharacterData>(
        'characterData',
        'getCharacter',
        {'id': id},
      );

  _i2.Future<_i11.CharacterSyncResult> syncDeleteCharacter(
    int id,
    int? expectedVersion,
  ) =>
      caller.callServerEndpoint<_i11.CharacterSyncResult>(
        'characterData',
        'syncDeleteCharacter',
        {
          'id': id,
          'expectedVersion': expectedVersion,
        },
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'characterData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointChoiceGroupData extends _i1.EndpointRef {
  EndpointChoiceGroupData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'choiceGroupData';

  _i2.Future<List<_i14.ChoiceGroupData>> getAll() =>
      caller.callServerEndpoint<List<_i14.ChoiceGroupData>>(
        'choiceGroupData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointChoiceOptionData extends _i1.EndpointRef {
  EndpointChoiceOptionData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'choiceOptionData';

  _i2.Future<List<_i15.ChoiceOptionData>> getAll() =>
      caller.callServerEndpoint<List<_i15.ChoiceOptionData>>(
        'choiceOptionData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointClassData extends _i1.EndpointRef {
  EndpointClassData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classData';

  _i2.Future<List<_i16.ClassData>> getAll() =>
      caller.callServerEndpoint<List<_i16.ClassData>>(
        'classData',
        'getAll',
        {},
      );

  _i2.Future<_i16.ClassData> add(_i16.ClassData classData) =>
      caller.callServerEndpoint<_i16.ClassData>(
        'classData',
        'add',
        {'classData': classData},
      );

  _i2.Future<_i16.ClassData> upsert(_i16.ClassData classData) =>
      caller.callServerEndpoint<_i16.ClassData>(
        'classData',
        'upsert',
        {'classData': classData},
      );

  _i2.Future<_i17.ClassStepView> getStepView(
    int classId, {
    required int selectedLevel,
    required bool isStartingClass,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) =>
      caller.callServerEndpoint<_i17.ClassStepView>(
        'classData',
        'getStepView',
        {
          'classId': classId,
          'selectedLevel': selectedLevel,
          'isStartingClass': isStartingClass,
          'selectedSubclassId': selectedSubclassId,
          'abilityScores': abilityScores,
        },
      );

  _i2.Future<_i18.ClassSpellDeltaView> getSpellDelta(
    int classId,
    int fromLevel,
    int toLevel,
    Map<String, int> abilityScores,
  ) =>
      caller.callServerEndpoint<_i18.ClassSpellDeltaView>(
        'classData',
        'getSpellDelta',
        {
          'classId': classId,
          'fromLevel': fromLevel,
          'toLevel': toLevel,
          'abilityScores': abilityScores,
        },
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassFeatureData extends _i1.EndpointRef {
  EndpointClassFeatureData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classFeatureData';

  _i2.Future<List<_i19.ClassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_i19.ClassFeatureData>>(
        'classFeatureData',
        'getAll',
        {},
      );

  _i2.Future<_i19.ClassFeatureData> add(_i19.ClassFeatureData item) =>
      caller.callServerEndpoint<_i19.ClassFeatureData>(
        'classFeatureData',
        'add',
        {'item': item},
      );

  _i2.Future<_i19.ClassFeatureData> upsert(_i19.ClassFeatureData feature) =>
      caller.callServerEndpoint<_i19.ClassFeatureData>(
        'classFeatureData',
        'upsert',
        {'feature': feature},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classFeatureData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassSpellGrantData extends _i1.EndpointRef {
  EndpointClassSpellGrantData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classSpellGrantData';

  _i2.Future<List<_i20.ClassSpellGrantData>> getAll() =>
      caller.callServerEndpoint<List<_i20.ClassSpellGrantData>>(
        'classSpellGrantData',
        'getAll',
        {},
      );

  _i2.Future<_i20.ClassSpellGrantData> add(_i20.ClassSpellGrantData item) =>
      caller.callServerEndpoint<_i20.ClassSpellGrantData>(
        'classSpellGrantData',
        'add',
        {'item': item},
      );

  _i2.Future<_i20.ClassSpellGrantData> upsert(_i20.ClassSpellGrantData item) =>
      caller.callServerEndpoint<_i20.ClassSpellGrantData>(
        'classSpellGrantData',
        'upsert',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classSpellGrantData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassLevelData extends _i1.EndpointRef {
  EndpointClassLevelData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classLevelData';

  _i2.Future<List<_i21.ClassLevelData>> getAll() =>
      caller.callServerEndpoint<List<_i21.ClassLevelData>>(
        'classLevelData',
        'getAll',
        {},
      );

  _i2.Future<_i21.ClassLevelData> add(_i21.ClassLevelData item) =>
      caller.callServerEndpoint<_i21.ClassLevelData>(
        'classLevelData',
        'add',
        {'item': item},
      );

  _i2.Future<_i21.ClassLevelData> upsert(_i21.ClassLevelData item) =>
      caller.callServerEndpoint<_i21.ClassLevelData>(
        'classLevelData',
        'upsert',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classLevelData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSpellSlotProgressionData extends _i1.EndpointRef {
  EndpointSpellSlotProgressionData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellSlotProgressionData';

  _i2.Future<List<_i22.SpellSlotProgressionData>> getAll() =>
      caller.callServerEndpoint<List<_i22.SpellSlotProgressionData>>(
        'spellSlotProgressionData',
        'getAll',
        {},
      );

  _i2.Future<_i22.SpellSlotProgressionData> add(
          _i22.SpellSlotProgressionData item) =>
      caller.callServerEndpoint<_i22.SpellSlotProgressionData>(
        'spellSlotProgressionData',
        'add',
        {'item': item},
      );

  _i2.Future<_i22.SpellSlotProgressionData> upsert(
          _i22.SpellSlotProgressionData item) =>
      caller.callServerEndpoint<_i22.SpellSlotProgressionData>(
        'spellSlotProgressionData',
        'upsert',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'spellSlotProgressionData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubclassData extends _i1.EndpointRef {
  EndpointSubclassData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassData';

  _i2.Future<List<_i23.SubclassData>> getAll() =>
      caller.callServerEndpoint<List<_i23.SubclassData>>(
        'subclassData',
        'getAll',
        {},
      );

  _i2.Future<_i23.SubclassData> add(_i23.SubclassData item) =>
      caller.callServerEndpoint<_i23.SubclassData>(
        'subclassData',
        'add',
        {'item': item},
      );

  _i2.Future<_i23.SubclassData> upsert(_i23.SubclassData subclass) =>
      caller.callServerEndpoint<_i23.SubclassData>(
        'subclassData',
        'upsert',
        {'subclass': subclass},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subclassData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubclassFeatureData extends _i1.EndpointRef {
  EndpointSubclassFeatureData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassFeatureData';

  _i2.Future<List<_i24.SubclassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_i24.SubclassFeatureData>>(
        'subclassFeatureData',
        'getAll',
        {},
      );

  _i2.Future<_i24.SubclassFeatureData> add(_i24.SubclassFeatureData item) =>
      caller.callServerEndpoint<_i24.SubclassFeatureData>(
        'subclassFeatureData',
        'add',
        {'item': item},
      );

  _i2.Future<_i24.SubclassFeatureData> upsert(
          _i24.SubclassFeatureData subclassFeature) =>
      caller.callServerEndpoint<_i24.SubclassFeatureData>(
        'subclassFeatureData',
        'upsert',
        {'subclassFeature': subclassFeature},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subclassFeatureData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointRaceData extends _i1.EndpointRef {
  EndpointRaceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceData';

  _i2.Future<List<_i25.RaceData>> getAll() =>
      caller.callServerEndpoint<List<_i25.RaceData>>(
        'raceData',
        'getAll',
        {},
      );

  _i2.Future<_i25.RaceData> add(_i25.RaceData race) =>
      caller.callServerEndpoint<_i25.RaceData>(
        'raceData',
        'add',
        {'race': race},
      );

  _i2.Future<_i25.RaceData> upsert(_i25.RaceData race) =>
      caller.callServerEndpoint<_i25.RaceData>(
        'raceData',
        'upsert',
        {'race': race},
      );

  _i2.Future<_i26.RaceStepView> getStepView(int raceId) =>
      caller.callServerEndpoint<_i26.RaceStepView>(
        'raceData',
        'getStepView',
        {'raceId': raceId},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'raceData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointRaceFeature extends _i1.EndpointRef {
  EndpointRaceFeature(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceFeature';

  _i2.Future<List<_i27.RaceFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_i27.RaceFeatureData>>(
        'raceFeature',
        'getAll',
        {},
      );

  _i2.Future<_i27.RaceFeatureData> add(_i27.RaceFeatureData raceFeature) =>
      caller.callServerEndpoint<_i27.RaceFeatureData>(
        'raceFeature',
        'add',
        {'raceFeature': raceFeature},
      );

  _i2.Future<_i27.RaceFeatureData> upsert(_i27.RaceFeatureData raceFeature) =>
      caller.callServerEndpoint<_i27.RaceFeatureData>(
        'raceFeature',
        'upsert',
        {'raceFeature': raceFeature},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'raceFeature',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubraceData extends _i1.EndpointRef {
  EndpointSubraceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subraceData';

  _i2.Future<List<_i28.SubraceData>> getAll() =>
      caller.callServerEndpoint<List<_i28.SubraceData>>(
        'subraceData',
        'getAll',
        {},
      );

  _i2.Future<_i28.SubraceData> add(_i28.SubraceData subrace) =>
      caller.callServerEndpoint<_i28.SubraceData>(
        'subraceData',
        'add',
        {'subrace': subrace},
      );

  _i2.Future<_i28.SubraceData> upsert(_i28.SubraceData subrace) =>
      caller.callServerEndpoint<_i28.SubraceData>(
        'subraceData',
        'upsert',
        {'subrace': subrace},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subraceData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointRaceFeatureSpellGrantData extends _i1.EndpointRef {
  EndpointRaceFeatureSpellGrantData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceFeatureSpellGrantData';

  _i2.Future<List<_i29.RaceFeatureSpellGrantData>> getAll() =>
      caller.callServerEndpoint<List<_i29.RaceFeatureSpellGrantData>>(
        'raceFeatureSpellGrantData',
        'getAll',
        {},
      );

  _i2.Future<_i29.RaceFeatureSpellGrantData> add(
          _i29.RaceFeatureSpellGrantData item) =>
      caller.callServerEndpoint<_i29.RaceFeatureSpellGrantData>(
        'raceFeatureSpellGrantData',
        'add',
        {'item': item},
      );

  _i2.Future<_i29.RaceFeatureSpellGrantData> upsert(
          _i29.RaceFeatureSpellGrantData item) =>
      caller.callServerEndpoint<_i29.RaceFeatureSpellGrantData>(
        'raceFeatureSpellGrantData',
        'upsert',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'raceFeatureSpellGrantData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointToolData extends _i1.EndpointRef {
  EndpointToolData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'toolData';

  _i2.Future<List<_i30.ToolData>> getAll() =>
      caller.callServerEndpoint<List<_i30.ToolData>>(
        'toolData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointArmorData extends _i1.EndpointRef {
  EndpointArmorData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'armorData';

  _i2.Future<List<_i31.ArmorData>> getAll() =>
      caller.callServerEndpoint<List<_i31.ArmorData>>(
        'armorData',
        'getAll',
        {},
      );

  _i2.Future<_i31.ArmorData> add(_i31.ArmorData armor) =>
      caller.callServerEndpoint<_i31.ArmorData>(
        'armorData',
        'add',
        {'armor': armor},
      );

  _i2.Future<_i31.ArmorData> upsert(_i31.ArmorData armor) =>
      caller.callServerEndpoint<_i31.ArmorData>(
        'armorData',
        'upsert',
        {'armor': armor},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'armorData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointItemData extends _i1.EndpointRef {
  EndpointItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'itemData';

  _i2.Future<List<_i32.ItemData>> getAll() =>
      caller.callServerEndpoint<List<_i32.ItemData>>(
        'itemData',
        'getAll',
        {},
      );

  _i2.Future<_i32.ItemData> add(_i32.ItemData item) =>
      caller.callServerEndpoint<_i32.ItemData>(
        'itemData',
        'add',
        {'item': item},
      );

  _i2.Future<_i32.ItemData> upsert(_i32.ItemData item) =>
      caller.callServerEndpoint<_i32.ItemData>(
        'itemData',
        'upsert',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'itemData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointMagicItemData extends _i1.EndpointRef {
  EndpointMagicItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'magicItemData';

  _i2.Future<List<_i33.MagicItemData>> getAll() =>
      caller.callServerEndpoint<List<_i33.MagicItemData>>(
        'magicItemData',
        'getAll',
        {},
      );

  _i2.Future<_i33.MagicItemData> add(_i33.MagicItemData item) =>
      caller.callServerEndpoint<_i33.MagicItemData>(
        'magicItemData',
        'add',
        {'item': item},
      );

  _i2.Future<_i33.MagicItemData> upsert(_i33.MagicItemData magicItem) =>
      caller.callServerEndpoint<_i33.MagicItemData>(
        'magicItemData',
        'upsert',
        {'magicItem': magicItem},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'magicItemData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWeaponData extends _i1.EndpointRef {
  EndpointWeaponData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'weaponData';

  _i2.Future<List<_i34.WeaponData>> getAll() =>
      caller.callServerEndpoint<List<_i34.WeaponData>>(
        'weaponData',
        'getAll',
        {},
      );

  _i2.Future<_i34.WeaponData> add(_i34.WeaponData weapon) =>
      caller.callServerEndpoint<_i34.WeaponData>(
        'weaponData',
        'add',
        {'weapon': weapon},
      );

  _i2.Future<_i34.WeaponData> upsert(_i34.WeaponData weapon) =>
      caller.callServerEndpoint<_i34.WeaponData>(
        'weaponData',
        'upsert',
        {'weapon': weapon},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'weaponData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSpellData extends _i1.EndpointRef {
  EndpointSpellData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellData';

  _i2.Future<List<_i35.SpellData>> getAll() =>
      caller.callServerEndpoint<List<_i35.SpellData>>(
        'spellData',
        'getAll',
        {},
      );

  _i2.Future<_i35.SpellData> add(_i35.SpellData spell) =>
      caller.callServerEndpoint<_i35.SpellData>(
        'spellData',
        'add',
        {'spell': spell},
      );

  _i2.Future<_i35.SpellData> upsert(_i35.SpellData spell) =>
      caller.callServerEndpoint<_i35.SpellData>(
        'spellData',
        'upsert',
        {'spell': spell},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'spellData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointPing extends _i1.EndpointRef {
  EndpointPing(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ping';

  _i2.Future<bool> ping() => caller.callServerEndpoint<bool>(
        'ping',
        'ping',
        {},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i3.Caller(client);
  }

  late final _i3.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i36.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    admin = EndpointAdmin(this);
    appAuth = EndpointAppAuth(this);
    characterPortrait = EndpointCharacterPortrait(this);
    backgroundData = EndpointBackgroundData(this);
    featData = EndpointFeatData(this);
    characterData = EndpointCharacterData(this);
    choiceGroupData = EndpointChoiceGroupData(this);
    choiceOptionData = EndpointChoiceOptionData(this);
    classData = EndpointClassData(this);
    classFeatureData = EndpointClassFeatureData(this);
    classSpellGrantData = EndpointClassSpellGrantData(this);
    classLevelData = EndpointClassLevelData(this);
    spellSlotProgressionData = EndpointSpellSlotProgressionData(this);
    subclassData = EndpointSubclassData(this);
    subclassFeatureData = EndpointSubclassFeatureData(this);
    raceData = EndpointRaceData(this);
    raceFeature = EndpointRaceFeature(this);
    subraceData = EndpointSubraceData(this);
    raceFeatureSpellGrantData = EndpointRaceFeatureSpellGrantData(this);
    toolData = EndpointToolData(this);
    armorData = EndpointArmorData(this);
    itemData = EndpointItemData(this);
    magicItemData = EndpointMagicItemData(this);
    weaponData = EndpointWeaponData(this);
    spellData = EndpointSpellData(this);
    ping = EndpointPing(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointAppAuth appAuth;

  late final EndpointCharacterPortrait characterPortrait;

  late final EndpointBackgroundData backgroundData;

  late final EndpointFeatData featData;

  late final EndpointCharacterData characterData;

  late final EndpointChoiceGroupData choiceGroupData;

  late final EndpointChoiceOptionData choiceOptionData;

  late final EndpointClassData classData;

  late final EndpointClassFeatureData classFeatureData;

  late final EndpointClassSpellGrantData classSpellGrantData;

  late final EndpointClassLevelData classLevelData;

  late final EndpointSpellSlotProgressionData spellSlotProgressionData;

  late final EndpointSubclassData subclassData;

  late final EndpointSubclassFeatureData subclassFeatureData;

  late final EndpointRaceData raceData;

  late final EndpointRaceFeature raceFeature;

  late final EndpointSubraceData subraceData;

  late final EndpointRaceFeatureSpellGrantData raceFeatureSpellGrantData;

  late final EndpointToolData toolData;

  late final EndpointArmorData armorData;

  late final EndpointItemData itemData;

  late final EndpointMagicItemData magicItemData;

  late final EndpointWeaponData weaponData;

  late final EndpointSpellData spellData;

  late final EndpointPing ping;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'appAuth': appAuth,
        'characterPortrait': characterPortrait,
        'backgroundData': backgroundData,
        'featData': featData,
        'characterData': characterData,
        'choiceGroupData': choiceGroupData,
        'choiceOptionData': choiceOptionData,
        'classData': classData,
        'classFeatureData': classFeatureData,
        'classSpellGrantData': classSpellGrantData,
        'classLevelData': classLevelData,
        'spellSlotProgressionData': spellSlotProgressionData,
        'subclassData': subclassData,
        'subclassFeatureData': subclassFeatureData,
        'raceData': raceData,
        'raceFeature': raceFeature,
        'subraceData': subraceData,
        'raceFeatureSpellGrantData': raceFeatureSpellGrantData,
        'toolData': toolData,
        'armorData': armorData,
        'itemData': itemData,
        'magicItemData': magicItemData,
        'weaponData': weaponData,
        'spellData': spellData,
        'ping': ping,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
