import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/screen/splash/bloc/bloc.dart';
import 'package:popper_mobile/widgets/logo.dart';

class SplashScreen extends StatefulWidget implements AutoRouteWrapper {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => getIt<SplashBloc>(),
      child: this,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SplashBloc>(context).add(Initialize());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
    );
  }

  void _navigateDelayed(BuildContext context, PageRouteInfo route) {
    Timer(
      const Duration(seconds: 1),
      () => context.router.replace(route),
    );
  }
}
