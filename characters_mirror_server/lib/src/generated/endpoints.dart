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
import '../endpoints/background_data_endpoint.dart' as _i2;
import '../endpoints/character_data_endpoint.dart' as _i3;
import '../endpoints/class_data_endpoint.dart' as _i4;
import '../endpoints/item_data_endpoint.dart' as _i5;
import '../endpoints/race_data_endpoint.dart' as _i6;
import '../endpoints/spell_data_endpoint.dart' as _i7;
import '../endpoints/subclass_data_endpoint.dart' as _i8;
import '../endpoints/subrace_data_endpoint.dart' as _i9;
import 'package:characters_mirror_server/src/generated/background_data.dart'
    as _i10;
import 'package:characters_mirror_server/src/generated/general/character_data.dart'
    as _i11;
import 'package:characters_mirror_server/src/generated/general/class_data.dart'
    as _i12;
import 'package:characters_mirror_server/src/generated/items/item_data.dart'
    as _i13;
import 'package:characters_mirror_server/src/generated/general/race_data.dart'
    as _i14;
import 'package:characters_mirror_server/src/generated/spell_data.dart' as _i15;
import 'package:characters_mirror_server/src/generated/general/subclass_data.dart'
    as _i16;
import 'package:characters_mirror_server/src/generated/general/subrace_data.dart'
    as _i17;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i18;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'backgroundData': _i2.BackgroundDataEndpoint()
        ..initialize(
          server,
          'backgroundData',
          null,
        ),
      'characterData': _i3.CharacterDataEndpoint()
        ..initialize(
          server,
          'characterData',
          null,
        ),
      'classData': _i4.ClassDataEndpoint()
        ..initialize(
          server,
          'classData',
          null,
        ),
      'itemData': _i5.ItemDataEndpoint()
        ..initialize(
          server,
          'itemData',
          null,
        ),
      'raceData': _i6.RaceDataEndpoint()
        ..initialize(
          server,
          'raceData',
          null,
        ),
      'spellData': _i7.SpellDataEndpoint()
        ..initialize(
          server,
          'spellData',
          null,
        ),
      'subclassData': _i8.SubclassDataEndpoint()
        ..initialize(
          server,
          'subclassData',
          null,
        ),
      'subraceData': _i9.SubraceDataEndpoint()
        ..initialize(
          server,
          'subraceData',
          null,
        ),
    };
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
              (endpoints['backgroundData'] as _i2.BackgroundDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'background': _i1.ParameterDescription(
              name: 'background',
              type: _i1.getType<_i10.BackgroundData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['backgroundData'] as _i2.BackgroundDataEndpoint).add(
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
              (endpoints['backgroundData'] as _i2.BackgroundDataEndpoint)
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
              (endpoints['characterData'] as _i3.CharacterDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i11.CharacterData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['characterData'] as _i3.CharacterDataEndpoint).add(
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
              (endpoints['characterData'] as _i3.CharacterDataEndpoint).delete(
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
              (endpoints['classData'] as _i4.ClassDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'classData': _i1.ParameterDescription(
              name: 'classData',
              type: _i1.getType<_i12.ClassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classData'] as _i4.ClassDataEndpoint).add(
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
              (endpoints['classData'] as _i4.ClassDataEndpoint).delete(
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
              (endpoints['itemData'] as _i5.ItemDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i13.ItemData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['itemData'] as _i5.ItemDataEndpoint).add(
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
              (endpoints['itemData'] as _i5.ItemDataEndpoint).delete(
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
              (endpoints['raceData'] as _i6.RaceDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'race': _i1.ParameterDescription(
              name: 'race',
              type: _i1.getType<_i14.RaceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['raceData'] as _i6.RaceDataEndpoint).add(
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
              (endpoints['raceData'] as _i6.RaceDataEndpoint).delete(
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
              (endpoints['spellData'] as _i7.SpellDataEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'spell': _i1.ParameterDescription(
              name: 'spell',
              type: _i1.getType<_i15.SpellData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['spellData'] as _i7.SpellDataEndpoint).add(
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
              (endpoints['spellData'] as _i7.SpellDataEndpoint).delete(
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
              (endpoints['subclassData'] as _i8.SubclassDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'item': _i1.ParameterDescription(
              name: 'item',
              type: _i1.getType<_i16.SubclassData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subclassData'] as _i8.SubclassDataEndpoint).add(
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
              (endpoints['subclassData'] as _i8.SubclassDataEndpoint).delete(
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
              (endpoints['subraceData'] as _i9.SubraceDataEndpoint)
                  .getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'subrace': _i1.ParameterDescription(
              name: 'subrace',
              type: _i1.getType<_i17.SubraceData>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subraceData'] as _i9.SubraceDataEndpoint).add(
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
              (endpoints['subraceData'] as _i9.SubraceDataEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i18.Endpoints()..initializeEndpoints(server);
  }
}
