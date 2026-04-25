import 'package:characters_mirror_flutter/core/ui/pointer_swipe_policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('allowsSwipeNavigationForPointer', () {
    test('allows touch input', () {
      expect(
        allowsSwipeNavigationForPointer(PointerDeviceKind.touch),
        isTrue,
      );
    });

    test('allows stylus input', () {
      expect(
        allowsSwipeNavigationForPointer(PointerDeviceKind.stylus),
        isTrue,
      );
    });

    test('blocks mouse input', () {
      expect(
        allowsSwipeNavigationForPointer(PointerDeviceKind.mouse),
        isFalse,
      );
    });

    test('blocks trackpad input', () {
      expect(
        allowsSwipeNavigationForPointer(PointerDeviceKind.trackpad),
        isFalse,
      );
    });
  });
}
