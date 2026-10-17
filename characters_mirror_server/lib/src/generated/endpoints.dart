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
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _ini8luu6;
import 'package:characters_mirror_server/src/generated/data/class_spell_grant_data.dart'
    as _iwivgnzd;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i77nrd14;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i7kkgt8y;
import 'package:characters_mirror_server/src/generated/data/general/character/character_sync_request.dart'
    as _ir7umbm0;
import 'package:characters_mirror_server/src/generated/data/general/character/level_up_request.dart'
    as _iy4v72iy;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _iemrti6x;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i77hkaes;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _ivbho7q1;
import 'package:characters_mirror_server/src/generated/data/general/class/spell_slot_progression_data.dart'
    as _ig2i76sa;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _ing7r6e2;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _ix0ni9v9;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _iueyhinu;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _ikrrnfpk;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _iwbrjjtm;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _iasgt0sa;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _if6xo2mf;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _ilfoaqak;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _ihxnsrg8;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _ixvqnkv0;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _iphj40lo;
import 'package:characters_mirror_server/src/generated/requests/level_down_request.dart'
    as _icgggmaw;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import '../endpoints/admin_endpoint.dart' as _i5t1w2d2;
import '../endpoints/app_auth_endpoint.dart' as _ifrhcmrx;
import '../endpoints/character_portrait_endpoint.dart' as _ixoiffvl;
import '../endpoints/dm_creature_endpoint.dart' as _iscnd3e0;
import '../endpoints/models/background_data_endpoint.dart' as _icqkusgc;
import '../endpoints/models/feat_data_endpoint.dart' as _i86a9tnp;
import '../endpoints/models/general/character_data_endpoint.dart' as _ibbm35gz;
import '../endpoints/models/general/choice_data_endpoint.dart' as _isddukuw;
import '../endpoints/models/general/class_endpoints.dart' as _ivshy1dg;
import '../endpoints/models/general/feature_relation_data_endpoint.dart'
    as _ipg03v88;
