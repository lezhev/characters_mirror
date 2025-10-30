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
import 'package:characters_mirror_client/src/protocol/background_data.dart'
    as _i3;
import 'package:characters_mirror_client/src/protocol/general/character_data.dart'
    as _i4;
import 'package:characters_mirror_client/src/protocol/general/class_data.dart'
    as _i5;
import 'package:characters_mirror_client/src/protocol/items/item_data.dart'
    as _i6;
import 'package:characters_mirror_client/src/protocol/general/race_data.dart'
    as _i7;
import 'package:characters_mirror_client/src/protocol/spell_data.dart' as _i8;
import 'package:characters_mirror_client/src/protocol/general/subclass_data.dart'
    as _i9;
import 'package:characters_mirror_client/src/protocol/general/subrace_data.dart'
    as _i10;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i11;
import 'protocol.dart' as _i12;

/// {@category Endpoint}
class EndpointBackgroundData extends _i1.EndpointRef {
  EndpointBackgroundData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'backgroundData';

  _i2.Future<List<_i3.BackgroundData>> getAll() =>
      caller.callServerEndpoint<List<_i3.BackgroundData>>(
        'backgroundData',
        'getAll',
        {},
      );

  _i2.Future<_i3.BackgroundData> add(_i3.BackgroundData background) =>
      caller.callServerEndpoint<_i3.BackgroundData>(
        'backgroundData',
        'add',
        {'background': background},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'backgroundData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointCharacterData extends _i1.EndpointRef {
  EndpointCharacterData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterData';

  _i2.Future<List<_i4.CharacterData>> getAll() =>
      caller.callServerEndpoint<List<_i4.CharacterData>>(
        'characterData',
        'getAll',
        {},
      );

  _i2.Future<_i4.CharacterData> add(_i4.CharacterData character) =>
      caller.callServerEndpoint<_i4.CharacterData>(
        'characterData',
        'add',
        {'character': character},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'characterData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassData extends _i1.EndpointRef {
  EndpointClassData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classData';

  _i2.Future<List<_i5.ClassData>> getAll() =>
      caller.callServerEndpoint<List<_i5.ClassData>>(
        'classData',
        'getAll',
        {},
      );

  _i2.Future<_i5.ClassData> add(_i5.ClassData classData) =>
      caller.callServerEndpoint<_i5.ClassData>(
        'classData',
        'add',
        {'classData': classData},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointItemData extends _i1.EndpointRef {
  EndpointItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'itemData';

  _i2.Future<List<_i6.ItemData>> getAll() =>
      caller.callServerEndpoint<List<_i6.ItemData>>(
        'itemData',
        'getAll',
        {},
      );

  _i2.Future<_i6.ItemData> add(_i6.ItemData item) =>
      caller.callServerEndpoint<_i6.ItemData>(
        'itemData',
        'add',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'itemData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointRaceData extends _i1.EndpointRef {
  EndpointRaceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceData';

  _i2.Future<List<_i7.RaceData>> getAll() =>
      caller.callServerEndpoint<List<_i7.RaceData>>(
        'raceData',
        'getAll',
        {},
      );

  _i2.Future<_i7.RaceData> add(_i7.RaceData race) =>
      caller.callServerEndpoint<_i7.RaceData>(
        'raceData',
        'add',
        {'race': race},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'raceData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSpellData extends _i1.EndpointRef {
  EndpointSpellData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellData';

  _i2.Future<List<_i8.SpellData>> getAll() =>
      caller.callServerEndpoint<List<_i8.SpellData>>(
        'spellData',
        'getAll',
        {},
      );

  _i2.Future<_i8.SpellData> add(_i8.SpellData spell) =>
      caller.callServerEndpoint<_i8.SpellData>(
        'spellData',
        'add',
        {'spell': spell},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'spellData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubclassData extends _i1.EndpointRef {
  EndpointSubclassData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassData';

  _i2.Future<List<_i9.SubclassData>> getAll() =>
      caller.callServerEndpoint<List<_i9.SubclassData>>(
        'subclassData',
        'getAll',
        {},
      );

  _i2.Future<_i9.SubclassData> add(_i9.SubclassData item) =>
      caller.callServerEndpoint<_i9.SubclassData>(
        'subclassData',
        'add',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subclassData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubraceData extends _i1.EndpointRef {
  EndpointSubraceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subraceData';

  _i2.Future<List<_i10.SubraceData>> getAll() =>
      caller.callServerEndpoint<List<_i10.SubraceData>>(
        'subraceData',
        'getAll',
        {},
      );

  _i2.Future<_i10.SubraceData> add(_i10.SubraceData subrace) =>
      caller.callServerEndpoint<_i10.SubraceData>(
        'subraceData',
        'add',
        {'subrace': subrace},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subraceData',
        'delete',
        {'id': id},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i11.Caller(client);
  }

  late final _i11.Caller auth;
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
          _i12.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    backgroundData = EndpointBackgroundData(this);
    characterData = EndpointCharacterData(this);
    classData = EndpointClassData(this);
    itemData = EndpointItemData(this);
    raceData = EndpointRaceData(this);
    spellData = EndpointSpellData(this);
    subclassData = EndpointSubclassData(this);
    subraceData = EndpointSubraceData(this);
    modules = Modules(this);
  }

  late final EndpointBackgroundData backgroundData;

  late final EndpointCharacterData characterData;

  late final EndpointClassData classData;

  late final EndpointItemData itemData;

  late final EndpointRaceData raceData;

  late final EndpointSpellData spellData;

  late final EndpointSubclassData subclassData;

  late final EndpointSubraceData subraceData;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'backgroundData': backgroundData,
        'characterData': characterData,
        'classData': classData,
        'itemData': itemData,
        'raceData': raceData,
        'spellData': spellData,
        'subclassData': subclassData,
        'subraceData': subraceData,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
