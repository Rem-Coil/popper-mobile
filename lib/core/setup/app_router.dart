import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/ui/history/ui/history_screen.dart';
import 'package:popper_mobile/ui/home/ui/home_screen.dart';
import 'package:popper_mobile/ui/login/ui/login_screen.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/ui/save_operation_screen.dart';
import 'package:popper_mobile/ui/operation_info/simple_info/ui/simple_info_screen.dart';
import 'package:popper_mobile/ui/registration/ui/registration_srceen.dart';
import 'package:popper_mobile/ui/scanner/ui/scanner_screen.dart';
import 'package:popper_mobile/ui/splash/ui/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegistrationRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ScannerRoute.page),
    AutoRoute(page: SaveOperationRoute.page),
    AutoRoute(page: SimpleInfoRoute.page),
    AutoRoute(page: HistoryRoute.page),
  ];
}
