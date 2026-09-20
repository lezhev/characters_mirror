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
import '../endpoints/import_data_endpoint.dart' as _i5;
import '../endpoints/models/background_data_endpoint.dart' as _i6;
import '../endpoints/models/feat_data_endpoint.dart' as _i7;
import '../endpoints/models/general/character_data_endpoint.dart' as _i8;
import '../endpoints/models/general/class_endpoints.dart' as _i9;
import '../endpoints/models/general/race_endpoints.dart' as _i10;
import '../endpoints/models/items/armor_data_endpoint.dart' as _i11;
import '../endpoints/models/items/item_data_endpoint.dart' as _i12;
import '../endpoints/models/items/magic_item_endpoint.dart' as _i13;
import '../endpoints/models/items/weapon_data_endpoint.dart' as _i14;
import '../endpoints/models/spell_data_endpoint.dart' as _i15;
import '../endpoints/ping_endpoint.dart' as _i16;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i17;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i18;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i19;
import 'package:characters_mirror_server/src/generated/data/general/character/character_sync_request.dart'
    as _i20;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _i21;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i22;
import 'package:characters_mirror_server/src/generated/data/class_spell_grant_data.dart'
    as _i23;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _i24;
import 'package:characters_mirror_server/src/generated/data/general/class/spell_slot_progression_data.dart'
    as _i25;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _i26;
import 'package:characters_mirror_server/src/generated/data/general/class/class_choice_group_data.dart'
    as _i27;
import 'package:characters_mirror_server/src/generated/data/general/class/class_choice_option_data.dart'
    as _i28;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _i29;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _i30;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _i31;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _i32;
import 'package:characters_mirror_server/src/generated/data/general/race/race_choice_set_data.dart'
    as _i33;
