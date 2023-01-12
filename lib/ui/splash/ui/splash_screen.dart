import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';
import 'package:popper_mobile/core/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrentUserBloc>(context).add(const LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: BlocListener<CurrentUserBloc, CurrentUserState>(
          listener: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state is UserNotSetState) {
                _navigateDelayed(context, const LoginRoute());
              } else if (state is WithUserState) {
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
