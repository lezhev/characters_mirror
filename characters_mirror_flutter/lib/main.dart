import 'package:characters_mirror_flutter/core/app/characters_mirror_app.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marionette_flutter/marionette_flutter.dart';

void main() async {
  if (kDebugMode && !kIsWeb) {
    MarionetteBinding.ensureInitialized();
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  _installSafeFlutterErrorReporter();
  await initializeServerpodClient();
  runApp(const ProviderScope(child: CharactersMirrorApp()));
}

void _installSafeFlutterErrorReporter() {
  final originalOnError = FlutterError.onError;

  FlutterError.onError = (details) {
    if (kIsWeb || originalOnError == null) {
      _debugPrintFlutterErrorDetails(details);
      return;
    }

    try {
      originalOnError(details);
    } catch (reportingError, reportingStack) {
      debugPrint(
        'FlutterError reporter failed while handling: ${details.exceptionAsString()}',
      );
      debugPrint('Reporter error: $reportingError');
      _debugPrintRawStack(
        label: 'Reporter stack trace:',
        stackTrace: reportingStack,
      );
      if (details.stack != null) {
        _debugPrintRawStack(
          label: 'Original stack trace:',
          stackTrace: details.stack!,
        );
      }
      _debugPrintFlutterErrorDetails(details);
    }
  };
}

void _debugPrintFlutterErrorDetails(FlutterErrorDetails details) {
  debugPrint('Flutter error: ${details.exceptionAsString()}');

  final library = details.library;
  if (library != null && library.trim().isNotEmpty) {
    debugPrint('Library: $library');
  }

  final context = details.context;
  if (context != null) {
    debugPrint('Context: ${context.toDescription()}');
  }

  final information = details.informationCollector?.call();
  if (information != null) {
    for (final node in information) {
      final description = node.toDescription();
      if (description.trim().isEmpty) {
        continue;
      }
      debugPrint(description);
    }
  }

  if (details.stack != null) {
    _debugPrintRawStack(
      label: 'Stack trace:',
      stackTrace: details.stack!,
    );
  }
}

void _debugPrintRawStack({
  required String label,
  required StackTrace stackTrace,
}) {
  debugPrint(label);
  for (final line in stackTrace.toString().trimRight().split('\n')) {
    debugPrint(line);
  }
}
