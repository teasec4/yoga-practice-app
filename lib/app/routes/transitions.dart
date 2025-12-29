import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// No transition - instant navigation
class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  FadeTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.transitionDuration = Duration.zero,
  }) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

/// No transition - instant navigation
class SlideTransitionPageFromBottom<T> extends CustomTransitionPage<T> {
  SlideTransitionPageFromBottom({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.transitionDuration = Duration.zero,
  }) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

/// No transition - instant navigation
class FadeScaleTransitionPage<T> extends CustomTransitionPage<T> {
  FadeScaleTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.transitionDuration = Duration.zero,
  }) : super(
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
