import 'dart:async';

import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';

const characterSheetAutosaveDelay = Duration(milliseconds: 500);

void runCharacterSheetSave(BuildContext context, Future<void> save) {
  unawaited(
    save.catchError((Object error, StackTrace stackTrace) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(humanReadableError(error))),
      );
    }),
  );
}

class DebouncedAutosave<T> {
  DebouncedAutosave({
    required this.delay,
    required this.save,
    required this.equals,
    this.onError,
    this.onSavingChanged,
    T? lastSaved,
  }) : _lastSaved = lastSaved;

  final Duration delay;
  final Future<void> Function(T value) save;
  final bool Function(T? left, T? right) equals;
  final void Function(Object error, StackTrace stackTrace)? onError;
  final ValueChanged<bool>? onSavingChanged;

  Timer? _timer;
  T? _lastSaved;
  T? _pending;
  bool _hasPending = false;
  bool _isSaving = false;
  bool _disposed = false;

  bool get isSaving => _isSaving;

  void updateLastSaved(T? value) {
    if (_isSaving || _hasPending) {
      return;
    }
    _lastSaved = value;
  }

  void schedule(T value) {
    if (_disposed) {
      return;
    }
    _pending = value;
    _hasPending = true;
    _timer?.cancel();
    _timer = Timer(delay, () {
      unawaited(flush());
    });
  }

  Future<void> flush() async {
    if (_disposed || _isSaving) {
      return;
    }
    _timer?.cancel();
    _timer = null;
    _setSaving(true);

    try {
      while (_hasPending && !_disposed) {
        final draft = _pending as T;
        _pending = null;
        _hasPending = false;

        if (equals(_lastSaved, draft)) {
          continue;
        }

        try {
          await save(draft);
          _lastSaved = draft;
        } catch (error, stackTrace) {
          onError?.call(error, stackTrace);
        }
      }
    } finally {
      _setSaving(false);
    }
  }

  void dispose({bool flushPending = false}) {
    _timer?.cancel();
    _timer = null;
    if (flushPending && _hasPending && !_isSaving) {
      final draft = _pending as T;
      _pending = null;
      _hasPending = false;
      if (!equals(_lastSaved, draft)) {
        unawaited(
          save(draft).then((_) {
            _lastSaved = draft;
          }).catchError((Object error, StackTrace stackTrace) {
            onError?.call(error, stackTrace);
          }),
        );
      }
    }
    _disposed = true;
  }

  void _setSaving(bool value) {
    if (_isSaving == value) {
      return;
    }
    _isSaving = value;
    if (_disposed) {
      return;
    }
    onSavingChanged?.call(value);
  }
}
