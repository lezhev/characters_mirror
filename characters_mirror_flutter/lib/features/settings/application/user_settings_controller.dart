import 'package:characters_mirror_flutter/features/settings/data/user_settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userSettingsRepositoryProvider = Provider<UserSettingsRepository>((ref) {
  return UserSettingsRepository();
});

final userSettingsControllerProvider =
    AsyncNotifierProvider<UserSettingsController, UserSettings>(
  UserSettingsController.new,
);

class UserSettings {
  const UserSettings({
    this.themeMode = ThemeMode.system,
  });

  final ThemeMode themeMode;

  UserSettings copyWith({
    ThemeMode? themeMode,
  }) {
    return UserSettings(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class UserSettingsController extends AsyncNotifier<UserSettings> {
  late final UserSettingsRepository _repository;

  @override
  Future<UserSettings> build() async {
    _repository = ref.watch(userSettingsRepositoryProvider);
    final themeMode = await _repository.loadThemeMode();
    return UserSettings(themeMode: themeMode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final previous = state.valueOrNull ?? const UserSettings();
    final updated = previous.copyWith(themeMode: themeMode);

    state = AsyncValue.data(updated);

    try {
      await _repository.saveThemeMode(themeMode);
    } catch (error, stackTrace) {
      state = AsyncValue.data(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
