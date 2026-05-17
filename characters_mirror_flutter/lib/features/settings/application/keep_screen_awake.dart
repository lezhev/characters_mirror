import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool get isAndroidKeepScreenAwakeSupported {
  return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
}

class AndroidKeepScreenAwake {
  const AndroidKeepScreenAwake._();

  static const _channel = MethodChannel('characters_mirror/screen');

  static Future<void> setEnabled(bool enabled) async {
    if (!isAndroidKeepScreenAwakeSupported) return;
    try {
      await _channel.invokeMethod<void>('setKeepScreenOn', enabled);
    } on MissingPluginException {
      // Widget tests and non-activity embeddings may not expose the channel.
    }
  }
}

class AndroidKeepScreenAwakeApplier extends StatefulWidget {
  const AndroidKeepScreenAwakeApplier({
    required this.enabled,
    required this.child,
    super.key,
  });

  final bool enabled;
  final Widget child;

  @override
  State<AndroidKeepScreenAwakeApplier> createState() =>
      _AndroidKeepScreenAwakeApplierState();
}

class _AndroidKeepScreenAwakeApplierState
    extends State<AndroidKeepScreenAwakeApplier> {
  bool? _lastApplied;

  @override
  void initState() {
    super.initState();
    _apply();
  }

  @override
  void didUpdateWidget(AndroidKeepScreenAwakeApplier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _apply();
    }
  }

  @override
  void dispose() {
    if (_lastApplied == true) {
      unawaited(AndroidKeepScreenAwake.setEnabled(false));
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _apply() {
    if (_lastApplied == widget.enabled) return;
    _lastApplied = widget.enabled;
    unawaited(AndroidKeepScreenAwake.setEnabled(widget.enabled));
  }
}