import '../endpoints/models/general/race_endpoints.dart' as _icg49013;
import '../endpoints/models/general/tool_data_endpoint.dart' as _iyer1ui6;
import '../endpoints/models/items/armor_data_endpoint.dart' as _iijydxvu;
import '../endpoints/models/items/item_data_endpoint.dart' as _i14m5fi2;
import '../endpoints/models/items/magic_item_endpoint.dart' as _ighkmgo4;
import '../endpoints/models/items/weapon_data_endpoint.dart' as _igrbep5i;
import '../endpoints/models/spell_data_endpoint.dart' as _imy61k4o;
import '../endpoints/ping_endpoint.dart' as _iyjcfifr;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'admin': _i5t1w2d2.AdminEndpoint()..initialize(server, 'admin', null),
      'appAuth': _ifrhcmrx.AppAuthEndpoint()
        ..initialize(server, 'appAuth', null),
      'characterPortrait': _ixoiffvl.CharacterPortraitEndpoint()
        ..initialize(server, 'characterPortrait', null),
      'dmCreature': _iscnd3e0.DmCreatureEndpoint()
        ..initialize(server, 'dmCreature', null),
      'backgroundData': _icqkusgc.BackgroundDataEndpoint()
        ..initialize(server, 'backgroundData', null),
      'featData': _i86a9tnp.FeatDataEndpoint()
        ..initialize(server, 'featData', null),
      'characterData': _ibbm35gz.CharacterDataEndpoint()
        ..initialize(server, 'characterData', null),
      'choiceGroupData': _isddukuw.ChoiceGroupDataEndpoint()
        ..initialize(server, 'choiceGroupData', null),
      'choiceOptionData': _isddukuw.ChoiceOptionDataEndpoint()
        ..initialize(server, 'choiceOptionData', null),
      'classData': _ivshy1dg.ClassDataEndpoint()
        ..initialize(server, 'classData', null),
      'classFeatureData': _ivshy1dg.ClassFeatureDataEndpoint()
        ..initialize(server, 'classFeatureData', null),
      'classSpellGrantData': _ivshy1dg.ClassSpellGrantDataEndpoint()
        ..initialize(server, 'classSpellGrantData', null),
      'classLevelData': _ivshy1dg.ClassLevelDataEndpoint()
        ..initialize(server, 'classLevelData', null),
      'spellSlotProgressionData': _ivshy1dg.SpellSlotProgressionDataEndpoint()
        ..initialize(server, 'spellSlotProgressionData', null),
      'subclassData': _ivshy1dg.SubclassDataEndpoint()
        ..initialize(server, 'subclassData', null),
      'subclassFeatureData': _ivshy1dg.SubclassFeatureDataEndpoint()
        ..initialize(server, 'subclassFeatureData', null),
      'featureRelationData': _ipg03v88.FeatureRelationDataEndpoint()
        ..initialize(server, 'featureRelationData', null),
      'raceData': _icg49013.RaceDataEndpoint()
        ..initialize(server, 'raceData', null),
      'raceFeature': _icg49013.RaceFeatureEndpoint()
        ..initialize(server, 'raceFeature', null),
      'subraceData': _icg49013.SubraceDataEndpoint()
        ..initialize(server, 'subraceData', null),
      'raceFeatureSpellGrantData': _icg49013.RaceFeatureSpellGrantDataEndpoint()
        ..initialize(server, 'raceFeatureSpellGrantData', null),
      'toolData': _iyer1ui6.ToolDataEndpoint()
        ..initialize(server, 'toolData', null),
      'armorData': _iijydxvu.ArmorDataEndpoint()
        ..initialize(server, 'armorData', null),
      'itemData': _i14m5fi2.ItemDataEndpoint()
        ..initialize(server, 'itemData', null),
      'magicItemData': _ighkmgo4.MagicItemDataEndpoint()
        ..initialize(server, 'magicItemData', null),
      'weaponData': _igrbep5i.WeaponDataEndpoint()
        ..initialize(server, 'weaponData', null),
      'spellData': _imy61k4o.SpellDataEndpoint()
        ..initialize(server, 'spellData', null),
      'ping': _iyjcfifr.PingEndpoint()..initialize(server, 'ping', null),
    };
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'getAllUsers': _is.MethodConnector(
          name: 'getAllUsers',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).getAllUsers(
                session,
              ),
        ),
        'setAdminRole': _is.MethodConnector(
          name: 'setAdminRole',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isAdmin': _is.ParameterDescription(
              name: 'isAdmin',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).setAdminRole(
                session,
                params['userId'],
                params['isAdmin'],
              ),
        ),
        'setGmRole': _is.MethodConnector(
          name: 'setGmRole',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isGm': _is.ParameterDescription(
              name: 'isGm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i5t1w2d2.AdminEndpoint).setGmRole(
                session,
                params['userId'],
                params['isGm'],
              ),
        ),
        'importChoiceOptions': _is.MethodConnector(
          name: 'importChoiceOptions',
          params: {
            'json': _is.ParameterDescription(
              name: 'json',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .importChoiceOptions(session, params['json']),
        ),
        'importFeatureModifiers': _is.MethodConnector(
          name: 'importFeatureModifiers',
          params: {
            'json': _is.ParameterDescription(
              name: 'json',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i5t1w2d2.AdminEndpoint)
                  .importFeatureModifiers(session, params['json']),
        ),
      },
    );
    connectors['appAuth'] = _is.EndpointConnector(
      name: 'appAuth',
      endpoint: endpoints['appAuth']!,
      methodConnectors: {
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['appAuth'] as _ifrhcmrx.AppAuthEndpoint).register(
                session,
                params['userName'],
                params['email'],
                params['password'],
              ),
        ),
      },
    );
    connectors['characterPortrait'] = _is.EndpointConnector(
      name: 'characterPortrait',
      endpoint: endpoints['characterPortrait']!,
      methodConnectors: {
        'createUploadUrl': _is.MethodConnector(
          name: 'createUploadUrl',
          params: {
            'characterId': _is.ParameterDescription(
              name: 'characterId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterPortrait']
                      as _ixoiffvl.CharacterPortraitEndpoint)
                  .createUploadUrl(session, params['characterId']),
        ),
        'confirmUpload': _is.MethodConnector(
          name: 'confirmUpload',
          params: {
            'characterId': _is.ParameterDescription(
              name: 'characterId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterPortrait']
                      as _ixoiffvl.CharacterPortraitEndpoint)
                  .confirmUpload(session, params['characterId']),
        ),
        'getUrl': _is.MethodConnector(
          name: 'getUrl',
          params: {
            'characterId': _is.ParameterDescription(
              name: 'characterId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterPortrait']
                      as _ixoiffvl.CharacterPortraitEndpoint)
                  .getUrl(session, params['characterId']),
        ),
        'deletePortrait': _is.MethodConnector(
          name: 'deletePortrait',
          params: {
            'characterId': _is.ParameterDescription(
              name: 'characterId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterPortrait']
                      as _ixoiffvl.CharacterPortraitEndpoint)
                  .deletePortrait(session, params['characterId']),
        ),
      },
    );
    connectors['dmCreature'] = _is.EndpointConnector(
      name: 'dmCreature',
      endpoint: endpoints['dmCreature']!,
      methodConnectors: {
        'importCreature': _is.MethodConnector(
          name: 'importCreature',
          params: {
            'rawJson': _is.ParameterDescription(
              name: 'rawJson',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dmCreature'] as _iscnd3e0.DmCreatureEndpoint)
                  .importCreature(session, params['rawJson']),
        ),
        'getCreatures': _is.MethodConnector(
          name: 'getCreatures',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dmCreature'] as _iscnd3e0.DmCreatureEndpoint)
                  .getCreatures(session),
        ),
        'getCreature': _is.MethodConnector(
          name: 'getCreature',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dmCreature'] as _iscnd3e0.DmCreatureEndpoint)
                  .getCreature(session, params['id']),
        ),
        'deleteCreature': _is.MethodConnector(
          name: 'deleteCreature',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['dmCreature'] as _iscnd3e0.DmCreatureEndpoint)
                  .deleteCreature(session, params['id']),
        ),
      },
    );
    connectors['backgroundData'] = _is.EndpointConnector(
      name: 'backgroundData',
      endpoint: endpoints['backgroundData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['backgroundData'] as _icqkusgc.BackgroundDataEndpoint)
                  .getAll(session),
        ),
        'getStepView': _is.MethodConnector(
          name: 'getStepView',
          params: {
            'backgroundId': _is.ParameterDescription(
              name: 'backgroundId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['backgroundData'] as _icqkusgc.BackgroundDataEndpoint)
                  .getStepView(session, params['backgroundId']),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'background': _is.ParameterDescription(
              name: 'background',
              type: _is.getType<_ini8luu6.BackgroundData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['backgroundData'] as _icqkusgc.BackgroundDataEndpoint)
                  .add(session, params['background']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'background': _is.ParameterDescription(
              name: 'background',
              type: _is.getType<_ini8luu6.BackgroundData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['backgroundData'] as _icqkusgc.BackgroundDataEndpoint)
                  .upsert(session, params['background']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['backgroundData'] as _icqkusgc.BackgroundDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['featData'] = _is.EndpointConnector(
      name: 'featData',
      endpoint: endpoints['featData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['featData'] as _i86a9tnp.FeatDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'feat': _is.ParameterDescription(
              name: 'feat',
              type: _is.getType<_i77nrd14.FeatData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['featData'] as _i86a9tnp.FeatDataEndpoint).add(
                session,
                params['feat'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'feat': _is.ParameterDescription(
              name: 'feat',
              type: _is.getType<_i77nrd14.FeatData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['featData'] as _i86a9tnp.FeatDataEndpoint).upsert(
                session,
                params['feat'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['featData'] as _i86a9tnp.FeatDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['characterData'] = _is.EndpointConnector(
      name: 'characterData',
      endpoint: endpoints['characterData']!,
      methodConnectors: {
        'previewLevelUp': _is.MethodConnector(
          name: 'previewLevelUp',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iy4v72iy.LevelUpRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .previewLevelUp(session, params['request']),
        ),
        'applyLevelUp': _is.MethodConnector(
          name: 'applyLevelUp',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iy4v72iy.LevelUpRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .applyLevelUp(session, params['request']),
        ),
        'previewLevelDown': _is.MethodConnector(
          name: 'previewLevelDown',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_icgggmaw.LevelDownRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .previewLevelDown(session, params['request']),
        ),
        'applyLevelDown': _is.MethodConnector(
          name: 'applyLevelDown',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_icgggmaw.LevelDownRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .applyLevelDown(session, params['request']),
        ),
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .getAll(session),
        ),
        'saveCharacter': _is.MethodConnector(
          name: 'saveCharacter',
          params: {
            'character': _is.ParameterDescription(
              name: 'character',
              type: _is.getType<_i7kkgt8y.CharacterData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .saveCharacter(session, params['character']),
        ),
        'syncSaveCharacter': _is.MethodConnector(
          name: 'syncSaveCharacter',
          params: {
            'character': _is.ParameterDescription(
              name: 'character',
              type: _is.getType<_i7kkgt8y.CharacterData>(),
              nullable: false,
            ),
            'expectedVersion': _is.ParameterDescription(
              name: 'expectedVersion',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .syncSaveCharacter(
                    session,
                    params['character'],
                    params['expectedVersion'],
                  ),
        ),
        'syncCharacters': _is.MethodConnector(
          name: 'syncCharacters',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ir7umbm0.CharacterSyncRequest>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .syncCharacters(session, params['request']),
        ),
        'getCharacter': _is.MethodConnector(
          name: 'getCharacter',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .getCharacter(session, params['id']),
        ),
        'syncDeleteCharacter': _is.MethodConnector(
          name: 'syncDeleteCharacter',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'expectedVersion': _is.ParameterDescription(
              name: 'expectedVersion',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .syncDeleteCharacter(
                    session,
                    params['id'],
                    params['expectedVersion'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['characterData'] as _ibbm35gz.CharacterDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['choiceGroupData'] = _is.EndpointConnector(
      name: 'choiceGroupData',
      endpoint: endpoints['choiceGroupData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['choiceGroupData']
                      as _isddukuw.ChoiceGroupDataEndpoint)
                  .getAll(session),
        ),
      },
    );
    connectors['choiceOptionData'] = _is.EndpointConnector(
      name: 'choiceOptionData',
      endpoint: endpoints['choiceOptionData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['choiceOptionData']
                      as _isddukuw.ChoiceOptionDataEndpoint)
                  .getAll(session),
        ),
      },
    );
    connectors['classData'] = _is.EndpointConnector(
      name: 'classData',
      endpoint: endpoints['classData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'classData': _is.ParameterDescription(
              name: 'classData',
              type: _is.getType<_iemrti6x.ClassData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint).add(
                session,
                params['classData'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'classData': _is.ParameterDescription(
              name: 'classData',
              type: _is.getType<_iemrti6x.ClassData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint).upsert(
                session,
                params['classData'],
              ),
        ),
        'getStepView': _is.MethodConnector(
          name: 'getStepView',
          params: {
            'classId': _is.ParameterDescription(
              name: 'classId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'selectedLevel': _is.ParameterDescription(
              name: 'selectedLevel',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isStartingClass': _is.ParameterDescription(
              name: 'isStartingClass',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'selectedSubclassId': _is.ParameterDescription(
              name: 'selectedSubclassId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'abilityScores': _is.ParameterDescription(
              name: 'abilityScores',
              type: _is.getType<Map<String, int>?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint)
                  .getStepView(
                    session,
                    params['classId'],
                    selectedLevel: params['selectedLevel'],
                    isStartingClass: params['isStartingClass'],
                    selectedSubclassId: params['selectedSubclassId'],
                    abilityScores: params['abilityScores'],
                  ),
        ),
        'getSpellDelta': _is.MethodConnector(
          name: 'getSpellDelta',
          params: {
            'classId': _is.ParameterDescription(
              name: 'classId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'fromLevel': _is.ParameterDescription(
              name: 'fromLevel',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'toLevel': _is.ParameterDescription(
              name: 'toLevel',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'abilityScores': _is.ParameterDescription(
              name: 'abilityScores',
              type: _is.getType<Map<String, int>>(),
              nullable: false,
            ),
            'selectedSubclassId': _is.ParameterDescription(
              name: 'selectedSubclassId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint)
                  .getSpellDelta(
                    session,
                    params['classId'],
                    params['fromLevel'],
                    params['toLevel'],
                    params['abilityScores'],
                    selectedSubclassId: params['selectedSubclassId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classData'] as _ivshy1dg.ClassDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['classFeatureData'] = _is.EndpointConnector(
      name: 'classFeatureData',
      endpoint: endpoints['classFeatureData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classFeatureData']
                      as _ivshy1dg.ClassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_i77hkaes.ClassFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classFeatureData']
                      as _ivshy1dg.ClassFeatureDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'feature': _is.ParameterDescription(
              name: 'feature',
              type: _is.getType<_i77hkaes.ClassFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classFeatureData']
                      as _ivshy1dg.ClassFeatureDataEndpoint)
                  .upsert(session, params['feature']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classFeatureData']
                      as _ivshy1dg.ClassFeatureDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['classSpellGrantData'] = _is.EndpointConnector(
      name: 'classSpellGrantData',
      endpoint: endpoints['classSpellGrantData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classSpellGrantData']
                      as _ivshy1dg.ClassSpellGrantDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_iwivgnzd.ClassSpellGrantData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classSpellGrantData']
                      as _ivshy1dg.ClassSpellGrantDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_iwivgnzd.ClassSpellGrantData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classSpellGrantData']
                      as _ivshy1dg.ClassSpellGrantDataEndpoint)
                  .upsert(session, params['item']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classSpellGrantData']
                      as _ivshy1dg.ClassSpellGrantDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['classLevelData'] = _is.EndpointConnector(
      name: 'classLevelData',
      endpoint: endpoints['classLevelData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classLevelData'] as _ivshy1dg.ClassLevelDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ivbho7q1.ClassLevelData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classLevelData'] as _ivshy1dg.ClassLevelDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ivbho7q1.ClassLevelData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classLevelData'] as _ivshy1dg.ClassLevelDataEndpoint)
                  .upsert(session, params['item']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['classLevelData'] as _ivshy1dg.ClassLevelDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['spellSlotProgressionData'] = _is.EndpointConnector(
      name: 'spellSlotProgressionData',
      endpoint: endpoints['spellSlotProgressionData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellSlotProgressionData']
                      as _ivshy1dg.SpellSlotProgressionDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ig2i76sa.SpellSlotProgressionData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellSlotProgressionData']
                      as _ivshy1dg.SpellSlotProgressionDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ig2i76sa.SpellSlotProgressionData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellSlotProgressionData']
                      as _ivshy1dg.SpellSlotProgressionDataEndpoint)
                  .upsert(session, params['item']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellSlotProgressionData']
                      as _ivshy1dg.SpellSlotProgressionDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['subclassData'] = _is.EndpointConnector(
      name: 'subclassData',
      endpoint: endpoints['subclassData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassData'] as _ivshy1dg.SubclassDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ing7r6e2.SubclassData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassData'] as _ivshy1dg.SubclassDataEndpoint).add(
                session,
                params['item'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'subclass': _is.ParameterDescription(
              name: 'subclass',
              type: _is.getType<_ing7r6e2.SubclassData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassData'] as _ivshy1dg.SubclassDataEndpoint)
                  .upsert(session, params['subclass']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassData'] as _ivshy1dg.SubclassDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['subclassFeatureData'] = _is.EndpointConnector(
      name: 'subclassFeatureData',
      endpoint: endpoints['subclassFeatureData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassFeatureData']
                      as _ivshy1dg.SubclassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ix0ni9v9.SubclassFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassFeatureData']
                      as _ivshy1dg.SubclassFeatureDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'subclassFeature': _is.ParameterDescription(
              name: 'subclassFeature',
              type: _is.getType<_ix0ni9v9.SubclassFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassFeatureData']
                      as _ivshy1dg.SubclassFeatureDataEndpoint)
                  .upsert(session, params['subclassFeature']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subclassFeatureData']
                      as _ivshy1dg.SubclassFeatureDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['featureRelationData'] = _is.EndpointConnector(
      name: 'featureRelationData',
      endpoint: endpoints['featureRelationData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['featureRelationData']
                      as _ipg03v88.FeatureRelationDataEndpoint)
                  .getAll(session),
        ),
      },
    );
    connectors['raceData'] = _is.EndpointConnector(
      name: 'raceData',
      endpoint: endpoints['raceData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceData'] as _icg49013.RaceDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'race': _is.ParameterDescription(
              name: 'race',
              type: _is.getType<_iueyhinu.RaceData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceData'] as _icg49013.RaceDataEndpoint).add(
                session,
                params['race'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'race': _is.ParameterDescription(
              name: 'race',
              type: _is.getType<_iueyhinu.RaceData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceData'] as _icg49013.RaceDataEndpoint).upsert(
                session,
                params['race'],
              ),
        ),
        'getStepView': _is.MethodConnector(
          name: 'getStepView',
          params: {
            'raceId': _is.ParameterDescription(
              name: 'raceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceData'] as _icg49013.RaceDataEndpoint).getStepView(
                session,
                params['raceId'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceData'] as _icg49013.RaceDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['raceFeature'] = _is.EndpointConnector(
      name: 'raceFeature',
      endpoint: endpoints['raceFeature']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeature'] as _icg49013.RaceFeatureEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'raceFeature': _is.ParameterDescription(
              name: 'raceFeature',
              type: _is.getType<_ikrrnfpk.RaceFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeature'] as _icg49013.RaceFeatureEndpoint).add(
                session,
                params['raceFeature'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'raceFeature': _is.ParameterDescription(
              name: 'raceFeature',
              type: _is.getType<_ikrrnfpk.RaceFeatureData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeature'] as _icg49013.RaceFeatureEndpoint)
                  .upsert(session, params['raceFeature']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeature'] as _icg49013.RaceFeatureEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['subraceData'] = _is.EndpointConnector(
      name: 'subraceData',
      endpoint: endpoints['subraceData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subraceData'] as _icg49013.SubraceDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'subrace': _is.ParameterDescription(
              name: 'subrace',
              type: _is.getType<_iasgt0sa.SubraceData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subraceData'] as _icg49013.SubraceDataEndpoint).add(
                session,
                params['subrace'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'subrace': _is.ParameterDescription(
              name: 'subrace',
              type: _is.getType<_iasgt0sa.SubraceData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subraceData'] as _icg49013.SubraceDataEndpoint)
                  .upsert(session, params['subrace']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['subraceData'] as _icg49013.SubraceDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['raceFeatureSpellGrantData'] = _is.EndpointConnector(
      name: 'raceFeatureSpellGrantData',
      endpoint: endpoints['raceFeatureSpellGrantData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _icg49013.RaceFeatureSpellGrantDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_iwbrjjtm.RaceFeatureSpellGrantData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _icg49013.RaceFeatureSpellGrantDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_iwbrjjtm.RaceFeatureSpellGrantData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _icg49013.RaceFeatureSpellGrantDataEndpoint)
                  .upsert(session, params['item']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['raceFeatureSpellGrantData']
                      as _icg49013.RaceFeatureSpellGrantDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['toolData'] = _is.EndpointConnector(
      name: 'toolData',
      endpoint: endpoints['toolData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['toolData'] as _iyer1ui6.ToolDataEndpoint).getAll(
                session,
              ),
        ),
      },
    );
    connectors['armorData'] = _is.EndpointConnector(
      name: 'armorData',
      endpoint: endpoints['armorData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['armorData'] as _iijydxvu.ArmorDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'armor': _is.ParameterDescription(
              name: 'armor',
              type: _is.getType<_if6xo2mf.ArmorData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['armorData'] as _iijydxvu.ArmorDataEndpoint).add(
                session,
                params['armor'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'armor': _is.ParameterDescription(
              name: 'armor',
              type: _is.getType<_if6xo2mf.ArmorData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['armorData'] as _iijydxvu.ArmorDataEndpoint).upsert(
                session,
                params['armor'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['armorData'] as _iijydxvu.ArmorDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['itemData'] = _is.EndpointConnector(
      name: 'itemData',
      endpoint: endpoints['itemData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['itemData'] as _i14m5fi2.ItemDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ilfoaqak.ItemData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['itemData'] as _i14m5fi2.ItemDataEndpoint).add(
                session,
                params['item'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ilfoaqak.ItemData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['itemData'] as _i14m5fi2.ItemDataEndpoint).upsert(
                session,
                params['item'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['itemData'] as _i14m5fi2.ItemDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['magicItemData'] = _is.EndpointConnector(
      name: 'magicItemData',
      endpoint: endpoints['magicItemData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['magicItemData'] as _ighkmgo4.MagicItemDataEndpoint)
                  .getAll(session),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'item': _is.ParameterDescription(
              name: 'item',
              type: _is.getType<_ihxnsrg8.MagicItemData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['magicItemData'] as _ighkmgo4.MagicItemDataEndpoint)
                  .add(session, params['item']),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'magicItem': _is.ParameterDescription(
              name: 'magicItem',
              type: _is.getType<_ihxnsrg8.MagicItemData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['magicItemData'] as _ighkmgo4.MagicItemDataEndpoint)
                  .upsert(session, params['magicItem']),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['magicItemData'] as _ighkmgo4.MagicItemDataEndpoint)
                  .delete(session, params['id']),
        ),
      },
    );
    connectors['weaponData'] = _is.EndpointConnector(
      name: 'weaponData',
      endpoint: endpoints['weaponData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['weaponData'] as _igrbep5i.WeaponDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'weapon': _is.ParameterDescription(
              name: 'weapon',
              type: _is.getType<_ixvqnkv0.WeaponData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['weaponData'] as _igrbep5i.WeaponDataEndpoint).add(
                session,
                params['weapon'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'weapon': _is.ParameterDescription(
              name: 'weapon',
              type: _is.getType<_ixvqnkv0.WeaponData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['weaponData'] as _igrbep5i.WeaponDataEndpoint).upsert(
                session,
                params['weapon'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['weaponData'] as _igrbep5i.WeaponDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['spellData'] = _is.EndpointConnector(
      name: 'spellData',
      endpoint: endpoints['spellData']!,
      methodConnectors: {
        'getAll': _is.MethodConnector(
          name: 'getAll',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellData'] as _imy61k4o.SpellDataEndpoint).getAll(
                session,
              ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'spell': _is.ParameterDescription(
              name: 'spell',
              type: _is.getType<_iphj40lo.SpellData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellData'] as _imy61k4o.SpellDataEndpoint).add(
                session,
                params['spell'],
              ),
        ),
        'upsert': _is.MethodConnector(
          name: 'upsert',
          params: {
            'spell': _is.ParameterDescription(
              name: 'spell',
              type: _is.getType<_iphj40lo.SpellData>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellData'] as _imy61k4o.SpellDataEndpoint).upsert(
                session,
                params['spell'],
              ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['spellData'] as _imy61k4o.SpellDataEndpoint).delete(
                session,
                params['id'],
              ),
        ),
      },
    );
    connectors['ping'] = _is.EndpointConnector(
      name: 'ping',
      endpoint: endpoints['ping']!,
      methodConnectors: {
        'ping': _is.MethodConnector(
          name: 'ping',
          params: {},
          call: (_is.Session session, Map<String, dynamic> params) async =>
              (endpoints['ping'] as _iyjcfifr.PingEndpoint).ping(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i1n3uhu0.Endpoints()
      ..initializeEndpoints(server);
  }
}
