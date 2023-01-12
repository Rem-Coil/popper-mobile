import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
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

@CupertinoAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: RegistrationScreen),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: ScannerScreen),
    AutoRoute(page: SaveOperationScreen),
    AutoRoute(page: SimpleInfoScreen),
    AutoRoute(page: HistoryScreen),
  ],
)
class AppRouter extends _$AppRouter {}
