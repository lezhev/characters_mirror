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
import '../endpoints/admin_endpoint.dart' as _i2;
import '../endpoints/app_auth_endpoint.dart' as _i3;
import '../endpoints/character_portrait_endpoint.dart' as _i4;
import '../endpoints/models/background_data_endpoint.dart' as _i5;
import '../endpoints/models/feat_data_endpoint.dart' as _i6;
import '../endpoints/models/general/character_data_endpoint.dart' as _i7;
import '../endpoints/models/general/choice_data_endpoint.dart' as _i8;
import '../endpoints/models/general/class_endpoints.dart' as _i9;
import '../endpoints/models/general/race_endpoints.dart' as _i10;
import '../endpoints/models/general/tool_data_endpoint.dart' as _i11;
import '../endpoints/models/items/armor_data_endpoint.dart' as _i12;
import '../endpoints/models/items/item_data_endpoint.dart' as _i13;
import '../endpoints/models/items/magic_item_endpoint.dart' as _i14;
import '../endpoints/models/items/weapon_data_endpoint.dart' as _i15;
import '../endpoints/models/spell_data_endpoint.dart' as _i16;
import '../endpoints/ping_endpoint.dart' as _i17;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i18;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i19;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i20;
import 'package:characters_mirror_server/src/generated/data/general/character/character_sync_request.dart'
    as _i21;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _i22;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i23;
import 'package:characters_mirror_server/src/generated/data/class_spell_grant_data.dart'
    as _i24;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _i25;
