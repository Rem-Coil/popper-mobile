import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/theme/colors.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/bobbin_loading/bloc/bloc.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/screen/home/ui/home_screen.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/scanned_info_screen.dart';
import 'package:popper_mobile/screen/scanner/ui/scanner_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await initializeDateFormatting('ru_RU', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'Rem&Coil',
        theme: ThemeData(
          textTheme: fonts(context),
          primarySwatch: primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: routeFactory,
        initialRoute: SplashScreen.route,
      ),
    );
  }

  Route<dynamic>? routeFactory(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          builder: (_) => screenWithBloc<SplashBloc>(SplashScreen()),
        );
      case LoginScreen.route:
        return MaterialPageRoute(
          builder: (_) => screenWithBloc<LoginBloc>(LoginScreen()),
        );
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case ScannerScreen.route:
        return MaterialPageRoute(builder: (_) => ScannerScreen());
      case ScannedInfoScreen.route:
        final bobbin = settings.arguments as Bobbin;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SaveActionBloc>(
            create: (_) => getIt.get<SaveActionBloc>(param1: bobbin),
            child: ScannedInfoScreen(),
          ),
        );
      case BobbinLoadingScreen.route:
        final bobbin = settings.arguments as ScannedEntity;
        return MaterialPageRoute(
          builder: (_) => screenWithBloc<BobbinLoadingBloc>(
            BobbinLoadingScreen(bobbin: bobbin),
          ),
        );
      default:
        return null;
    }
  }

  BlocProvider<T> screenWithBloc<T extends BlocBase<Object?>>(Widget screen) {
    return BlocProvider(create: (_) => getIt<T>(), child: screen);
  }
}
