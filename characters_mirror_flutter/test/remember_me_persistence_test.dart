import 'package:characters_mirror_flutter/core/serverpod/remember_me_persistence.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

void main() {
  group('Remember me persistence', () {
    test('writes auth and session data to backing storage when enabled',
        () async {
      final backingStorage = _FakeStorage();
      final keyManager = RememberMeAuthenticationKeyManager(
        runMode: 'test',
        persistentStorage: backingStorage,
      );
      final rememberMeStorage = RememberMeStorage(
        persistentStorage: backingStorage,
      );

      await keyManager.put('1:secret');
      await rememberMeStorage.setInt('counter', 2);
      await rememberMeStorage.setString('hero', 'Melifaro');

      expect(backingStorage.values[keyManager.persistentKey], '1:secret');
      expect(backingStorage.values['counter'], 2);
      expect(backingStorage.values['hero'], 'Melifaro');
    });

    test('keeps auth and session data only in memory when disabled', () async {
      final backingStorage = _FakeStorage();
      final keyManager = RememberMeAuthenticationKeyManager(
        runMode: 'test',
        persistentStorage: backingStorage,
      )..persistenceEnabled = false;
      final rememberMeStorage = RememberMeStorage(
        persistentStorage: backingStorage,
      )..persistenceEnabled = false;

      await keyManager.put('1:secret');
      await rememberMeStorage.setInt('counter', 2);
      await rememberMeStorage.setString('hero', 'Melifaro');

      expect(backingStorage.values, isEmpty);
      expect(await keyManager.get(), '1:secret');
      expect(await rememberMeStorage.getInt('counter'), 2);
      expect(await rememberMeStorage.getString('hero'), 'Melifaro');
    });

    test('clears persisted state when remember me is turned off', () async {
      final backingStorage = _FakeStorage();
      final keyManager = RememberMeAuthenticationKeyManager(
        runMode: 'test',
        persistentStorage: backingStorage,
      );
      final rememberMeStorage = RememberMeStorage(
        persistentStorage: backingStorage,
      );
      final controller = RememberMePersistenceController(
        keyManager: keyManager,
        storage: rememberMeStorage,
        runMode: 'test',
      );
      final sessionKeys = RememberMeStorage.persistentSessionKeys('test');

      await keyManager.put('1:secret');
      await rememberMeStorage.setInt(sessionKeys.first, 2);
      await rememberMeStorage.setString(sessionKeys.last, 'cached-user');

      await controller.setRememberMe(false);

      expect(controller.rememberMe, isFalse);
      expect(
          backingStorage.values.containsKey(keyManager.persistentKey), isFalse);
      expect(backingStorage.values.containsKey(sessionKeys.first), isFalse);
      expect(backingStorage.values.containsKey(sessionKeys.last), isFalse);
      expect(await keyManager.get(), '1:secret');
      expect(await rememberMeStorage.getInt(sessionKeys.first), 2);
      expect(
          await rememberMeStorage.getString(sessionKeys.last), 'cached-user');
    });
  });
}

class _FakeStorage implements Storage {
  final Map<String, Object> values = {};

  @override
  Future<int?> getInt(String key) async {
    return values[key] as int?;
  }

  @override
  Future<String?> getString(String key) async {
    return values[key] as String?;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    values[key] = value;
  }

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }
}