import 'package:characters_mirror_server/src/generated/data/general/race/race_choice_option_data.dart'
    as _i34;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _i35;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _i36;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i37;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i38;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _i39;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i40;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i41;

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
      'referenceData': _i5.ReferenceDataEndpoint()
        ..initialize(
          server,
          'referenceData',
          null,
        ),
      'backgroundData': _i6.BackgroundDataEndpoint()
        ..initialize(
          server,
          'backgroundData',
          null,
        ),
      'featData': _i7.FeatDataEndpoint()
        ..initialize(
          server,
          'featData',
          null,
        ),
      'characterData': _i8.CharacterDataEndpoint()
        ..initialize(
          server,
          'characterData',
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
      'classChoiceGroupData': _i9.ClassChoiceGroupDataEndpoint()
        ..initialize(
          server,
          'classChoiceGroupData',
          null,
        ),
      'classChoiceOptionData': _i9.ClassChoiceOptionDataEndpoint()
        ..initialize(
          server,
          'classChoiceOptionData',
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
      'raceChoiceSetData': _i10.RaceChoiceSetDataEndpoint()
        ..initialize(
          server,
          'raceChoiceSetData',
          null,
        ),
      'raceChoiceOptionData': _i10.RaceChoiceOptionDataEndpoint()
        ..initialize(
          server,
          'raceChoiceOptionData',
          null,
        ),
      'raceFeatureSpellGrantData': _i10.RaceFeatureSpellGrantDataEndpoint()
        ..initialize(
          server,
          'raceFeatureSpellGrantData',
          null,
        ),
      'armorData': _i11.ArmorDataEndpoint()
        ..initialize(
          server,
          'armorData',
          null,
        ),
      'itemData': _i12.ItemDataEndpoint()
        ..initialize(
          server,
          'itemData',
          null,
        ),
      'magicItemData': _i13.MagicItemDataEndpoint()
        ..initialize(
          server,
          'magicItemData',
          null,
        ),
      'weaponData': _i14.WeaponDataEndpoint()
        ..initialize(
          server,
          'weaponData',
          null,
        ),
      'spellData': _i15.SpellDataEndpoint()
        ..initialize(
          server,
          'spellData',
          null,
        ),
      'ping': _i16.PingEndpoint()
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
    connectors['referenceData'] = _i1.EndpointConnector(
      name: 'referenceData',
      endpoint: endpoints['referenceData']!,
      methodConnectors: {
        'insertJson': _i1.MethodConnector(
          name: 'insertJson',
          params: {
            'entityType': _i1.ParameterDescription(
              name: 'entityType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'jsonString': _i1.ParameterDescription(
              name: 'jsonString',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['referenceData'] as _i5.ReferenceDataEndpoint)
                  .insertJson(
            session,
            params['entityType'],
            params['jsonString'],
          ),
        )
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
              (endpoints['backgroundData'] as _i6.BackgroundDataEndpoint)
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
              (endpoints['backgroundData'] as _i6.BackgroundDataEndpoint)
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
              type: _i1.getType<_i17.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i6.BackgroundDataEndpoint).add(
            session,
            params['background'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i17.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i6.BackgroundDataEndpoint)
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
              (endpoints['backgroundData'] as _i6.BackgroundDataEndpoint)
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
              (endpoints['featData'] as _i7.FeatDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i18.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i7.FeatDataEndpoint).add(
            session,
            params['feat'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i18.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i7.FeatDataEndpoint).upsert(
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
              (endpoints['featData'] as _i7.FeatDataEndpoint).delete(
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
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
                  .getAll(session),
        ),
        'saveCharacter': _i1.MethodConnector(
          name: 'saveCharacter',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i19.CharacterData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
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
              type: _i1.getType<_i19.CharacterData>(),
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
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
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
              type: _i1.getType<_i20.CharacterSyncRequest>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
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
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
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
              (endpoints['characterData'] as _i8.CharacterDataEndpoint)
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
              (endpoints['characterData'] as _i8.CharacterDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
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
              type: _i1.getType<_i21.ClassData>(),
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
              type: _i1.getType<_i21.ClassData>(),
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
              type: _i1.getType<_i22.ClassFeatureData>(),
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
              type: _i1.getType<_i22.ClassFeatureData>(),
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
              type: _i1.getType<_i23.ClassSpellGrantData>(),
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
              type: _i1.getType<_i23.ClassSpellGrantData>(),
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
              type: _i1.getType<_i24.ClassLevelData>(),
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
              type: _i1.getType<_i24.ClassLevelData>(),
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
              type: _i1.getType<_i25.SpellSlotProgressionData>(),
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
              type: _i1.getType<_i25.SpellSlotProgressionData>(),
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
              type: _i1.getType<_i26.SubclassData>(),
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
              type: _i1.getType<_i26.SubclassData>(),
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
    connectors['classChoiceGroupData'] = _i1.EndpointConnector(
      name: 'classChoiceGroupData',
      endpoint: endpoints['classChoiceGroupData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceGroupData']
                      as _i9.ClassChoiceGroupDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i27.ClassChoiceGroupData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceGroupData']
                      as _i9.ClassChoiceGroupDataEndpoint)
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
              type: _i1.getType<_i27.ClassChoiceGroupData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceGroupData']
                      as _i9.ClassChoiceGroupDataEndpoint)
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
              (endpoints['classChoiceGroupData']
                      as _i9.ClassChoiceGroupDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['classChoiceOptionData'] = _i1.EndpointConnector(
      name: 'classChoiceOptionData',
      endpoint: endpoints['classChoiceOptionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceOptionData']
                      as _i9.ClassChoiceOptionDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i28.ClassChoiceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceOptionData']
                      as _i9.ClassChoiceOptionDataEndpoint)
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
              type: _i1.getType<_i28.ClassChoiceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classChoiceOptionData']
                      as _i9.ClassChoiceOptionDataEndpoint)
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
              (endpoints['classChoiceOptionData']
                      as _i9.ClassChoiceOptionDataEndpoint)
                  .delete(
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
              type: _i1.getType<_i29.SubclassFeatureData>(),
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
              type: _i1.getType<_i29.SubclassFeatureData>(),
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
              type: _i1.getType<_i30.RaceData>(),
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
              type: _i1.getType<_i30.RaceData>(),
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
              type: _i1.getType<_i31.RaceFeatureData>(),
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
              type: _i1.getType<_i31.RaceFeatureData>(),
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
              type: _i1.getType<_i32.SubraceData>(),
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
              type: _i1.getType<_i32.SubraceData>(),
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
    connectors['raceChoiceSetData'] = _i1.EndpointConnector(
      name: 'raceChoiceSetData',
      endpoint: endpoints['raceChoiceSetData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceSetData'] as _i10.RaceChoiceSetDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i33.RaceChoiceSetData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceSetData'] as _i10.RaceChoiceSetDataEndpoint)
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
              type: _i1.getType<_i33.RaceChoiceSetData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceSetData'] as _i10.RaceChoiceSetDataEndpoint)
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
              (endpoints['raceChoiceSetData'] as _i10.RaceChoiceSetDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['raceChoiceOptionData'] = _i1.EndpointConnector(
      name: 'raceChoiceOptionData',
      endpoint: endpoints['raceChoiceOptionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceOptionData']
                      as _i10.RaceChoiceOptionDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i34.RaceChoiceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceOptionData']
                      as _i10.RaceChoiceOptionDataEndpoint)
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
              type: _i1.getType<_i34.RaceChoiceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceChoiceOptionData']
                      as _i10.RaceChoiceOptionDataEndpoint)
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
              (endpoints['raceChoiceOptionData']
                      as _i10.RaceChoiceOptionDataEndpoint)
                  .delete(
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
              type: _i1.getType<_i35.RaceFeatureSpellGrantData>(),
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
              type: _i1.getType<_i35.RaceFeatureSpellGrantData>(),
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
              (endpoints['armorData'] as _i11.ArmorDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i36.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i11.ArmorDataEndpoint).add(
            session,
            params['armor'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i36.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i11.ArmorDataEndpoint).upsert(
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
              (endpoints['armorData'] as _i11.ArmorDataEndpoint).delete(
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
              (endpoints['itemData'] as _i12.ItemDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i37.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i12.ItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i37.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i12.ItemDataEndpoint).upsert(
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
              (endpoints['itemData'] as _i12.ItemDataEndpoint).delete(
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
              (endpoints['magicItemData'] as _i13.MagicItemDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i38.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i13.MagicItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'magicItem': _i1.ParameterDescription(
              name: 'magicItem',
              type: _i1.getType<_i38.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i13.MagicItemDataEndpoint).upsert(
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
              (endpoints['magicItemData'] as _i13.MagicItemDataEndpoint).delete(
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
              (endpoints['weaponData'] as _i14.WeaponDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i39.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i14.WeaponDataEndpoint).add(
            session,
            params['weapon'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i39.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i14.WeaponDataEndpoint).upsert(
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
              (endpoints['weaponData'] as _i14.WeaponDataEndpoint).delete(
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
              (endpoints['spellData'] as _i15.SpellDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i40.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i15.SpellDataEndpoint).add(
            session,
            params['spell'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i40.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i15.SpellDataEndpoint).upsert(
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
              (endpoints['spellData'] as _i15.SpellDataEndpoint).delete(
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
              (endpoints['ping'] as _i16.PingEndpoint).ping(session),
        )
      },
    );
    modules['serverpod_auth'] = _i41.Endpoints()..initializeEndpoints(server);
  }
}
