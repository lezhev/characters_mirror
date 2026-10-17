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
import 'dart:async' as _ida;
import 'package:characters_mirror_client/src/protocol/auth/auth_action_result.dart'
    as _itvkv7z5;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _ir4mnztf;
import 'package:characters_mirror_client/src/protocol/data/class_spell_grant_data.dart'
    as _ibq4gqkd;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _ipq9e85u;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i82zmloj;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_request.dart'
    as _ixbs72k6;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_response.dart'
    as _ihk7b5q5;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_sync_result.dart'
    as _ignpm0zo;
import 'package:characters_mirror_client/src/protocol/data/general/character/level_up_request.dart'
    as _ing1kbql;
import 'package:characters_mirror_client/src/protocol/data/general/choice_group_data.dart'
    as _i44xjl6j;
import 'package:characters_mirror_client/src/protocol/data/general/choice_option_data.dart'
    as _iqcr63pm;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i3mngh91;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _iozr72e1;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _izzx945w;
import 'package:characters_mirror_client/src/protocol/data/general/class/spell_slot_progression_data.dart'
    as _i8v86dtn;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _iuhgku0a;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _is2mx8yv;
import 'package:characters_mirror_client/src/protocol/data/general/feature_relation_data.dart'
    as _ifrx84um;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _ilc3ntdx;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _imf9k3ru;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i9vzxbi6;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i5ca8sk9;
import 'package:characters_mirror_client/src/protocol/data/general/tool_data.dart'
    as _izep6fcb;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i4pe33cv;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _iqylf6yx;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _ig7tbc7e;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i5q8wx5t;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _ic7268ss;
import 'package:characters_mirror_client/src/protocol/dungeon_master/dm_creature_import_result.dart'
    as _i24kefos;
import 'package:characters_mirror_client/src/protocol/dungeon_master/dm_creature_record.dart'
    as _ib2ztxj6;
import 'package:characters_mirror_client/src/protocol/dungeon_master/dm_creature_summary.dart'
    as _iuiuigdt;
import 'package:characters_mirror_client/src/protocol/requests/level_down_request.dart'
    as _inrz8set;
import 'package:characters_mirror_client/src/protocol/views/background_step_view.dart'
    as _idzaasxu;
import 'package:characters_mirror_client/src/protocol/views/class_spell_delta_view.dart'
    as _iz8eq58c;
import 'package:characters_mirror_client/src/protocol/views/class_step_view.dart'
    as _i6cvo0u4;
import 'package:characters_mirror_client/src/protocol/views/level_down_preview.dart'
    as _i4enji4f;
import 'package:characters_mirror_client/src/protocol/views/level_up_preview.dart'
    as _i0hj17rt;
import 'package:characters_mirror_client/src/protocol/views/race_step_view.dart'
    as _ilegem88;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _ida.Future<List<_i312scxx.UserInfo>> getAllUsers() => caller
      .callServerEndpoint<List<_i312scxx.UserInfo>>('admin', 'getAllUsers', {});

  _ida.Future<void> setAdminRole(int userId, bool isAdmin) =>
      caller.callServerEndpoint<void>('admin', 'setAdminRole', {
        'userId': userId,
        'isAdmin': isAdmin,
      });

  _ida.Future<void> setGmRole(int userId, bool isGm) =>
      caller.callServerEndpoint<void>('admin', 'setGmRole', {
        'userId': userId,
        'isGm': isGm,
      });

  /// Imports declarative choice options by stable group and option keys.
  /// Existing rows are replaced by key; omitted requirements are preserved.
  _ida.Future<int> importChoiceOptions(String json) => caller
      .callServerEndpoint<int>('admin', 'importChoiceOptions', {'json': json});

  /// Imports data-driven modifiers by stable feature and modifier keys.
  _ida.Future<int> importFeatureModifiers(String json) =>
      caller.callServerEndpoint<int>('admin', 'importFeatureModifiers', {
        'json': json,
      });
}

