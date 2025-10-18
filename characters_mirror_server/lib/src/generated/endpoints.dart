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
import '../endpoints/character_endpoint.dart' as _i2;
import 'package:characters_mirror_server/src/generated/character.dart' as _i3;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'character': _i2.CharacterEndpoint()
        ..initialize(
          server,
          'character',
          null,
        )
    };
    connectors['character'] = _i1.EndpointConnector(
      name: 'character',
      endpoint: endpoints['character']!,
      methodConnectors: {
        'getAll': _i1.MethodConnector(
          name: 'getAll',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['character'] as _i2.CharacterEndpoint).getAll(session),
        ),
        'add': _i1.MethodConnector(
          name: 'add',
          params: {
            'character': _i1.ParameterDescription(
              name: 'character',
              type: _i1.getType<_i3.Character>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['character'] as _i2.CharacterEndpoint).add(
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
              (endpoints['character'] as _i2.CharacterEndpoint).delete(
            session,
            params['id'],
          ),
        ),
      },
    );
  }
}
