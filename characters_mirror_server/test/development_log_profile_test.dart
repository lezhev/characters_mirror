import 'package:characters_mirror_server/src/logging/development_log_profile.dart';
import 'package:serverpod/protocol.dart';
import 'package:test/test.dart';

void main() {
  test('normal development logging suppresses SQL and sync polling', () {
    final settings = buildDevelopmentRuntimeSettings(
      _runtimeSettings(logAllQueries: true),
      verbose: false,
    );

    expect(settings.logSettings.logLevel, LogLevel.info);
    expect(settings.logSettings.logAllSessions, isTrue);
    expect(settings.logSettings.logAllQueries, isFalse);
    expect(settings.logSettings.logSlowQueries, isTrue);
    expect(settings.logSettings.logFailedQueries, isTrue);

    final syncOverride = settings.logSettingsOverrides.singleWhere(
      (override) =>
          override.endpoint == 'characterData' &&
          override.method == 'syncCharacters',
    );
    expect(syncOverride.logSettings.logAllSessions, isFalse);
    expect(syncOverride.logSettings.logSlowSessions, isTrue);
    expect(syncOverride.logSettings.logFailedSessions, isTrue);
  });

  test('verbose development logging restores SQL and polling details', () {
    final settings = buildDevelopmentRuntimeSettings(
      _runtimeSettings(logAllQueries: false),
      verbose: true,
    );

    expect(settings.logSettings.logLevel, LogLevel.debug);
    expect(settings.logSettings.logAllQueries, isTrue);
    expect(
      settings.logSettingsOverrides.single.logSettings.logAllSessions,
      isTrue,
    );
  });

  test('verbose logging environment flag accepts explicit true values', () {
    for (final value in ['1', 'true', 'YES', ' on ']) {
      expect(
        isServerVerboseLoggingEnabled({
          serverVerboseLoggingEnvironmentKey: value,
        }),
        isTrue,
      );
    }
    expect(isServerVerboseLoggingEnabled(const {}), isFalse);
  });
}

RuntimeSettings _runtimeSettings({required bool logAllQueries}) {
  return RuntimeSettings(
    logSettings: LogSettings(
      logLevel: LogLevel.info,
      logAllSessions: true,
      logAllQueries: logAllQueries,
      logSlowSessions: true,
      logStreamingSessionsContinuously: true,
      logSlowQueries: true,
      logFailedSessions: true,
      logFailedQueries: true,
      slowSessionDuration: 1,
      slowQueryDuration: 1,
    ),
    logSettingsOverrides: const [],
    logServiceCalls: false,
    logMalformedCalls: false,
  );
}