/// {@category Endpoint}
class EndpointAppAuth extends _isc.EndpointRef {
  EndpointAppAuth(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appAuth';

  _ida.Future<_itvkv7z5.AuthActionResult> register(
    String userName,
    String email,
    String password,
  ) => caller.callServerEndpoint<_itvkv7z5.AuthActionResult>(
    'appAuth',
    'register',
    {'userName': userName, 'email': email, 'password': password},
  );
}

/// {@category Endpoint}
class EndpointCharacterPortrait extends _isc.EndpointRef {
  EndpointCharacterPortrait(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterPortrait';

  _ida.Future<String> createUploadUrl(int characterId) =>
      caller.callServerEndpoint<String>(
        'characterPortrait',
        'createUploadUrl',
        {'characterId': characterId},
      );

  _ida.Future<int> confirmUpload(int characterId) =>
      caller.callServerEndpoint<int>('characterPortrait', 'confirmUpload', {
        'characterId': characterId,
      });

  _ida.Future<String?> getUrl(int characterId) =>
      caller.callServerEndpoint<String?>('characterPortrait', 'getUrl', {
        'characterId': characterId,
      });

  _ida.Future<void> deletePortrait(int characterId) =>
      caller.callServerEndpoint<void>('characterPortrait', 'deletePortrait', {
        'characterId': characterId,
      });
}

/// {@category Endpoint}
class EndpointDmCreature extends _isc.EndpointRef {
  EndpointDmCreature(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dmCreature';

  _ida.Future<_i24kefos.DmCreatureImportResult> importCreature(
    String rawJson,
  ) => caller.callServerEndpoint<_i24kefos.DmCreatureImportResult>(
    'dmCreature',
    'importCreature',
    {'rawJson': rawJson},
  );

  _ida.Future<List<_iuiuigdt.DmCreatureSummary>> getCreatures() =>
      caller.callServerEndpoint<List<_iuiuigdt.DmCreatureSummary>>(
        'dmCreature',
        'getCreatures',
        {},
      );

  _ida.Future<_ib2ztxj6.DmCreatureRecord> getCreature(int id) =>
      caller.callServerEndpoint<_ib2ztxj6.DmCreatureRecord>(
        'dmCreature',
        'getCreature',
        {'id': id},
      );

  _ida.Future<void> deleteCreature(int id) => caller.callServerEndpoint<void>(
    'dmCreature',
    'deleteCreature',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointBackgroundData extends _isc.EndpointRef {
  EndpointBackgroundData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'backgroundData';

  _ida.Future<List<_ir4mnztf.BackgroundData>> getAll() =>
      caller.callServerEndpoint<List<_ir4mnztf.BackgroundData>>(
        'backgroundData',
        'getAll',
        {},
      );

  _ida.Future<_idzaasxu.BackgroundStepView> getStepView(int backgroundId) =>
      caller.callServerEndpoint<_idzaasxu.BackgroundStepView>(
        'backgroundData',
        'getStepView',
        {'backgroundId': backgroundId},
      );

  _ida.Future<_ir4mnztf.BackgroundData> add(
    _ir4mnztf.BackgroundData background,
  ) => caller.callServerEndpoint<_ir4mnztf.BackgroundData>(
    'backgroundData',
    'add',
    {'background': background},
  );

  _ida.Future<_ir4mnztf.BackgroundData> upsert(
    _ir4mnztf.BackgroundData background,
  ) => caller.callServerEndpoint<_ir4mnztf.BackgroundData>(
    'backgroundData',
    'upsert',
    {'background': background},
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('backgroundData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointFeatData extends _isc.EndpointRef {
  EndpointFeatData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'featData';

  _ida.Future<List<_ipq9e85u.FeatData>> getAll() => caller
      .callServerEndpoint<List<_ipq9e85u.FeatData>>('featData', 'getAll', {});

  _ida.Future<_ipq9e85u.FeatData> add(_ipq9e85u.FeatData feat) =>
      caller.callServerEndpoint<_ipq9e85u.FeatData>('featData', 'add', {
        'feat': feat,
      });

  _ida.Future<_ipq9e85u.FeatData> upsert(_ipq9e85u.FeatData feat) =>
      caller.callServerEndpoint<_ipq9e85u.FeatData>('featData', 'upsert', {
        'feat': feat,
      });

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('featData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointCharacterData extends _isc.EndpointRef {
  EndpointCharacterData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterData';

  _ida.Future<_i0hj17rt.LevelUpPreview> previewLevelUp(
    _ing1kbql.LevelUpRequest request,
  ) => caller.callServerEndpoint<_i0hj17rt.LevelUpPreview>(
    'characterData',
    'previewLevelUp',
    {'request': request},
  );

  _ida.Future<_i82zmloj.CharacterData> applyLevelUp(
    _ing1kbql.LevelUpRequest request,
  ) => caller.callServerEndpoint<_i82zmloj.CharacterData>(
    'characterData',
    'applyLevelUp',
    {'request': request},
  );

  _ida.Future<_i4enji4f.LevelDownPreview> previewLevelDown(
    _inrz8set.LevelDownRequest request,
  ) => caller.callServerEndpoint<_i4enji4f.LevelDownPreview>(
    'characterData',
    'previewLevelDown',
    {'request': request},
  );

  _ida.Future<_i82zmloj.CharacterData> applyLevelDown(
    _inrz8set.LevelDownRequest request,
  ) => caller.callServerEndpoint<_i82zmloj.CharacterData>(
    'characterData',
    'applyLevelDown',
    {'request': request},
  );

  _ida.Future<List<_i82zmloj.CharacterData>> getAll() =>
      caller.callServerEndpoint<List<_i82zmloj.CharacterData>>(
        'characterData',
        'getAll',
        {},
      );

  _ida.Future<_i82zmloj.CharacterData> saveCharacter(
    _i82zmloj.CharacterData character,
  ) => caller.callServerEndpoint<_i82zmloj.CharacterData>(
    'characterData',
    'saveCharacter',
    {'character': character},
  );

  _ida.Future<_ignpm0zo.CharacterSyncResult> syncSaveCharacter(
    _i82zmloj.CharacterData character,
    int? expectedVersion,
  ) => caller.callServerEndpoint<_ignpm0zo.CharacterSyncResult>(
    'characterData',
    'syncSaveCharacter',
    {'character': character, 'expectedVersion': expectedVersion},
  );

  _ida.Future<_ihk7b5q5.CharacterSyncResponse> syncCharacters(
    _ixbs72k6.CharacterSyncRequest request,
  ) => caller.callServerEndpoint<_ihk7b5q5.CharacterSyncResponse>(
    'characterData',
    'syncCharacters',
    {'request': request},
  );

  _ida.Future<_i82zmloj.CharacterData> getCharacter(int id) =>
      caller.callServerEndpoint<_i82zmloj.CharacterData>(
        'characterData',
        'getCharacter',
        {'id': id},
      );

  _ida.Future<_ignpm0zo.CharacterSyncResult> syncDeleteCharacter(
    int id,
    int? expectedVersion,
  ) => caller.callServerEndpoint<_ignpm0zo.CharacterSyncResult>(
    'characterData',
    'syncDeleteCharacter',
    {'id': id, 'expectedVersion': expectedVersion},
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('characterData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointChoiceGroupData extends _isc.EndpointRef {
  EndpointChoiceGroupData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'choiceGroupData';

  _ida.Future<List<_i44xjl6j.ChoiceGroupData>> getAll() =>
      caller.callServerEndpoint<List<_i44xjl6j.ChoiceGroupData>>(
        'choiceGroupData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointChoiceOptionData extends _isc.EndpointRef {
  EndpointChoiceOptionData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'choiceOptionData';

  _ida.Future<List<_iqcr63pm.ChoiceOptionData>> getAll() =>
      caller.callServerEndpoint<List<_iqcr63pm.ChoiceOptionData>>(
        'choiceOptionData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointClassData extends _isc.EndpointRef {
  EndpointClassData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classData';

  _ida.Future<List<_i3mngh91.ClassData>> getAll() => caller
      .callServerEndpoint<List<_i3mngh91.ClassData>>('classData', 'getAll', {});

  _ida.Future<_i3mngh91.ClassData> add(_i3mngh91.ClassData classData) =>
      caller.callServerEndpoint<_i3mngh91.ClassData>('classData', 'add', {
        'classData': classData,
      });

  _ida.Future<_i3mngh91.ClassData> upsert(_i3mngh91.ClassData classData) =>
      caller.callServerEndpoint<_i3mngh91.ClassData>('classData', 'upsert', {
        'classData': classData,
      });

  _ida.Future<_i6cvo0u4.ClassStepView> getStepView(
    int classId, {
    required int selectedLevel,
    required bool isStartingClass,
    int? selectedSubclassId,
    Map<String, int>? abilityScores,
  }) => caller
      .callServerEndpoint<_i6cvo0u4.ClassStepView>('classData', 'getStepView', {
        'classId': classId,
        'selectedLevel': selectedLevel,
        'isStartingClass': isStartingClass,
        'selectedSubclassId': selectedSubclassId,
        'abilityScores': abilityScores,
      });

  _ida.Future<_iz8eq58c.ClassSpellDeltaView> getSpellDelta(
    int classId,
    int fromLevel,
    int toLevel,
    Map<String, int> abilityScores, {
    int? selectedSubclassId,
  }) => caller.callServerEndpoint<_iz8eq58c.ClassSpellDeltaView>(
    'classData',
    'getSpellDelta',
    {
      'classId': classId,
      'fromLevel': fromLevel,
      'toLevel': toLevel,
      'abilityScores': abilityScores,
      'selectedSubclassId': selectedSubclassId,
    },
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('classData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointClassFeatureData extends _isc.EndpointRef {
  EndpointClassFeatureData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classFeatureData';

  _ida.Future<List<_iozr72e1.ClassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_iozr72e1.ClassFeatureData>>(
        'classFeatureData',
        'getAll',
        {},
      );

  _ida.Future<_iozr72e1.ClassFeatureData> add(
    _iozr72e1.ClassFeatureData item,
  ) => caller.callServerEndpoint<_iozr72e1.ClassFeatureData>(
    'classFeatureData',
    'add',
    {'item': item},
  );

  _ida.Future<_iozr72e1.ClassFeatureData> upsert(
    _iozr72e1.ClassFeatureData feature,
  ) => caller.callServerEndpoint<_iozr72e1.ClassFeatureData>(
    'classFeatureData',
    'upsert',
    {'feature': feature},
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('classFeatureData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointClassSpellGrantData extends _isc.EndpointRef {
  EndpointClassSpellGrantData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classSpellGrantData';

  _ida.Future<List<_ibq4gqkd.ClassSpellGrantData>> getAll() =>
      caller.callServerEndpoint<List<_ibq4gqkd.ClassSpellGrantData>>(
        'classSpellGrantData',
        'getAll',
        {},
      );

  _ida.Future<_ibq4gqkd.ClassSpellGrantData> add(
    _ibq4gqkd.ClassSpellGrantData item,
  ) => caller.callServerEndpoint<_ibq4gqkd.ClassSpellGrantData>(
    'classSpellGrantData',
    'add',
    {'item': item},
  );

  _ida.Future<_ibq4gqkd.ClassSpellGrantData> upsert(
    _ibq4gqkd.ClassSpellGrantData item,
  ) => caller.callServerEndpoint<_ibq4gqkd.ClassSpellGrantData>(
    'classSpellGrantData',
    'upsert',
    {'item': item},
  );

  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'classSpellGrantData',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointClassLevelData extends _isc.EndpointRef {
  EndpointClassLevelData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classLevelData';

  _ida.Future<List<_izzx945w.ClassLevelData>> getAll() =>
      caller.callServerEndpoint<List<_izzx945w.ClassLevelData>>(
        'classLevelData',
        'getAll',
        {},
      );

  _ida.Future<_izzx945w.ClassLevelData> add(_izzx945w.ClassLevelData item) =>
      caller.callServerEndpoint<_izzx945w.ClassLevelData>(
        'classLevelData',
        'add',
        {'item': item},
      );

  _ida.Future<_izzx945w.ClassLevelData> upsert(_izzx945w.ClassLevelData item) =>
      caller.callServerEndpoint<_izzx945w.ClassLevelData>(
        'classLevelData',
        'upsert',
        {'item': item},
      );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('classLevelData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointSpellSlotProgressionData extends _isc.EndpointRef {
  EndpointSpellSlotProgressionData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellSlotProgressionData';

  _ida.Future<List<_i8v86dtn.SpellSlotProgressionData>> getAll() =>
      caller.callServerEndpoint<List<_i8v86dtn.SpellSlotProgressionData>>(
        'spellSlotProgressionData',
        'getAll',
        {},
      );

  _ida.Future<_i8v86dtn.SpellSlotProgressionData> add(
    _i8v86dtn.SpellSlotProgressionData item,
  ) => caller.callServerEndpoint<_i8v86dtn.SpellSlotProgressionData>(
    'spellSlotProgressionData',
    'add',
    {'item': item},
  );

  _ida.Future<_i8v86dtn.SpellSlotProgressionData> upsert(
    _i8v86dtn.SpellSlotProgressionData item,
  ) => caller.callServerEndpoint<_i8v86dtn.SpellSlotProgressionData>(
    'spellSlotProgressionData',
    'upsert',
    {'item': item},
  );

  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'spellSlotProgressionData',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointSubclassData extends _isc.EndpointRef {
  EndpointSubclassData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassData';

  _ida.Future<List<_iuhgku0a.SubclassData>> getAll() =>
      caller.callServerEndpoint<List<_iuhgku0a.SubclassData>>(
        'subclassData',
        'getAll',
        {},
      );

  _ida.Future<_iuhgku0a.SubclassData> add(_iuhgku0a.SubclassData item) =>
      caller.callServerEndpoint<_iuhgku0a.SubclassData>('subclassData', 'add', {
        'item': item,
      });

  _ida.Future<_iuhgku0a.SubclassData> upsert(_iuhgku0a.SubclassData subclass) =>
      caller.callServerEndpoint<_iuhgku0a.SubclassData>(
        'subclassData',
        'upsert',
        {'subclass': subclass},
      );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('subclassData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointSubclassFeatureData extends _isc.EndpointRef {
  EndpointSubclassFeatureData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassFeatureData';

  _ida.Future<List<_is2mx8yv.SubclassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_is2mx8yv.SubclassFeatureData>>(
        'subclassFeatureData',
        'getAll',
        {},
      );

  _ida.Future<_is2mx8yv.SubclassFeatureData> add(
    _is2mx8yv.SubclassFeatureData item,
  ) => caller.callServerEndpoint<_is2mx8yv.SubclassFeatureData>(
    'subclassFeatureData',
    'add',
    {'item': item},
  );

  _ida.Future<_is2mx8yv.SubclassFeatureData> upsert(
    _is2mx8yv.SubclassFeatureData subclassFeature,
  ) => caller.callServerEndpoint<_is2mx8yv.SubclassFeatureData>(
    'subclassFeatureData',
    'upsert',
    {'subclassFeature': subclassFeature},
  );

  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'subclassFeatureData',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointFeatureRelationData extends _isc.EndpointRef {
  EndpointFeatureRelationData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'featureRelationData';

  _ida.Future<List<_ifrx84um.FeatureRelationData>> getAll() =>
      caller.callServerEndpoint<List<_ifrx84um.FeatureRelationData>>(
        'featureRelationData',
        'getAll',
        {},
      );
}

/// {@category Endpoint}
class EndpointRaceData extends _isc.EndpointRef {
  EndpointRaceData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceData';

  _ida.Future<List<_ilc3ntdx.RaceData>> getAll() => caller
      .callServerEndpoint<List<_ilc3ntdx.RaceData>>('raceData', 'getAll', {});

  _ida.Future<_ilc3ntdx.RaceData> add(_ilc3ntdx.RaceData race) =>
      caller.callServerEndpoint<_ilc3ntdx.RaceData>('raceData', 'add', {
        'race': race,
      });

  _ida.Future<_ilc3ntdx.RaceData> upsert(_ilc3ntdx.RaceData race) =>
      caller.callServerEndpoint<_ilc3ntdx.RaceData>('raceData', 'upsert', {
        'race': race,
      });

  _ida.Future<_ilegem88.RaceStepView> getStepView(int raceId) =>
      caller.callServerEndpoint<_ilegem88.RaceStepView>(
        'raceData',
        'getStepView',
        {'raceId': raceId},
      );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('raceData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointRaceFeature extends _isc.EndpointRef {
  EndpointRaceFeature(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceFeature';

  _ida.Future<List<_imf9k3ru.RaceFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_imf9k3ru.RaceFeatureData>>(
        'raceFeature',
        'getAll',
        {},
      );

  _ida.Future<_imf9k3ru.RaceFeatureData> add(
    _imf9k3ru.RaceFeatureData raceFeature,
  ) => caller.callServerEndpoint<_imf9k3ru.RaceFeatureData>(
    'raceFeature',
    'add',
    {'raceFeature': raceFeature},
  );

  _ida.Future<_imf9k3ru.RaceFeatureData> upsert(
    _imf9k3ru.RaceFeatureData raceFeature,
  ) => caller.callServerEndpoint<_imf9k3ru.RaceFeatureData>(
    'raceFeature',
    'upsert',
    {'raceFeature': raceFeature},
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('raceFeature', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointSubraceData extends _isc.EndpointRef {
  EndpointSubraceData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subraceData';

  _ida.Future<List<_i5ca8sk9.SubraceData>> getAll() =>
      caller.callServerEndpoint<List<_i5ca8sk9.SubraceData>>(
        'subraceData',
        'getAll',
        {},
      );

  _ida.Future<_i5ca8sk9.SubraceData> add(_i5ca8sk9.SubraceData subrace) =>
      caller.callServerEndpoint<_i5ca8sk9.SubraceData>('subraceData', 'add', {
        'subrace': subrace,
      });

  _ida.Future<_i5ca8sk9.SubraceData> upsert(_i5ca8sk9.SubraceData subrace) =>
      caller.callServerEndpoint<_i5ca8sk9.SubraceData>(
        'subraceData',
        'upsert',
        {'subrace': subrace},
      );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('subraceData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointRaceFeatureSpellGrantData extends _isc.EndpointRef {
  EndpointRaceFeatureSpellGrantData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceFeatureSpellGrantData';

  _ida.Future<List<_i9vzxbi6.RaceFeatureSpellGrantData>> getAll() =>
      caller.callServerEndpoint<List<_i9vzxbi6.RaceFeatureSpellGrantData>>(
        'raceFeatureSpellGrantData',
        'getAll',
        {},
      );

  _ida.Future<_i9vzxbi6.RaceFeatureSpellGrantData> add(
    _i9vzxbi6.RaceFeatureSpellGrantData item,
  ) => caller.callServerEndpoint<_i9vzxbi6.RaceFeatureSpellGrantData>(
    'raceFeatureSpellGrantData',
    'add',
    {'item': item},
  );

  _ida.Future<_i9vzxbi6.RaceFeatureSpellGrantData> upsert(
    _i9vzxbi6.RaceFeatureSpellGrantData item,
  ) => caller.callServerEndpoint<_i9vzxbi6.RaceFeatureSpellGrantData>(
    'raceFeatureSpellGrantData',
    'upsert',
    {'item': item},
  );

  _ida.Future<void> delete(int id) => caller.callServerEndpoint<void>(
    'raceFeatureSpellGrantData',
    'delete',
    {'id': id},
  );
}

/// {@category Endpoint}
class EndpointToolData extends _isc.EndpointRef {
  EndpointToolData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'toolData';

  _ida.Future<List<_izep6fcb.ToolData>> getAll() => caller
      .callServerEndpoint<List<_izep6fcb.ToolData>>('toolData', 'getAll', {});
}

/// {@category Endpoint}
class EndpointArmorData extends _isc.EndpointRef {
  EndpointArmorData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'armorData';

  _ida.Future<List<_i4pe33cv.ArmorData>> getAll() => caller
      .callServerEndpoint<List<_i4pe33cv.ArmorData>>('armorData', 'getAll', {});

  _ida.Future<_i4pe33cv.ArmorData> add(_i4pe33cv.ArmorData armor) =>
      caller.callServerEndpoint<_i4pe33cv.ArmorData>('armorData', 'add', {
        'armor': armor,
      });

  _ida.Future<_i4pe33cv.ArmorData> upsert(_i4pe33cv.ArmorData armor) =>
      caller.callServerEndpoint<_i4pe33cv.ArmorData>('armorData', 'upsert', {
        'armor': armor,
      });

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('armorData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointItemData extends _isc.EndpointRef {
  EndpointItemData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'itemData';

  _ida.Future<List<_iqylf6yx.ItemData>> getAll() => caller
      .callServerEndpoint<List<_iqylf6yx.ItemData>>('itemData', 'getAll', {});

  _ida.Future<_iqylf6yx.ItemData> add(_iqylf6yx.ItemData item) =>
      caller.callServerEndpoint<_iqylf6yx.ItemData>('itemData', 'add', {
        'item': item,
      });

  _ida.Future<_iqylf6yx.ItemData> upsert(_iqylf6yx.ItemData item) =>
      caller.callServerEndpoint<_iqylf6yx.ItemData>('itemData', 'upsert', {
        'item': item,
      });

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('itemData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointMagicItemData extends _isc.EndpointRef {
  EndpointMagicItemData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'magicItemData';

  _ida.Future<List<_ig7tbc7e.MagicItemData>> getAll() =>
      caller.callServerEndpoint<List<_ig7tbc7e.MagicItemData>>(
        'magicItemData',
        'getAll',
        {},
      );

  _ida.Future<_ig7tbc7e.MagicItemData> add(_ig7tbc7e.MagicItemData item) =>
      caller.callServerEndpoint<_ig7tbc7e.MagicItemData>(
        'magicItemData',
        'add',
        {'item': item},
      );

  _ida.Future<_ig7tbc7e.MagicItemData> upsert(
    _ig7tbc7e.MagicItemData magicItem,
  ) => caller.callServerEndpoint<_ig7tbc7e.MagicItemData>(
    'magicItemData',
    'upsert',
    {'magicItem': magicItem},
  );

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('magicItemData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointWeaponData extends _isc.EndpointRef {
  EndpointWeaponData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'weaponData';

  _ida.Future<List<_i5q8wx5t.WeaponData>> getAll() =>
      caller.callServerEndpoint<List<_i5q8wx5t.WeaponData>>(
        'weaponData',
        'getAll',
        {},
      );

  _ida.Future<_i5q8wx5t.WeaponData> add(_i5q8wx5t.WeaponData weapon) =>
      caller.callServerEndpoint<_i5q8wx5t.WeaponData>('weaponData', 'add', {
        'weapon': weapon,
      });

  _ida.Future<_i5q8wx5t.WeaponData> upsert(_i5q8wx5t.WeaponData weapon) =>
      caller.callServerEndpoint<_i5q8wx5t.WeaponData>('weaponData', 'upsert', {
        'weapon': weapon,
      });

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('weaponData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointSpellData extends _isc.EndpointRef {
  EndpointSpellData(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellData';

  _ida.Future<List<_ic7268ss.SpellData>> getAll() => caller
      .callServerEndpoint<List<_ic7268ss.SpellData>>('spellData', 'getAll', {});

  _ida.Future<_ic7268ss.SpellData> add(_ic7268ss.SpellData spell) =>
      caller.callServerEndpoint<_ic7268ss.SpellData>('spellData', 'add', {
        'spell': spell,
      });

  _ida.Future<_ic7268ss.SpellData> upsert(_ic7268ss.SpellData spell) =>
      caller.callServerEndpoint<_ic7268ss.SpellData>('spellData', 'upsert', {
        'spell': spell,
      });

  _ida.Future<void> delete(int id) =>
      caller.callServerEndpoint<void>('spellData', 'delete', {'id': id});
}

/// {@category Endpoint}
class EndpointPing extends _isc.EndpointRef {
  EndpointPing(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ping';

  _ida.Future<bool> ping() =>
      caller.callServerEndpoint<bool>('ping', 'ping', {});
}

class Modules {
  Modules(Client client) {
    auth = _i312scxx.Caller(client);
  }

  late final _i312scxx.Caller auth;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(_isc.MethodCallContext, Object, StackTrace)? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    admin = EndpointAdmin(this);
    appAuth = EndpointAppAuth(this);
    characterPortrait = EndpointCharacterPortrait(this);
    dmCreature = EndpointDmCreature(this);
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
    featureRelationData = EndpointFeatureRelationData(this);
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

  late final EndpointDmCreature dmCreature;

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

  late final EndpointFeatureRelationData featureRelationData;

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
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'appAuth': appAuth,
    'characterPortrait': characterPortrait,
    'dmCreature': dmCreature,
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
    'featureRelationData': featureRelationData,
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
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
