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
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i4;
import 'package:characters_mirror_client/src/protocol/data/general/character_data.dart'
    as _i5;
import 'package:characters_mirror_client/src/protocol/data/general/class_data.dart'
    as _i6;
import 'package:characters_mirror_client/src/protocol/data/general/race_data.dart'
    as _i7;
import 'package:characters_mirror_client/src/protocol/data/general/subclass_data.dart'
    as _i8;
import 'package:characters_mirror_client/src/protocol/data/general/subrace_data.dart'
    as _i9;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i10;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i11;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i12;
import 'protocol.dart' as _i13;

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
}

/// {@category Endpoint}
class EndpointDevAdmin extends _i1.EndpointRef {
  EndpointDevAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'devAdmin';

  _i2.Future<void> giveAdmin(int userId) => caller.callServerEndpoint<void>(
        'devAdmin',
        'giveAdmin',
        {'userId': userId},
      );
}

/// {@category Endpoint}
class EndpointReferenceData extends _i1.EndpointRef {
  EndpointReferenceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'referenceData';

  _i2.Future<void> insertJson(
    String entityType,
    String jsonString,
  ) =>
      caller.callServerEndpoint<void>(
        'referenceData',
        'insertJson',
        {
          'entityType': entityType,
          'jsonString': jsonString,
        },
      );
}

/// {@category Endpoint}
class EndpointBackgroundData extends _i1.EndpointRef {
  EndpointBackgroundData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'backgroundData';

  _i2.Future<List<_i4.BackgroundData>> getAll() =>
      caller.callServerEndpoint<List<_i4.BackgroundData>>(
        'backgroundData',
        'getAll',
        {},
      );

  _i2.Future<_i4.BackgroundData> add(_i4.BackgroundData background) =>
      caller.callServerEndpoint<_i4.BackgroundData>(
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

  _i2.Future<List<_i5.CharacterData>> getAll() =>
      caller.callServerEndpoint<List<_i5.CharacterData>>(
        'characterData',
        'getAll',
        {},
      );

  _i2.Future<_i5.CharacterData> add(_i5.CharacterData character) =>
      caller.callServerEndpoint<_i5.CharacterData>(
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

  _i2.Future<List<_i6.ClassData>> getAll() =>
      caller.callServerEndpoint<List<_i6.ClassData>>(
        'classData',
        'getAll',
        {},
      );

  _i2.Future<_i6.ClassData> add(_i6.ClassData classData) =>
      caller.callServerEndpoint<_i6.ClassData>(
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
class EndpointSubclassData extends _i1.EndpointRef {
  EndpointSubclassData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassData';

  _i2.Future<List<_i8.SubclassData>> getAll() =>
      caller.callServerEndpoint<List<_i8.SubclassData>>(
        'subclassData',
        'getAll',
        {},
      );

  _i2.Future<_i8.SubclassData> add(_i8.SubclassData item) =>
      caller.callServerEndpoint<_i8.SubclassData>(
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

  _i2.Future<List<_i9.SubraceData>> getAll() =>
      caller.callServerEndpoint<List<_i9.SubraceData>>(
        'subraceData',
        'getAll',
        {},
      );

  _i2.Future<_i9.SubraceData> add(_i9.SubraceData subrace) =>
      caller.callServerEndpoint<_i9.SubraceData>(
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

/// {@category Endpoint}
class EndpointItemData extends _i1.EndpointRef {
  EndpointItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'itemData';

  _i2.Future<List<_i10.ItemData>> getAll() =>
      caller.callServerEndpoint<List<_i10.ItemData>>(
        'itemData',
        'getAll',
        {},
      );

  _i2.Future<_i10.ItemData> add(_i10.ItemData item) =>
      caller.callServerEndpoint<_i10.ItemData>(
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
class EndpointMagicItemData extends _i1.EndpointRef {
  EndpointMagicItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'magicItemData';

  _i2.Future<List<_i11.MagicItemData>> getAll() =>
      caller.callServerEndpoint<List<_i11.MagicItemData>>(
        'magicItemData',
        'getAll',
        {},
      );

  _i2.Future<_i11.MagicItemData> add(_i11.MagicItemData item) =>
      caller.callServerEndpoint<_i11.MagicItemData>(
        'magicItemData',
        'add',
        {'item': item},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'magicItemData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSpellData extends _i1.EndpointRef {
  EndpointSpellData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellData';

  _i2.Future<List<_i12.SpellData>> getAll() =>
      caller.callServerEndpoint<List<_i12.SpellData>>(
        'spellData',
        'getAll',
        {},
      );

  _i2.Future<_i12.SpellData> add(_i12.SpellData spell) =>
      caller.callServerEndpoint<_i12.SpellData>(
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
          _i13.Protocol(),
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
    devAdmin = EndpointDevAdmin(this);
    referenceData = EndpointReferenceData(this);
    backgroundData = EndpointBackgroundData(this);
    characterData = EndpointCharacterData(this);
    classData = EndpointClassData(this);
    raceData = EndpointRaceData(this);
    subclassData = EndpointSubclassData(this);
    subraceData = EndpointSubraceData(this);
    itemData = EndpointItemData(this);
    magicItemData = EndpointMagicItemData(this);
    spellData = EndpointSpellData(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointDevAdmin devAdmin;

  late final EndpointReferenceData referenceData;

  late final EndpointBackgroundData backgroundData;

  late final EndpointCharacterData characterData;

  late final EndpointClassData classData;

  late final EndpointRaceData raceData;

  late final EndpointSubclassData subclassData;

  late final EndpointSubraceData subraceData;

  late final EndpointItemData itemData;

  late final EndpointMagicItemData magicItemData;

  late final EndpointSpellData spellData;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'devAdmin': devAdmin,
        'referenceData': referenceData,
        'backgroundData': backgroundData,
        'characterData': characterData,
        'classData': classData,
        'raceData': raceData,
        'subclassData': subclassData,
        'subraceData': subraceData,
        'itemData': itemData,
        'magicItemData': magicItemData,
        'spellData': spellData,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
