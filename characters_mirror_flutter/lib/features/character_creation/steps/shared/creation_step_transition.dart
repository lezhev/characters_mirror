import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final creationStepTransitionDirectionProvider = StateProvider<double>(
  (ref) => 1,
);

class CreationStepTransitionScope extends InheritedWidget {
  const CreationStepTransitionScope({
    required this.animation,
    required this.secondaryAnimation,
    required super.child,
    super.key,
  });

  final Animation<double> animation;
  final Animation<double> secondaryAnimation;

  static CreationStepTransitionScope? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CreationStepTransitionScope>();
  }

  @override
  bool updateShouldNotify(CreationStepTransitionScope oldWidget) =>
      animation != oldWidget.animation ||
      secondaryAnimation != oldWidget.secondaryAnimation;
}
