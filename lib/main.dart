import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/theme/colors.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/home/ui/home_screen.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';
import 'package:popper_mobile/widgets/failed_screen.dart';
import 'package:popper_mobile/widgets/success_screen.dart';

void main() {
  configureDependencies();
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
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<SplashBloc>(
            create: (_) => getIt<SplashBloc>(),
            child: SplashScreen(),
          );
        });
      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider<LoginBloc>(
            create: (_) => getIt<LoginBloc>(),
            child: LoginScreen(),
          );
        });
      case HomeScreen.route:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case FailedScreen.route:
        final args = settings.arguments as FailedScreenArgs;
        return MaterialPageRoute(builder: (_) => FailedScreen(args: args));
      case SuccessScreen.route:
        final args = settings.arguments as SuccessScreenArgs;
        return MaterialPageRoute(builder: (_) => SuccessScreen(args: args));
      default:
        return null;
    }
  }
}
