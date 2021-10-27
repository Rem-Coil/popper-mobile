import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/qr_scanner_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_event.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_state.dart';
import 'package:popper_mobile/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context)..add(Initialize());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              if (state is NavigateToLogin) {
                Timer(Duration(seconds: 1),
                    () => context.pushReplacement(LoginScreen.route));
              } else if (state is NavigateToScanner) {
                Timer(Duration(seconds: 1),
                    () => context.pushReplacement(QrScannerScreen.route));
              }
            });
          },
          child: Logo(250),
        ),
      ),
    );
  }
}
