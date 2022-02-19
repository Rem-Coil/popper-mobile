// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const SplashScreen());
    },
    LoginRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const LoginScreen());
    },
    RegistrationRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const RegistrationScreen());
    },
    HomeRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const HomeScreen());
    },
    ScannerRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const ScannerScreen());
    },
    OperationSaveRoute.name: (routeData) {
      final args = routeData.argsAs<OperationSaveRouteArgs>();
      return CupertinoPageX<dynamic>(
          routeData: routeData,
          child: OperationSaveScreen(key: args.key, operation: args.operation));
    },
    UpdateOperationRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateOperationRouteArgs>();
      return CupertinoPageX<dynamic>(
          routeData: routeData,
          child:
              UpdateOperationScreen(key: args.key, operation: args.operation));
    },
    SimpleInfoRoute.name: (routeData) {
      final args = routeData.argsAs<SimpleInfoRouteArgs>();
      return CupertinoPageX<dynamic>(
          routeData: routeData,
          child: SimpleInfoScreen(key: args.key, operation: args.operation));
    },
    BobbinLoadingRoute.name: (routeData) {
      final args = routeData.argsAs<BobbinLoadingRouteArgs>();
      return CupertinoPageX<dynamic>(
          routeData: routeData,
          child: BobbinLoadingScreen(key: args.key, bobbin: args.bobbin));
    },
    ScannerResultRoute.name: (routeData) {
      final args = routeData.argsAs<ScannerResultRouteArgs>();
      return CupertinoPageX<dynamic>(
          routeData: routeData,
          child: ScannerResultScreen(key: args.key, args: args.args));
    },
    SavedOperationsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const SavedOperationsScreen());
    },
    CachedOperationsRoute.name: (routeData) {
      return CupertinoPageX<dynamic>(
          routeData: routeData, child: const CachedOperationsScreen());
    }
  };

  @override
  List<RouteConfig> get routes =>
      [
        RouteConfig(SplashRoute.name, path: '/'),
        RouteConfig(LoginRoute.name, path: '/login-screen'),
        RouteConfig(RegistrationRoute.name, path: '/registration-screen'),
        RouteConfig(HomeRoute.name, path: '/home-screen'),
        RouteConfig(ScannerRoute.name, path: '/scanner-screen'),
        RouteConfig(OperationSaveRoute.name, path: '/operation-save-screen'),
        RouteConfig(UpdateOperationRoute.name,
            path: '/update-operation-screen'),
        RouteConfig(SimpleInfoRoute.name, path: '/simple-info-screen'),
        RouteConfig(BobbinLoadingRoute.name, path: '/bobbin-loading-screen'),
        RouteConfig(ScannerResultRoute.name, path: '/scanner-result-screen'),
        RouteConfig(SavedOperationsRoute.name,
            path: '/saved-operations-screen'),
        RouteConfig(CachedOperationsRoute.name,
            path: '/cached-operations-screen')
      ];
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-screen');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [RegistrationScreen]
class RegistrationRoute extends PageRouteInfo<void> {
  const RegistrationRoute()
      : super(RegistrationRoute.name, path: '/registration-screen');

  static const String name = 'RegistrationRoute';
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-screen');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ScannerScreen]
class ScannerRoute extends PageRouteInfo<void> {
  const ScannerRoute() : super(ScannerRoute.name, path: '/scanner-screen');

  static const String name = 'ScannerRoute';
}

/// generated route for
/// [OperationSaveScreen]
class OperationSaveRoute extends PageRouteInfo<OperationSaveRouteArgs> {
  OperationSaveRoute({Key? key, required Operation operation})
      : super(OperationSaveRoute.name,
            path: '/operation-save-screen',
            args: OperationSaveRouteArgs(key: key, operation: operation));

  static const String name = 'OperationSaveRoute';
}

class OperationSaveRouteArgs {
  const OperationSaveRouteArgs({this.key, required this.operation});

  final Key? key;

  final Operation operation;

  @override
  String toString() {
    return 'OperationSaveRouteArgs{key: $key, operation: $operation}';
  }
}

/// generated route for
/// [UpdateOperationScreen]
class UpdateOperationRoute extends PageRouteInfo<UpdateOperationRouteArgs> {
  UpdateOperationRoute({Key? key, required Operation operation})
      : super(UpdateOperationRoute.name,
            path: '/update-operation-screen',
            args: UpdateOperationRouteArgs(key: key, operation: operation));

  static const String name = 'UpdateOperationRoute';
}

class UpdateOperationRouteArgs {
  const UpdateOperationRouteArgs({this.key, required this.operation});

  final Key? key;

  final Operation operation;

  @override
  String toString() {
    return 'UpdateOperationRouteArgs{key: $key, operation: $operation}';
  }
}

/// generated route for
/// [SimpleInfoScreen]
class SimpleInfoRoute extends PageRouteInfo<SimpleInfoRouteArgs> {
  SimpleInfoRoute({Key? key, required Operation operation})
      : super(SimpleInfoRoute.name,
            path: '/simple-info-screen',
            args: SimpleInfoRouteArgs(key: key, operation: operation));

  static const String name = 'SimpleInfoRoute';
}

class SimpleInfoRouteArgs {
  const SimpleInfoRouteArgs({this.key, required this.operation});

  final Key? key;

  final Operation operation;

  @override
  String toString() {
    return 'SimpleInfoRouteArgs{key: $key, operation: $operation}';
  }
}

/// generated route for
/// [BobbinLoadingScreen]
class BobbinLoadingRoute extends PageRouteInfo<BobbinLoadingRouteArgs> {
  BobbinLoadingRoute({Key? key, required ScannedEntity bobbin})
      : super(BobbinLoadingRoute.name,
            path: '/bobbin-loading-screen',
            args: BobbinLoadingRouteArgs(key: key, bobbin: bobbin));

  static const String name = 'BobbinLoadingRoute';
}

class BobbinLoadingRouteArgs {
  const BobbinLoadingRouteArgs({this.key, required this.bobbin});

  final Key? key;

  final ScannedEntity bobbin;

  @override
  String toString() {
    return 'BobbinLoadingRouteArgs{key: $key, bobbin: $bobbin}';
  }
}

/// generated route for
/// [ScannerResultScreen]
class ScannerResultRoute extends PageRouteInfo<ScannerResultRouteArgs> {
  ScannerResultRoute({Key? key, required ScannerResultArguments args})
      : super(ScannerResultRoute.name,
            path: '/scanner-result-screen',
            args: ScannerResultRouteArgs(key: key, args: args));

  static const String name = 'ScannerResultRoute';
}

class ScannerResultRouteArgs {
  const ScannerResultRouteArgs({this.key, required this.args});

  final Key? key;

  final ScannerResultArguments args;

  @override
  String toString() {
    return 'ScannerResultRouteArgs{key: $key, args: $args}';
  }
}

/// generated route for
/// [SavedOperationsScreen]
class SavedOperationsRoute extends PageRouteInfo<void> {
  const SavedOperationsRoute()
      : super(SavedOperationsRoute.name, path: '/saved-operations-screen');

  static const String name = 'SavedOperationsRoute';
}

/// generated route for
/// [CachedOperationsScreen]
class CachedOperationsRoute extends PageRouteInfo<void> {
  const CachedOperationsRoute()
      : super(CachedOperationsRoute.name, path: '/cached-operations-screen');

  static const String name = 'CachedOperationsRoute';
}
