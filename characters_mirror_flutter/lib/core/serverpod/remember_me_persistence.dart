import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

const _authenticationKeyPrefsKey = 'serverpod_authentication_key';
const _sessionPrefsKey = 'serverpod_userinfo_key';

class RememberMePersistenceController {
  RememberMePersistenceController({
    required this.keyManager,
    required this.storage,
    this.runMode = 'production',
    bool initialRememberMe = true,
  }) : _rememberMe = initialRememberMe {
    keyManager.persistenceEnabled = initialRememberMe;
    storage.persistenceEnabled = initialRememberMe;
  }

  final RememberMeAuthenticationKeyManager keyManager;
  final RememberMeStorage storage;
  final String runMode;

  bool _rememberMe;

  bool get rememberMe => _rememberMe;

  Future<void> setRememberMe(bool value) async {
    if (_rememberMe == value) {
      return;
    }

    _rememberMe = value;
    keyManager.persistenceEnabled = value;
    storage.persistenceEnabled = value;

    if (!value) {
      await Future.wait([
        keyManager.clearPersistentState(),
        storage.clearPersistedSessionState(runMode: runMode),
      ]);
    }
  }
}

class RememberMeAuthenticationKeyManager
    extends FlutterAuthenticationKeyManager {
  RememberMeAuthenticationKeyManager({
    Storage? persistentStorage,
    super.runMode = 'production',
  }) : _persistentStorage = persistentStorage ?? SharedPreferenceStorage();

  final Storage _persistentStorage;

  bool persistenceEnabled = true;
  bool _initialized = false;
  String? _authenticationKey;

  @override
  Future<String?> get() async {
    if (_initialized) {
      return _authenticationKey;
    }

    _initialized = true;

    if (!persistenceEnabled) {
      return _authenticationKey;
    }

    _authenticationKey = await _persistentStorage.getString(_persistentKey);
    return _authenticationKey;
  }

  @override
  Future<void> put(String key) async {
    _initialized = true;
    _authenticationKey = key;

    if (persistenceEnabled) {
      await _persistentStorage.setString(_persistentKey, key);
    }
  }

  @override
  Future<void> remove() async {
    _initialized = true;
    _authenticationKey = null;
    await _persistentStorage.remove(_persistentKey);
  }

  Future<void> clearPersistentState() async {
    await _persistentStorage.remove(_persistentKey);
  }

  String get persistentKey => _persistentKey;

  String get _persistentKey => '${_authenticationKeyPrefsKey}_$runMode';
}

class RememberMeStorage implements Storage {
  RememberMeStorage({
    Storage? persistentStorage,
  }) : _persistentStorage = persistentStorage ?? SharedPreferenceStorage();

  final Storage _persistentStorage;
  final Map<String, Object> _memory = {};

  bool persistenceEnabled = true;

  @override
  Future<int?> getInt(String key) async {
    if (_memory.containsKey(key)) {
      return _memory[key] as int;
    }

    if (!persistenceEnabled) {
      return null;
    }

    final value = await _persistentStorage.getInt(key);
    if (value != null) {
      _memory[key] = value;
    }

    return value;
  }

  @override
  Future<String?> getString(String key) async {
    if (_memory.containsKey(key)) {
      return _memory[key] as String;
    }

    if (!persistenceEnabled) {
      return null;
    }

    final value = await _persistentStorage.getString(key);
    if (value != null) {
      _memory[key] = value;
    }

    return value;
  }

  @override
  Future<void> remove(String key) async {
    _memory.remove(key);
    await _persistentStorage.remove(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    _memory[key] = value;

    if (persistenceEnabled) {
      await _persistentStorage.setInt(key, value);
    }
  }

  @override
  Future<void> setString(String key, String value) async {
    _memory[key] = value;

    if (persistenceEnabled) {
      await _persistentStorage.setString(key, value);
    }
  }

  Future<void> clearPersistedSessionState({
    required String runMode,
  }) async {
    for (final key in persistentSessionKeys(runMode)) {
      await _persistentStorage.remove(key);
    }
  }

  static List<String> persistentSessionKeys(String runMode) {
    return [
      '${_sessionPrefsKey}_${runMode}_version',
      '${_sessionPrefsKey}_$runMode',
    ];
  }
}
