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
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i5;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i6;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i7;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i8;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i9;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_option_data.dart'
    as _i10;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i11;
import 'package:characters_mirror_client/src/protocol/data/general/race_data.dart'
    as _i12;
import 'package:characters_mirror_client/src/protocol/data/general/subrace_data.dart'
    as _i13;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i14;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i15;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i16;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i17;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i18;
import 'protocol.dart' as _i19;

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

  _i2.Future<_i4.BackgroundData> upsert(_i4.BackgroundData background) =>
      caller.callServerEndpoint<_i4.BackgroundData>(
        'backgroundData',
        'upsert',
        {'background': background},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'backgroundData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointFeatData extends _i1.EndpointRef {
  EndpointFeatData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'featData';

  _i2.Future<List<_i5.FeatData>> getAll() =>
      caller.callServerEndpoint<List<_i5.FeatData>>(
        'featData',
        'getAll',
        {},
      );

  _i2.Future<_i5.FeatData> add(_i5.FeatData feat) =>
      caller.callServerEndpoint<_i5.FeatData>(
        'featData',
        'add',
        {'feat': feat},
      );

  _i2.Future<_i5.FeatData> upsert(_i5.FeatData feat) =>
      caller.callServerEndpoint<_i5.FeatData>(
        'featData',
        'upsert',
        {'feat': feat},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'featData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointCharacterData extends _i1.EndpointRef {
  EndpointCharacterData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'characterData';

  _i2.Future<List<_i6.CharacterData>> getAll() =>
      caller.callServerEndpoint<List<_i6.CharacterData>>(
        'characterData',
        'getAll',
        {},
      );

  _i2.Future<_i6.CharacterData> add(_i6.CharacterData character) =>
      caller.callServerEndpoint<_i6.CharacterData>(
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

  _i2.Future<List<_i7.ClassData>> getAll() =>
      caller.callServerEndpoint<List<_i7.ClassData>>(
        'classData',
        'getAll',
        {},
      );

  _i2.Future<_i7.ClassData> add(_i7.ClassData classData) =>
      caller.callServerEndpoint<_i7.ClassData>(
        'classData',
        'add',
        {'classData': classData},
      );

  _i2.Future<_i7.ClassData> upsert(_i7.ClassData classData) =>
      caller.callServerEndpoint<_i7.ClassData>(
        'classData',
        'upsert',
        {'classData': classData},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassFeatureData extends _i1.EndpointRef {
  EndpointClassFeatureData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classFeatureData';

  _i2.Future<List<_i8.ClassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_i8.ClassFeatureData>>(
        'classFeatureData',
        'getAll',
        {},
      );

  _i2.Future<_i8.ClassFeatureData> add(_i8.ClassFeatureData item) =>
      caller.callServerEndpoint<_i8.ClassFeatureData>(
        'classFeatureData',
        'add',
        {'item': item},
      );

  _i2.Future<_i8.ClassFeatureData> upsert(_i8.ClassFeatureData feature) =>
      caller.callServerEndpoint<_i8.ClassFeatureData>(
        'classFeatureData',
        'upsert',
        {'feature': feature},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classFeatureData',
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

  _i2.Future<_i9.SubclassData> upsert(_i9.SubclassData subclass) =>
      caller.callServerEndpoint<_i9.SubclassData>(
        'subclassData',
        'upsert',
        {'subclass': subclass},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subclassData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointClassOptionData extends _i1.EndpointRef {
  EndpointClassOptionData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classOptionData';

  _i2.Future<List<_i10.ClassOptionData>> getAll() =>
      caller.callServerEndpoint<List<_i10.ClassOptionData>>(
        'classOptionData',
        'getAll',
        {},
      );

  _i2.Future<_i10.ClassOptionData> add(_i10.ClassOptionData item) =>
      caller.callServerEndpoint<_i10.ClassOptionData>(
        'classOptionData',
        'add',
        {'item': item},
      );

  _i2.Future<_i10.ClassOptionData> upsert(_i10.ClassOptionData classOption) =>
      caller.callServerEndpoint<_i10.ClassOptionData>(
        'classOptionData',
        'upsert',
        {'classOption': classOption},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'classOptionData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubclassFeatureData extends _i1.EndpointRef {
  EndpointSubclassFeatureData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subclassFeatureData';

  _i2.Future<List<_i11.SubclassFeatureData>> getAll() =>
      caller.callServerEndpoint<List<_i11.SubclassFeatureData>>(
        'subclassFeatureData',
        'getAll',
        {},
      );

  _i2.Future<_i11.SubclassFeatureData> add(_i11.SubclassFeatureData item) =>
      caller.callServerEndpoint<_i11.SubclassFeatureData>(
        'subclassFeatureData',
        'add',
        {'item': item},
      );

  _i2.Future<_i11.SubclassFeatureData> upsert(
          _i11.SubclassFeatureData subclassFeature) =>
      caller.callServerEndpoint<_i11.SubclassFeatureData>(
        'subclassFeatureData',
        'upsert',
        {'subclassFeature': subclassFeature},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subclassFeatureData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointRaceData extends _i1.EndpointRef {
  EndpointRaceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'raceData';

  _i2.Future<List<_i12.RaceData>> getAll() =>
      caller.callServerEndpoint<List<_i12.RaceData>>(
        'raceData',
        'getAll',
        {},
      );

  _i2.Future<_i12.RaceData> add(_i12.RaceData race) =>
      caller.callServerEndpoint<_i12.RaceData>(
        'raceData',
        'add',
        {'race': race},
      );

  _i2.Future<_i12.RaceData> upsert(_i12.RaceData race) =>
      caller.callServerEndpoint<_i12.RaceData>(
        'raceData',
        'upsert',
        {'race': race},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'raceData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSubraceData extends _i1.EndpointRef {
  EndpointSubraceData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subraceData';

  _i2.Future<List<_i13.SubraceData>> getAll() =>
      caller.callServerEndpoint<List<_i13.SubraceData>>(
        'subraceData',
        'getAll',
        {},
      );

  _i2.Future<_i13.SubraceData> add(_i13.SubraceData subrace) =>
      caller.callServerEndpoint<_i13.SubraceData>(
        'subraceData',
        'add',
        {'subrace': subrace},
      );

  _i2.Future<_i13.SubraceData> upsert(_i13.SubraceData subrace) =>
      caller.callServerEndpoint<_i13.SubraceData>(
        'subraceData',
        'upsert',
        {'subrace': subrace},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'subraceData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointArmorData extends _i1.EndpointRef {
  EndpointArmorData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'armorData';

  _i2.Future<List<_i14.ArmorData>> getAll() =>
      caller.callServerEndpoint<List<_i14.ArmorData>>(
        'armorData',
        'getAll',
        {},
      );

  _i2.Future<_i14.ArmorData> add(_i14.ArmorData armor) =>
      caller.callServerEndpoint<_i14.ArmorData>(
        'armorData',
        'add',
        {'armor': armor},
      );

  _i2.Future<_i14.ArmorData> upsert(_i14.ArmorData armor) =>
      caller.callServerEndpoint<_i14.ArmorData>(
        'armorData',
        'upsert',
        {'armor': armor},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'armorData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointItemData extends _i1.EndpointRef {
  EndpointItemData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'itemData';

  _i2.Future<List<_i15.ItemData>> getAll() =>
      caller.callServerEndpoint<List<_i15.ItemData>>(
        'itemData',
        'getAll',
        {},
      );

  _i2.Future<_i15.ItemData> add(_i15.ItemData item) =>
      caller.callServerEndpoint<_i15.ItemData>(
        'itemData',
        'add',
        {'item': item},
      );

  _i2.Future<_i15.ItemData> upsert(_i15.ItemData item) =>
      caller.callServerEndpoint<_i15.ItemData>(
        'itemData',
        'upsert',
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

  _i2.Future<List<_i16.MagicItemData>> getAll() =>
      caller.callServerEndpoint<List<_i16.MagicItemData>>(
        'magicItemData',
        'getAll',
        {},
      );

  _i2.Future<_i16.MagicItemData> add(_i16.MagicItemData item) =>
      caller.callServerEndpoint<_i16.MagicItemData>(
        'magicItemData',
        'add',
        {'item': item},
      );

  _i2.Future<_i16.MagicItemData> upsert(_i16.MagicItemData magicItem) =>
      caller.callServerEndpoint<_i16.MagicItemData>(
        'magicItemData',
        'upsert',
        {'magicItem': magicItem},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'magicItemData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointWeaponData extends _i1.EndpointRef {
  EndpointWeaponData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'weaponData';

  _i2.Future<List<_i17.WeaponData>> getAll() =>
      caller.callServerEndpoint<List<_i17.WeaponData>>(
        'weaponData',
        'getAll',
        {},
      );

  _i2.Future<_i17.WeaponData> add(_i17.WeaponData weapon) =>
      caller.callServerEndpoint<_i17.WeaponData>(
        'weaponData',
        'add',
        {'weapon': weapon},
      );

  _i2.Future<_i17.WeaponData> upsert(_i17.WeaponData weapon) =>
      caller.callServerEndpoint<_i17.WeaponData>(
        'weaponData',
        'upsert',
        {'weapon': weapon},
      );

  _i2.Future<void> delete(int id) => caller.callServerEndpoint<void>(
        'weaponData',
        'delete',
        {'id': id},
      );
}

/// {@category Endpoint}
class EndpointSpellData extends _i1.EndpointRef {
  EndpointSpellData(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'spellData';

  _i2.Future<List<_i18.SpellData>> getAll() =>
      caller.callServerEndpoint<List<_i18.SpellData>>(
        'spellData',
        'getAll',
        {},
      );

  _i2.Future<_i18.SpellData> add(_i18.SpellData spell) =>
      caller.callServerEndpoint<_i18.SpellData>(
        'spellData',
        'add',
        {'spell': spell},
      );

  _i2.Future<_i18.SpellData> upsert(_i18.SpellData spell) =>
      caller.callServerEndpoint<_i18.SpellData>(
        'spellData',
        'upsert',
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
          _i19.Protocol(),
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
    referenceData = EndpointReferenceData(this);
    backgroundData = EndpointBackgroundData(this);
    featData = EndpointFeatData(this);
    characterData = EndpointCharacterData(this);
    classData = EndpointClassData(this);
    classFeatureData = EndpointClassFeatureData(this);
    subclassData = EndpointSubclassData(this);
    classOptionData = EndpointClassOptionData(this);
    subclassFeatureData = EndpointSubclassFeatureData(this);
    raceData = EndpointRaceData(this);
    subraceData = EndpointSubraceData(this);
    armorData = EndpointArmorData(this);
    itemData = EndpointItemData(this);
    magicItemData = EndpointMagicItemData(this);
    weaponData = EndpointWeaponData(this);
    spellData = EndpointSpellData(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointReferenceData referenceData;

  late final EndpointBackgroundData backgroundData;

  late final EndpointFeatData featData;

  late final EndpointCharacterData characterData;

  late final EndpointClassData classData;

  late final EndpointClassFeatureData classFeatureData;

  late final EndpointSubclassData subclassData;

  late final EndpointClassOptionData classOptionData;

  late final EndpointSubclassFeatureData subclassFeatureData;

  late final EndpointRaceData raceData;

  late final EndpointSubraceData subraceData;

  late final EndpointArmorData armorData;

  late final EndpointItemData itemData;

  late final EndpointMagicItemData magicItemData;

  late final EndpointWeaponData weaponData;

  late final EndpointSpellData spellData;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'referenceData': referenceData,
        'backgroundData': backgroundData,
        'featData': featData,
        'characterData': characterData,
        'classData': classData,
        'classFeatureData': classFeatureData,
        'subclassData': subclassData,
        'classOptionData': classOptionData,
        'subclassFeatureData': subclassFeatureData,
        'raceData': raceData,
        'subraceData': subraceData,
        'armorData': armorData,
        'itemData': itemData,
        'magicItemData': magicItemData,
        'weaponData': weaponData,
        'spellData': spellData,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
