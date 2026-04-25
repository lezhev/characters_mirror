import 'package:flutter/material.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

const userSettingsThemeModeKey = 'characters_mirror.user_settings.theme_mode';

class UserSettingsRepository {
  UserSettingsRepository({
    Storage? storage,
  }) : _storage = storage ?? SharedPreferenceStorage();

  final Storage _storage;

  Future<ThemeMode> loadThemeMode() async {
    final value = await _storage.getString(userSettingsThemeModeKey);
    return themeModeFromStorageValue(value);
  }

  Future<void> saveThemeMode(ThemeMode themeMode) {
    return _storage.setString(
      userSettingsThemeModeKey,
      themeModeToStorageValue(themeMode),
    );
  }
}

ThemeMode themeModeFromStorageValue(String? value) {
  switch (value) {
    case 'dark':
      return ThemeMode.dark;
    case 'light':
      return ThemeMode.light;
    case 'system':
    default:
      return ThemeMode.system;
  }
}

String themeModeToStorageValue(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.dark:
      return 'dark';
    case ThemeMode.light:
      return 'light';
    case ThemeMode.system:
      return 'system';
  }
}
