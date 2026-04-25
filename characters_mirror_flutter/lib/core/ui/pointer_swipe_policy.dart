import 'package:flutter/gestures.dart';

bool allowsSwipeNavigationForPointer(PointerDeviceKind kind) {
  return kind != PointerDeviceKind.mouse && kind != PointerDeviceKind.trackpad;
}
