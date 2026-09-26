import 'dart:io';

import 'package:serverpod/protocol.dart';
import 'package:serverpod/serverpod.dart';

const serverVerboseLoggingEnvironmentKey = 'CM_SERVER_VERBOSE_LOGGING';

const _syncEndpoint = 'characterData';
const _syncMethod = 'syncCharacters';

Future<void> configureDevelopmentLogging(
  Serverpod pod, {
  Map<String, String>? environment,
}) async {
  if (pod.runMode != ServerpodRunMode.development) return;

  final verbose = isServerVerboseLoggingEnabled(
    environment ?? Platform.environment,
  );
  final settings = buildDevelopmentRuntimeSettings(
    pod.runtimeSettings,
    verbose: verbose,
  );
  await pod.updateRuntimeSettings(settings);
}

bool isServerVerboseLoggingEnabled(Map<String, String> environment) {
  final value =
      environment[serverVerboseLoggingEnvironmentKey]?.trim().toLowerCase();
  return value == '1' || value == 'true' || value == 'yes' || value == 'on';
}

RuntimeSettings buildDevelopmentRuntimeSettings(
  RuntimeSettings current, {
  required bool verbose,
}) {
  final defaultSettings = current.logSettings.copyWith(
    logLevel: verbose ? LogLevel.debug : LogLevel.info,
    logAllSessions: true,
    logAllQueries: verbose,
    logSlowSessions: true,
    logStreamingSessionsContinuously: true,
    logSlowQueries: true,
    logFailedSessions: true,
    logFailedQueries: true,
    slowSessionDuration: 1,
    slowQueryDuration: 1,
  );

  final overrides = current.logSettingsOverrides
      .where((override) => !_isSyncPollingOverride(override))
      .map(
        (override) => override.copyWith(
          logSettings: override.logSettings.copyWith(
            logLevel: verbose ? LogLevel.debug : LogLevel.info,
            logAllQueries: verbose,
            logSlowQueries: true,
            logFailedSessions: true,
            logFailedQueries: true,
          ),
        ),
      )
      .toList();

  overrides.add(
    LogSettingsOverride(
      endpoint: _syncEndpoint,
      method: _syncMethod,
      logSettings: defaultSettings.copyWith(
        logAllSessions: verbose,
      ),
    ),
  );

  return current.copyWith(
    logSettings: defaultSettings,
    logSettingsOverrides: overrides,
  );
}

bool _isSyncPollingOverride(LogSettingsOverride override) {
  return override.module == null &&
      override.endpoint == _syncEndpoint &&
      override.method == _syncMethod;
}
