import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_bloc.dart';
import 'package:popper_mobile/widgets/logo.dart';

class SplashScreen extends StatelessWidget implements AutoRouteWrapper {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => getIt<SplashBloc>(),
      child: this,
    );
  }

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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state is NavigateToLogin) {
                  _navigateDelayed(context, const LoginRoute());
                } else if (state is NavigateToHome) {
                  _navigateDelayed(context, const HomeRoute());
                }
              });
            },
            child: const Logo(250),
          ),
        ),
      ),
    );
  }

  void _navigateDelayed(BuildContext context, PageRouteInfo route) {
    Timer(
      const Duration(seconds: 1),
      () => context.router.replace(route),
    );
  }
}
