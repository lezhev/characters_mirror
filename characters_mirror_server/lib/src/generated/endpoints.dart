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
import '../endpoints/import_data_endpoint.dart' as _i3;
import '../endpoints/models/background_data_endpoint.dart' as _i4;
import '../endpoints/models/feat_data_endpoint.dart' as _i5;
import '../endpoints/models/general/character_data_endpoint.dart' as _i6;
import '../endpoints/models/general/class_endpoints.dart' as _i7;
import '../endpoints/models/general/race_endpoints.dart' as _i8;
import '../endpoints/models/items/armor_data_endpoint.dart' as _i9;
import '../endpoints/models/items/item_data_endpoint.dart' as _i10;
import '../endpoints/models/items/magic_item_endpoint.dart' as _i11;
import '../endpoints/models/items/weapon_data_endpoint.dart' as _i12;
import '../endpoints/models/spell_data_endpoint.dart' as _i13;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i14;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i15;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i16;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _i17;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i18;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _i19;
import 'package:characters_mirror_server/src/generated/data/general/class/class_option_data.dart'
    as _i20;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _i21;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _i22;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _i23;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _i24;
import 'package:characters_mirror_server/src/generated/data/general/race/race_option_data.dart'
    as _i25;
import 'package:characters_mirror_server/src/generated/data/general/race/dragonborn_ancestry_data.dart'
    as _i26;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _i27;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i28;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i29;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _i30;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i31;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i32;

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
      'referenceData': _i3.ReferenceDataEndpoint()
        ..initialize(
          server,
          'referenceData',
          null,
        ),
      'backgroundData': _i4.BackgroundDataEndpoint()
        ..initialize(
          server,
          'backgroundData',
          null,
        ),
      'featData': _i5.FeatDataEndpoint()
        ..initialize(
          server,
          'featData',
          null,
        ),
      'characterData': _i6.CharacterDataEndpoint()
        ..initialize(
          server,
          'characterData',
          null,
        ),
      'classData': _i7.ClassDataEndpoint()
        ..initialize(
          server,
          'classData',
          null,
        ),
      'classFeatureData': _i7.ClassFeatureDataEndpoint()
        ..initialize(
          server,
          'classFeatureData',
          null,
        ),
      'subclassData': _i7.SubclassDataEndpoint()
        ..initialize(
          server,
          'subclassData',
          null,
        ),
      'classOptionData': _i7.ClassOptionDataEndpoint()
        ..initialize(
          server,
          'classOptionData',
          null,
        ),
      'subclassFeatureData': _i7.SubclassFeatureDataEndpoint()
        ..initialize(
          server,
          'subclassFeatureData',
          null,
        ),
      'raceData': _i8.RaceDataEndpoint()
        ..initialize(
          server,
          'raceData',
          null,
        ),
      'raceFeature': _i8.RaceFeatureEndpoint()
        ..initialize(
          server,
          'raceFeature',
          null,
        ),
      'subraceData': _i8.SubraceDataEndpoint()
        ..initialize(
          server,
          'subraceData',
          null,
        ),
      'raceOptionData': _i8.RaceOptionDataEndpoint()
        ..initialize(
          server,
          'raceOptionData',
          null,
        ),
      'dragonbornAncestryData': _i8.DragonbornAncestryDataEndpoint()
        ..initialize(
          server,
          'dragonbornAncestryData',
          null,
        ),
      'armorData': _i9.ArmorDataEndpoint()
        ..initialize(
          server,
          'armorData',
          null,
        ),
      'itemData': _i10.ItemDataEndpoint()
        ..initialize(
          server,
          'itemData',
          null,
        ),
      'magicItemData': _i11.MagicItemDataEndpoint()
        ..initialize(
          server,
          'magicItemData',
          null,
        ),
      'weaponData': _i12.WeaponDataEndpoint()
        ..initialize(
          server,
          'weaponData',
          null,
        ),
      'spellData': _i13.SpellDataEndpoint()
        ..initialize(
          server,
          'spellData',
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
              (endpoints['referenceData'] as _i3.ReferenceDataEndpoint)
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
              (endpoints['backgroundData'] as _i4.BackgroundDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i14.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i4.BackgroundDataEndpoint).add(
            session,
            params['background'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i14.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i4.BackgroundDataEndpoint)
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
              (endpoints['backgroundData'] as _i4.BackgroundDataEndpoint)
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
              (endpoints['featData'] as _i5.FeatDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i15.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i5.FeatDataEndpoint).add(
            session,
            params['feat'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'feat': _i1.ParameterDescription(
              name: 'feat',
              type: _i1.getType<_i15.FeatData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['featData'] as _i5.FeatDataEndpoint).upsert(
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
              (endpoints['featData'] as _i5.FeatDataEndpoint).delete(
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
              (endpoints['characterData'] as _i6.CharacterDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i16.CharacterData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i6.CharacterDataEndpoint).add(
            session,
            params['character'],
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
              (endpoints['characterData'] as _i6.CharacterDataEndpoint).delete(
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
              (endpoints['classData'] as _i7.ClassDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'classData': _i1.ParameterDescription(
              name: 'classData',
              type: _i1.getType<_i17.ClassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i7.ClassDataEndpoint).add(
            session,
            params['classData'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'classData': _i1.ParameterDescription(
              name: 'classData',
              type: _i1.getType<_i17.ClassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i7.ClassDataEndpoint).upsert(
            session,
            params['classData'],
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
              (endpoints['classData'] as _i7.ClassDataEndpoint).delete(
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
              (endpoints['classFeatureData'] as _i7.ClassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i18.ClassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i7.ClassFeatureDataEndpoint)
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
              type: _i1.getType<_i18.ClassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classFeatureData'] as _i7.ClassFeatureDataEndpoint)
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
              (endpoints['classFeatureData'] as _i7.ClassFeatureDataEndpoint)
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
              (endpoints['subclassData'] as _i7.SubclassDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i19.SubclassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i7.SubclassDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'subclass': _i1.ParameterDescription(
              name: 'subclass',
              type: _i1.getType<_i19.SubclassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i7.SubclassDataEndpoint).upsert(
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
              (endpoints['subclassData'] as _i7.SubclassDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['classOptionData'] = _i1.EndpointConnector(
      name: 'classOptionData',
      endpoint: endpoints['classOptionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classOptionData'] as _i7.ClassOptionDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i20.ClassOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classOptionData'] as _i7.ClassOptionDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'classOption': _i1.ParameterDescription(
              name: 'classOption',
              type: _i1.getType<_i20.ClassOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classOptionData'] as _i7.ClassOptionDataEndpoint)
                  .upsert(
            session,
            params['classOption'],
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
              (endpoints['classOptionData'] as _i7.ClassOptionDataEndpoint)
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
                      as _i7.SubclassFeatureDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i21.SubclassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i7.SubclassFeatureDataEndpoint)
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
              type: _i1.getType<_i21.SubclassFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassFeatureData']
                      as _i7.SubclassFeatureDataEndpoint)
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
                      as _i7.SubclassFeatureDataEndpoint)
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
              (endpoints['raceData'] as _i8.RaceDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'race': _i1.ParameterDescription(
              name: 'race',
              type: _i1.getType<_i22.RaceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i8.RaceDataEndpoint).add(
            session,
            params['race'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'race': _i1.ParameterDescription(
              name: 'race',
              type: _i1.getType<_i22.RaceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i8.RaceDataEndpoint).upsert(
            session,
            params['race'],
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
              (endpoints['raceData'] as _i8.RaceDataEndpoint).delete(
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
              (endpoints['raceFeature'] as _i8.RaceFeatureEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'raceFeature': _i1.ParameterDescription(
              name: 'raceFeature',
              type: _i1.getType<_i23.RaceFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i8.RaceFeatureEndpoint).add(
            session,
            params['raceFeature'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'raceFeature': _i1.ParameterDescription(
              name: 'raceFeature',
              type: _i1.getType<_i23.RaceFeatureData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceFeature'] as _i8.RaceFeatureEndpoint).upsert(
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
              (endpoints['raceFeature'] as _i8.RaceFeatureEndpoint).delete(
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
              (endpoints['subraceData'] as _i8.SubraceDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'subrace': _i1.ParameterDescription(
              name: 'subrace',
              type: _i1.getType<_i24.SubraceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i8.SubraceDataEndpoint).add(
            session,
            params['subrace'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'subrace': _i1.ParameterDescription(
              name: 'subrace',
              type: _i1.getType<_i24.SubraceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i8.SubraceDataEndpoint).upsert(
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
              (endpoints['subraceData'] as _i8.SubraceDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['raceOptionData'] = _i1.EndpointConnector(
      name: 'raceOptionData',
      endpoint: endpoints['raceOptionData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceOptionData'] as _i8.RaceOptionDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i25.RaceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceOptionData'] as _i8.RaceOptionDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'raceOption': _i1.ParameterDescription(
              name: 'raceOption',
              type: _i1.getType<_i25.RaceOptionData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceOptionData'] as _i8.RaceOptionDataEndpoint)
                  .upsert(
            session,
            params['raceOption'],
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
              (endpoints['raceOptionData'] as _i8.RaceOptionDataEndpoint)
                  .delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    connectors['dragonbornAncestryData'] = _i1.EndpointConnector(
      name: 'dragonbornAncestryData',
      endpoint: endpoints['dragonbornAncestryData']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dragonbornAncestryData']
                      as _i8.DragonbornAncestryDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i26.DragonbornAncestryData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dragonbornAncestryData']
                      as _i8.DragonbornAncestryDataEndpoint)
                  .add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'dragonbornAncestry': _i1.ParameterDescription(
              name: 'dragonbornAncestry',
              type: _i1.getType<_i26.DragonbornAncestryData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dragonbornAncestryData']
                      as _i8.DragonbornAncestryDataEndpoint)
                  .upsert(
            session,
            params['dragonbornAncestry'],
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
              (endpoints['dragonbornAncestryData']
                      as _i8.DragonbornAncestryDataEndpoint)
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
              (endpoints['armorData'] as _i9.ArmorDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i27.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i9.ArmorDataEndpoint).add(
            session,
            params['armor'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'armor': _i1.ParameterDescription(
              name: 'armor',
              type: _i1.getType<_i27.ArmorData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['armorData'] as _i9.ArmorDataEndpoint).upsert(
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
              (endpoints['armorData'] as _i9.ArmorDataEndpoint).delete(
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
              (endpoints['itemData'] as _i10.ItemDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i28.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i10.ItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i28.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i10.ItemDataEndpoint).upsert(
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
              (endpoints['itemData'] as _i10.ItemDataEndpoint).delete(
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
              (endpoints['magicItemData'] as _i11.MagicItemDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i29.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i11.MagicItemDataEndpoint).add(
            session,
            params['item'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'magicItem': _i1.ParameterDescription(
              name: 'magicItem',
              type: _i1.getType<_i29.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i11.MagicItemDataEndpoint).upsert(
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
              (endpoints['magicItemData'] as _i11.MagicItemDataEndpoint).delete(
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
              (endpoints['weaponData'] as _i12.WeaponDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i30.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i12.WeaponDataEndpoint).add(
            session,
            params['weapon'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'weapon': _i1.ParameterDescription(
              name: 'weapon',
              type: _i1.getType<_i30.WeaponData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['weaponData'] as _i12.WeaponDataEndpoint).upsert(
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
              (endpoints['weaponData'] as _i12.WeaponDataEndpoint).delete(
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
              (endpoints['spellData'] as _i13.SpellDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i31.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i13.SpellDataEndpoint).add(
            session,
            params['spell'],
          ),
        ),
        'upsert': _i1.MethodConnector(
          name: 'upsert',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i31.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i13.SpellDataEndpoint).upsert(
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
              (endpoints['spellData'] as _i13.SpellDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i32.Endpoints()..initializeEndpoints(server);
  }
}
