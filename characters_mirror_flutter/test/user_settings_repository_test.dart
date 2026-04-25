import 'package:characters_mirror_flutter/features/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

void main() {
  group('UserSettingsRepository', () {
    test('returns system theme mode when no value is persisted', () async {
      final repository = UserSettingsRepository(storage: _FakeStorage());

      expect(await repository.loadThemeMode(), ThemeMode.system);
    });

    test('persists and loads supported theme modes', () async {
      final storage = _FakeStorage();
      final repository = UserSettingsRepository(storage: storage);

      await repository.saveThemeMode(ThemeMode.dark);
      expect(storage.values[userSettingsThemeModeKey], 'dark');
      expect(await repository.loadThemeMode(), ThemeMode.dark);

      await repository.saveThemeMode(ThemeMode.light);
      expect(storage.values[userSettingsThemeModeKey], 'light');
      expect(await repository.loadThemeMode(), ThemeMode.light);

      await repository.saveThemeMode(ThemeMode.system);
      expect(storage.values[userSettingsThemeModeKey], 'system');
      expect(await repository.loadThemeMode(), ThemeMode.system);
    });

    test('falls back to system theme mode for unknown values', () async {
      final storage = _FakeStorage()
        ..values[userSettingsThemeModeKey] = 'sepia';
      final repository = UserSettingsRepository(storage: storage);

      expect(await repository.loadThemeMode(), ThemeMode.system);
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
