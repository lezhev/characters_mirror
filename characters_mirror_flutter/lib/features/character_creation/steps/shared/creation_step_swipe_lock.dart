import 'package:flutter_riverpod/legacy.dart';

final creationStepSwipeLockedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
