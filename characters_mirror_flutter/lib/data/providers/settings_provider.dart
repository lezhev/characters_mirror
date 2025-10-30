import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final bool authEnabled;

  const AppSettings({this.authEnabled = true});

  AppSettings copyWith({bool? authEnabled}) =>
      AppSettings(authEnabled: authEnabled ?? this.authEnabled);
}

final settingsProvider = StateProvider<AppSettings>((ref) {
  return const AppSettings(authEnabled: true);
});
