import 'package:flutter/material.dart';

abstract class Screen<T> {
  final String route;
  final ScreenBuilder<T> screenBuilder;

  Screen(this.route, this.screenBuilder);

  Route<dynamic> screen(RouteSettings settings) {
    final arg = settings.arguments as T;
    return MaterialPageRoute(builder: (c) => screenBuilder(c, arg));
  }
}

class SimpleScreen extends Screen<Object?> {
  SimpleScreen({required String route, required WidgetBuilder builder})
      : super(route, (c, _) => builder(c));
}

class ScreenWithArguments<T> extends Screen<T> {
  ScreenWithArguments({
    required String route,
    required ScreenBuilder<T> screenBuilder,
  }) : super(route, screenBuilder);
}

class EmptyScreen implements SimpleScreen {
  @override
  String get route => throw UnimplementedError();

  @override
  ScreenBuilder get screenBuilder => throw UnimplementedError();

  @override
  Route screen(RouteSettings settings) => throw UnimplementedError();
}

typedef ScreenBuilder<T> = Widget Function(BuildContext context, T args);
