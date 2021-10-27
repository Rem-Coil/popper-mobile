import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/qr_scanner_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => getIt<LoginBloc>()),
        BlocProvider<QrScannerBloc>(create: (_) => getIt<QrScannerBloc>()),
        BlocProvider<SplashBloc>(create: (_) => getIt<SplashBloc>()),
      ],
      child: MaterialApp(
        title: 'Rem&Coil',
        theme: ThemeData(
          textTheme: GoogleFonts.mPlusRounded1cTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          SplashScreen.route: (_) => SplashScreen(),
          LoginScreen.route: (_) => LoginScreen(),
          QrScannerScreen.route: (_) => QrScannerScreen(),
        },
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
