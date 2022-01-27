import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_state.dart';
import 'package:popper_mobile/screen/home/ui/home_screen.dart';
import 'package:popper_mobile/screen/login/ui/login_screen.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_event.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_state.dart';
import 'package:popper_mobile/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  static const route = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (_, state) => state.status == Status.success,
          listener: (context, state) =>
              BlocProvider.of<SplashBloc>(context).add(Initialize(state.user)),
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                if (state is NavigateToLogin) {
                  _navigateDelayed(context, LoginScreen.route);
                } else if (state is NavigateToHome) {
                  _navigateDelayed(context, HomeScreen.route);
                }
              });
            },
            child: Logo(250),
          ),
        ),
      ),
    );
  }

  void _navigateDelayed(BuildContext context, String route, {Object? args}) {
    Timer(
      Duration(seconds: 1),
      () => context.pushReplacement(route, args: args),
    );
  }
}
