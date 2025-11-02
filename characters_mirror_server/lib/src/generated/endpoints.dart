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
import '../endpoints/dev_admin_endpoint.dart' as _i3;
import '../endpoints/import_data_endpoint.dart' as _i4;
import '../endpoints/models/background_data_endpoint.dart' as _i5;
import '../endpoints/models/general/character_data_endpoint.dart' as _i6;
import '../endpoints/models/general/class_data_endpoint.dart' as _i7;
import '../endpoints/models/general/race_data_endpoint.dart' as _i8;
import '../endpoints/models/general/subclass_data_endpoint.dart' as _i9;
import '../endpoints/models/general/subrace_data_endpoint.dart' as _i10;
import '../endpoints/models/items/item_data_endpoint.dart' as _i11;
import '../endpoints/models/items/magic_item_endpoint.dart' as _i12;
import '../endpoints/models/spell_data_endpoint.dart' as _i13;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i14;
import 'package:characters_mirror_server/src/generated/data/general/character_data.dart'
    as _i15;
import 'package:characters_mirror_server/src/generated/data/general/class_data.dart'
    as _i16;
import 'package:characters_mirror_server/src/generated/data/general/race_data.dart'
    as _i17;
import 'package:characters_mirror_server/src/generated/data/general/subclass_data.dart'
    as _i18;
import 'package:characters_mirror_server/src/generated/data/general/subrace_data.dart'
    as _i19;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i20;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i21;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i22;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i23;

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
      'devAdmin': _i3.DevAdminEndpoint()
        ..initialize(
          server,
          'devAdmin',
          null,
        ),
      'referenceData': _i4.ReferenceDataEndpoint()
        ..initialize(
          server,
          'referenceData',
          null,
        ),
      'backgroundData': _i5.BackgroundDataEndpoint()
        ..initialize(
          server,
          'backgroundData',
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
      'raceData': _i8.RaceDataEndpoint()
        ..initialize(
          server,
          'raceData',
          null,
        ),
      'subclassData': _i9.SubclassDataEndpoint()
        ..initialize(
          server,
          'subclassData',
          null,
        ),
      'subraceData': _i10.SubraceDataEndpoint()
        ..initialize(
          server,
          'subraceData',
          null,
        ),
      'itemData': _i11.ItemDataEndpoint()
        ..initialize(
          server,
          'itemData',
          null,
        ),
      'magicItemData': _i12.MagicItemDataEndpoint()
        ..initialize(
          server,
          'magicItemData',
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
    connectors['devAdmin'] = _i1.EndpointConnector(
      name: 'devAdmin',
      endpoint: endpoints['devAdmin']!,
      methodConnectors: {
        'giveAdmin': _i1.MethodConnector(
          name: 'giveAdmin',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['devAdmin'] as _i3.DevAdminEndpoint).giveAdmin(
            session,
            params['userId'],
          ),
        )
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
              (endpoints['referenceData'] as _i4.ReferenceDataEndpoint)
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
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint)
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
              (endpoints['backgroundData'] as _i5.BackgroundDataEndpoint).add(
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
              type: _i1.getType<_i15.CharacterData>(),
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
              type: _i1.getType<_i16.ClassData>(),
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
              type: _i1.getType<_i17.RaceData>(),
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
              type: _i1.getType<_i18.SubclassData>(),
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
              type: _i1.getType<_i19.SubraceData>(),
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
              (endpoints['itemData'] as _i11.ItemDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i20.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i11.ItemDataEndpoint).add(
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
              (endpoints['itemData'] as _i11.ItemDataEndpoint).delete(
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
              (endpoints['magicItemData'] as _i12.MagicItemDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i21.MagicItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['magicItemData'] as _i12.MagicItemDataEndpoint).add(
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
              (endpoints['magicItemData'] as _i12.MagicItemDataEndpoint).delete(
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
              type: _i1.getType<_i22.SpellData>(),
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
    modules['serverpod_auth'] = _i23.Endpoints()..initializeEndpoints(server);
  }
}
