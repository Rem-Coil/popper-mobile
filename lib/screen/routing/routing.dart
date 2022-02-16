import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/action/action.dart' as models;
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/bobbin_loading/bloc/bloc.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/screen/home/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/home_screen.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/routing/screen.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/scanned_info_screen.dart';
import 'package:popper_mobile/screen/scanner/ui/scanner_screen.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/screen/scanner_result/ui/scanner_result_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';

class Routing {
  final List<Screen> _screens = [
    SimpleScreen(
      route: SplashScreen.route,
      builder: (_) => screenWithBloc<SplashBloc>(SplashScreen()),
    ),
    SimpleScreen(
      route: LoginScreen.route,
      builder: (_) => screenWithBloc<LoginBloc>(LoginScreen()),
    ),
    SimpleScreen(
      route: HomeScreen.route,
      builder: (_) => screenWithBloc<HomeBloc>(HomeScreen()),
    ),
    SimpleScreen(
      route: ScannerScreen.route,
      builder: (_) => ScannerScreen(),
    ),
    ScreenWithArguments<models.Action>(
      route: ScannedInfoScreen.route,
      screenBuilder: (_, a) {
        return BlocProvider<SaveActionBloc>(
          create: (_) => getIt.get<SaveActionBloc>(param1: a),
          child: ScannedInfoScreen(),
        );
      },
    ),
    ScreenWithArguments<ScannedEntity>(
      route: BobbinLoadingScreen.route,
      screenBuilder: (_, b) {
        return screenWithBloc<BobbinLoadingBloc>(
          BobbinLoadingScreen(bobbin: b),
        );
      },
    ),
    ScreenWithArguments<ScannerResultArguments>(
      route: ScannerResultScreen.route,
      screenBuilder: (_, a) {
        return ScannerResultScreen(args: a);
      },
    ),
  ];

  Route<dynamic>? routeFactory(RouteSettings settings) {
    final screenHolder = _screens.firstWhere(
      (s) => s.route == settings.name,
      orElse: () => EmptyScreen(),
    );

    if (screenHolder is EmptyScreen) return null;
    return screenHolder.screen(settings);
  }

  static BlocProvider<T> screenWithBloc<T extends BlocBase<Object?>>(
      Widget screen) {
    return BlocProvider(create: (_) => getIt<T>(), child: screen);
  }
}
