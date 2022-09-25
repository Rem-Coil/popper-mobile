import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/screen/history/ui/history_screen.dart';
import 'package:popper_mobile/screen/home/ui/home_screen.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/operation_info/save_operation/ui/save_operation_screen.dart';
import 'package:popper_mobile/screen/operation_info/simple_info/ui/simple_info_screen.dart';
import 'package:popper_mobile/screen/operation_info/update_operation/ui/update_operation_screen.dart';
import 'package:popper_mobile/screen/operations_sync/ui/operations_sync_screen.dart';
import 'package:popper_mobile/screen/registration/ui/registration_srceen.dart';
import 'package:popper_mobile/screen/scanner/ui/scanner_screen.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/screen/scanner_result/ui/scanner_result_screen.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';

part 'app_router.gr.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: RegistrationScreen),
    AutoRoute(page: HomeScreen),
    AutoRoute(page: ScannerScreen),
    AutoRoute(page: OperationSaveScreen),
    AutoRoute(page: UpdateOperationScreen),
    AutoRoute(page: SimpleInfoScreen),
    AutoRoute(page: BobbinLoadingScreen),
    AutoRoute(page: ScannerResultScreen),
    AutoRoute(page: OperationsSyncScreen),
    AutoRoute(page: HistoryScreen),
  ],
)
class AppRouter extends _$AppRouter {}