import 'package:characters_mirror_server/src/generated/data/general/class/spell_slot_progression_data.dart'
    as _i26;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _i27;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _i28;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _i29;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _i30;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _i31;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _i32;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _i33;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i34;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i35;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _i36;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i37;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i38;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'admin': _i2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'appAuth': _i3.AppAuthEndpoint()
        ..initialize(
          server,
          'appAuth',
          null,
        ),
      'characterPortrait': _i4.CharacterPortraitEndpoint()
        ..initialize(
          server,
          'characterPortrait',
          null,
        ),
      'backgroundData': _i5.BackgroundDataEndpoint()
        ..initialize(
          server,
          'backgroundData',
          null,
        ),
      'featData': _i6.FeatDataEndpoint()
        ..initialize(
          server,
          'featData',
          null,
        ),
      'characterData': _i7.CharacterDataEndpoint()
        ..initialize(
          server,
          'characterData',
          null,
        ),
      'choiceGroupData': _i8.ChoiceGroupDataEndpoint()
        ..initialize(
          server,
          'choiceGroupData',
          null,
        ),
      'choiceOptionData': _i8.ChoiceOptionDataEndpoint()
        ..initialize(
          server,
          'choiceOptionData',
          null,
        ),
      'classData': _i9.ClassDataEndpoint()
        ..initialize(
          server,
          'classData',
          null,
        ),
      'classFeatureData': _i9.ClassFeatureDataEndpoint()
        ..initialize(
          server,
          'classFeatureData',
          null,
        ),
      'classSpellGrantData': _i9.ClassSpellGrantDataEndpoint()
        ..initialize(
          server,
          'classSpellGrantData',
          null,
        ),
      'classLevelData': _i9.ClassLevelDataEndpoint()
        ..initialize(
          server,
          'classLevelData',
          null,
        ),
      'spellSlotProgressionData': _i9.SpellSlotProgressionDataEndpoint()
        ..initialize(
          server,
          'spellSlotProgressionData',
          null,
        ),
      'subclassData': _i9.SubclassDataEndpoint()
        ..initialize(
          server,
          'subclassData',
          null,
        ),
      'subclassFeatureData': _i9.SubclassFeatureDataEndpoint()
        ..initialize(
          server,
          'subclassFeatureData',
          null,
        ),
      'raceData': _i10.RaceDataEndpoint()
        ..initialize(
          server,
          'raceData',
          null,
        ),
      'raceFeature': _i10.RaceFeatureEndpoint()
        ..initialize(
          server,
          'raceFeature',
          null,
        ),
      'subraceData': _i10.SubraceDataEndpoint()
        ..initialize(
          server,
          'subraceData',
          null,
        ),
      'raceFeatureSpellGrantData': _i10.RaceFeatureSpellGrantDataEndpoint()
        ..initialize(
          server,
          'raceFeatureSpellGrantData',
          null,
        ),
      'toolData': _i11.ToolDataEndpoint()
        ..initialize(
          server,
          'toolData',
          null,
        ),
      'armorData': _i12.ArmorDataEndpoint()
        ..initialize(
          server,
          'armorData',
          null,
        ),
      'itemData': _i13.ItemDataEndpoint()
        ..initialize(
          server,
          'itemData',
          null,
        ),
      'magicItemData': _i14.MagicItemDataEndpoint()
        ..initialize(
          server,
          'magicItemData',
          null,
        ),
      'weaponData': _i15.WeaponDataEndpoint()
        ..initialize(
          server,
          'weaponData',
          null,
        ),
      'spellData': _i16.SpellDataEndpoint()
        ..initialize(
          server,
          'spellData',
          null,
        ),
      'ping': _i17.PingEndpoint()
        ..initialize(
          server,
          'ping',
          null,
        ),
    };
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).getAllUsers(session),
        ),
        'setAdminRole': _i1.MethodConnector(
          name: 'setAdminRole',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isAdmin': _i1.ParameterDescription(
              name: 'isAdmin',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).setAdminRole(
            session,
            params['userId'],
            params['isAdmin'],
          ),
        ),
        'importChoiceOptions': _i1.MethodConnector(
          name: 'importChoiceOptions',
          params: {
            'json': _i1.ParameterDescription(
              name: 'json',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).importChoiceOptions(
            session,
            params['json'],
          ),
        ),
        'importFeatureModifiers': _i1.MethodConnector(
          name: 'importFeatureModifiers',
          params: {
            'json': _i1.ParameterDescription(
              name: 'json',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).importFeatureModifiers(
            session,
            params['json'],
          ),
        ),
      },
    );
    connectors['appAuth'] = _i1.EndpointConnector(
      name: 'appAuth',
      endpoint: endpoints['appAuth']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['appAuth'] as _i3.AppAuthEndpoint).register(
            session,
            params['userName'],
            params['email'],
            params['password'],
          ),
        )
      },
    );
    connectors['characterPortrait'] = _i1.EndpointConnector(
      name: 'characterPortrait',
      endpoint: endpoints['characterPortrait']!,
      methodConnectors: {
        'createUploadUrl': _i1.MethodConnector(
          name: 'createUploadUrl',
          params: {
            'characterId': _i1.ParameterDescription(
              name: 'characterId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterPortrait'] as _i4.CharacterPortraitEndpoint)
                  .createUploadUrl(
            session,
            params['characterId'],
          ),
        ),
        'confirmUpload': _i1.MethodConnector(
          name: 'confirmUpload',
          params: {
            'characterId': _i1.ParameterDescription(
              name: 'characterId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterPortrait'] as _i4.CharacterPortraitEndpoint)
                  .confirmUpload(
            session,
            params['characterId'],
          ),
        ),
        'getUrl': _i1.MethodConnector(
          name: 'getUrl',
          params: {
            'characterId': _i1.ParameterDescription(
              name: 'characterId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterPortrait'] as _i4.CharacterPortraitEndpoint)
                  .getUrl(
            session,
            params['characterId'],
          ),
        ),
        'deletePortrait': _i1.MethodConnector(
          name: 'deletePortrait',
          params: {
            'characterId': _i1.ParameterDescription(
              name: 'characterId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterPortrait'] as _i4.CharacterPortraitEndpoint)
                  .deletePortrait(
            session,
            params['characterId'],
          ),
        ),
      },
    );
    connectors['backgroundData'] = _i1.EndpointConnector(
      name: 'backgroundData',
      endpoint: endpoints['backgroundData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint)
                  .getAll(session),
        ),
        'getStepView': _i1.MethodConnector(
          name: 'getStepView',
          params: {
            'backgroundId': _i1.ParameterDescription(
              name: 'backgroundId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint)
                  .getStepView(
            session,
            params['backgroundId'],
          ),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i18.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint).add(
            session,
            params['background'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i18.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint)
                  .upsert(
            session,
            params['background'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['featData'] = _i1.EndpointConnector(
      name: 'featData',
      endpoint: endpoints['featData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i6.FeatDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i19.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i6.FeatDataEndpoint).add(
            session,
            params['feat'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i19.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i6.FeatDataEndpoint).upsert(
            session,
            params['feat'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i6.FeatDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['characterData'] = _i1.EndpointConnector(
      name: 'characterData',
      endpoint: endpoints['characterData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .getAll(session),
        ),
        'saveCharacter': _i1.MethodConnector(
          name: 'saveCharacter',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i20.CharacterData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .saveCharacter(
            session,
            params['character'],
          ),
        ),
        'syncSaveCharacter': _i1.MethodConnector(
          name: 'syncSaveCharacter',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i20.CharacterData>(),
              nullable: false,
            ),
            'expectedVersion': _i1.ParameterDescription(
              name: 'expectedVersion',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .syncSaveCharacter(
            session,
            params['character'],
            params['expectedVersion'],
          ),
        ),
        'syncCharacters': _i1.MethodConnector(
          name: 'syncCharacters',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i21.CharacterSyncRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .syncCharacters(
            session,
            params['request'],
          ),
        ),
        'getCharacter': _i1.MethodConnector(
          name: 'getCharacter',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .getCharacter(
            session,
            params['id'],
          ),
        ),
        'syncDeleteCharacter': _i1.MethodConnector(
          name: 'syncDeleteCharacter',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expectedVersion': _i1.ParameterDescription(
              name: 'expectedVersion',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint)
                  .syncDeleteCharacter(
            session,
            params['id'],
            params['expectedVersion'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i7.CharacterDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['choiceGroupData'] = _i1.EndpointConnector(
      name: 'choiceGroupData',
      endpoint: endpoints['choiceGroupData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['choiceGroupData'] as _i8.ChoiceGroupDataEndpoint)
                  .getAll(session),
        )
      },
    );
    connectors['choiceOptionData'] = _i1.EndpointConnector(
      name: 'choiceOptionData',
      endpoint: endpoints['choiceOptionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['choiceOptionData'] as _i8.ChoiceOptionDataEndpoint)
                  .getAll(session),
        )
      },
    );
    connectors['classData'] = _i1.EndpointConnector(
      name: 'classData',
      endpoint: endpoints['classData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'classData': _i1.ParameterDescription(
              name: 'classData',
              type: _i1.getType<_i22.ClassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).add(
            session,
            params['classData'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'classData': _i1.ParameterDescription(
              name: 'classData',
              type: _i1.getType<_i22.ClassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).upsert(
            session,
            params['classData'],
          ),
        ),
        'getStepView': _i1.MethodConnector(
          name: 'getStepView',
          params: {
            'classId': _i1.ParameterDescription(
              name: 'classId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'selectedLevel': _i1.ParameterDescription(
              name: 'selectedLevel',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isStartingClass': _i1.ParameterDescription(
              name: 'isStartingClass',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'selectedSubclassId': _i1.ParameterDescription(
              name: 'selectedSubclassId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'abilityScores': _i1.ParameterDescription(
              name: 'abilityScores',
              type: _i1.getType<Map<String, int>?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).getStepView(
            session,
            params['classId'],
            selectedLevel: params['selectedLevel'],
            isStartingClass: params['isStartingClass'],
            selectedSubclassId: params['selectedSubclassId'],
            abilityScores: params['abilityScores'],
          ),
        ),
        'getSpellDelta': _i1.MethodConnector(
          name: 'getSpellDelta',
          params: {
            'classId': _i1.ParameterDescription(
              name: 'classId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'fromLevel': _i1.ParameterDescription(
              name: 'fromLevel',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'toLevel': _i1.ParameterDescription(
              name: 'toLevel',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'abilityScores': _i1.ParameterDescription(
              name: 'abilityScores',
              type: _i1.getType<Map<String, int>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).getSpellDelta(
            session,
            params['classId'],
            params['fromLevel'],
            params['toLevel'],
            params['abilityScores'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i9.ClassDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['classFeatureData'] = _i1.EndpointConnector(
      name: 'classFeatureData',
      endpoint: endpoints['classFeatureData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i9.ClassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i23.ClassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i9.ClassFeatureDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'feature': _i1.ParameterDescription(
              name: 'feature',
              type: _i1.getType<_i23.ClassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i9.ClassFeatureDataEndpoint)
                  .upsert(
            session,
            params['feature'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i9.ClassFeatureDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['classSpellGrantData'] = _i1.EndpointConnector(
      name: 'classSpellGrantData',
      endpoint: endpoints['classSpellGrantData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classSpellGrantData']
                      as _i9.ClassSpellGrantDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i24.ClassSpellGrantData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classSpellGrantData']
                      as _i9.ClassSpellGrantDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i24.ClassSpellGrantData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classSpellGrantData']
                      as _i9.ClassSpellGrantDataEndpoint)
                  .upsert(
            session,
            params['item'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classSpellGrantData']
                      as _i9.ClassSpellGrantDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['classLevelData'] = _i1.EndpointConnector(
      name: 'classLevelData',
      endpoint: endpoints['classLevelData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classLevelData'] as _i9.ClassLevelDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i25.ClassLevelData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classLevelData'] as _i9.ClassLevelDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i25.ClassLevelData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classLevelData'] as _i9.ClassLevelDataEndpoint)
                  .upsert(
            session,
            params['item'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classLevelData'] as _i9.ClassLevelDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['spellSlotProgressionData'] = _i1.EndpointConnector(
      name: 'spellSlotProgressionData',
      endpoint: endpoints['spellSlotProgressionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellSlotProgressionData']
                      as _i9.SpellSlotProgressionDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i26.SpellSlotProgressionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellSlotProgressionData']
                      as _i9.SpellSlotProgressionDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i26.SpellSlotProgressionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellSlotProgressionData']
                      as _i9.SpellSlotProgressionDataEndpoint)
                  .upsert(
            session,
            params['item'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellSlotProgressionData']
                      as _i9.SpellSlotProgressionDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['subclassData'] = _i1.EndpointConnector(
      name: 'subclassData',
      endpoint: endpoints['subclassData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i9.SubclassDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i27.SubclassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i9.SubclassDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'subclass': _i1.ParameterDescription(
              name: 'subclass',
              type: _i1.getType<_i27.SubclassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i9.SubclassDataEndpoint).upsert(
            session,
            params['subclass'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i9.SubclassDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['subclassFeatureData'] = _i1.EndpointConnector(
      name: 'subclassFeatureData',
      endpoint: endpoints['subclassFeatureData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i9.SubclassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i28.SubclassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i9.SubclassFeatureDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'subclassFeature': _i1.ParameterDescription(
              name: 'subclassFeature',
              type: _i1.getType<_i28.SubclassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i9.SubclassFeatureDataEndpoint)
                  .upsert(
            session,
            params['subclassFeature'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i9.SubclassFeatureDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['raceData'] = _i1.EndpointConnector(
      name: 'raceData',
      endpoint: endpoints['raceData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i10.RaceDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'race': _i1.ParameterDescription(
              name: 'race',
              type: _i1.getType<_i29.RaceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i10.RaceDataEndpoint).add(
            session,
            params['race'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'race': _i1.ParameterDescription(
              name: 'race',
              type: _i1.getType<_i29.RaceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i10.RaceDataEndpoint).upsert(
            session,
            params['race'],
          ),
        ),
        'getStepView': _i1.MethodConnector(
          name: 'getStepView',
          params: {
            'raceId': _i1.ParameterDescription(
              name: 'raceId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i10.RaceDataEndpoint).getStepView(
            session,
            params['raceId'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i10.RaceDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['raceFeature'] = _i1.EndpointConnector(
      name: 'raceFeature',
      endpoint: endpoints['raceFeature']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i10.RaceFeatureEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'raceFeature': _i1.ParameterDescription(
              name: 'raceFeature',
              type: _i1.getType<_i30.RaceFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i10.RaceFeatureEndpoint).add(
            session,
            params['raceFeature'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'raceFeature': _i1.ParameterDescription(
              name: 'raceFeature',
              type: _i1.getType<_i30.RaceFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i10.RaceFeatureEndpoint).upsert(
            session,
            params['raceFeature'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i10.RaceFeatureEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['subraceData'] = _i1.EndpointConnector(
      name: 'subraceData',
      endpoint: endpoints['subraceData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i10.SubraceDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'subrace': _i1.ParameterDescription(
              name: 'subrace',
              type: _i1.getType<_i31.SubraceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i10.SubraceDataEndpoint).add(
            session,
            params['subrace'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'subrace': _i1.ParameterDescription(
              name: 'subrace',
              type: _i1.getType<_i31.SubraceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i10.SubraceDataEndpoint).upsert(
            session,
            params['subrace'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i10.SubraceDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['raceFeatureSpellGrantData'] = _i1.EndpointConnector(
      name: 'raceFeatureSpellGrantData',
      endpoint: endpoints['raceFeatureSpellGrantData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _i10.RaceFeatureSpellGrantDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i32.RaceFeatureSpellGrantData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _i10.RaceFeatureSpellGrantDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i32.RaceFeatureSpellGrantData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _i10.RaceFeatureSpellGrantDataEndpoint)
                  .upsert(
            session,
            params['item'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _i10.RaceFeatureSpellGrantDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['toolData'] = _i1.EndpointConnector(
      name: 'toolData',
      endpoint: endpoints['toolData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['toolData'] as _i11.ToolDataEndpoint).getAll(session),
        )
      },
    );
    connectors['armorData'] = _i1.EndpointConnector(
      name: 'armorData',
      endpoint: endpoints['armorData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i12.ArmorDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i33.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i12.ArmorDataEndpoint).add(
            session,
            params['armor'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i33.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i12.ArmorDataEndpoint).upsert(
            session,
            params['armor'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i12.ArmorDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['itemData'] = _i1.EndpointConnector(
      name: 'itemData',
      endpoint: endpoints['itemData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i13.ItemDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i34.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i13.ItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i34.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i13.ItemDataEndpoint).upsert(
            session,
            params['item'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i13.ItemDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['magicItemData'] = _i1.EndpointConnector(
      name: 'magicItemData',
      endpoint: endpoints['magicItemData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i14.MagicItemDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i35.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i14.MagicItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'magicItem': _i1.ParameterDescription(
              name: 'magicItem',
              type: _i1.getType<_i35.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i14.MagicItemDataEndpoint).upsert(
            session,
            params['magicItem'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i14.MagicItemDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['weaponData'] = _i1.EndpointConnector(
      name: 'weaponData',
      endpoint: endpoints['weaponData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i15.WeaponDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i36.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i15.WeaponDataEndpoint).add(
            session,
            params['weapon'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i36.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i15.WeaponDataEndpoint).upsert(
            session,
            params['weapon'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i15.WeaponDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['spellData'] = _i1.EndpointConnector(
      name: 'spellData',
      endpoint: endpoints['spellData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i16.SpellDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i37.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i16.SpellDataEndpoint).add(
            session,
            params['spell'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i37.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i16.SpellDataEndpoint).upsert(
            session,
            params['spell'],
          ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i16.SpellDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['ping'] = _i1.EndpointConnector(
      name: 'ping',
      endpoint: endpoints['ping']!,
      methodConnectors: {
        'ping': _i1.MethodConnector(
          name: 'ping',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ping'] as _i17.PingEndpoint).ping(session),
        )
      },
    );
    modules['serverpod_auth'] = _i38.Endpoints()..initializeEndpoints(server);
  }
}
