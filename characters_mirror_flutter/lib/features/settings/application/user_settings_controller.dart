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
    this.keepScreenAwake = false,
  });

  final ThemeMode themeMode;
  final bool keepScreenAwake;

  UserSettings copyWith({
    ThemeMode? themeMode,
    bool? keepScreenAwake,
  }) {
    return UserSettings(
      themeMode: themeMode ?? this.themeMode,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
    );
  }
}

class UserSettingsController extends AsyncNotifier<UserSettings> {
  late final UserSettingsRepository _repository;

  @override
  Future<UserSettings> build() async {
    _repository = ref.watch(userSettingsRepositoryProvider);
    final themeMode = await _repository.loadThemeMode();
    final keepScreenAwake = await _repository.loadKeepScreenAwake();
    return UserSettings(
      themeMode: themeMode,
      keepScreenAwake: keepScreenAwake,
    );
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

  Future<void> setKeepScreenAwake(bool value) async {
    final previous = state.valueOrNull ?? const UserSettings();
    final updated = previous.copyWith(keepScreenAwake: value);

    state = AsyncValue.data(updated);

    try {
      await _repository.saveKeepScreenAwake(value);
    } catch (error, stackTrace) {
      state = AsyncValue.data(previous);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
