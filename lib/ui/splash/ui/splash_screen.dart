import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';
import 'package:popper_mobile/core/widgets/logo.dart';
import 'package:popper_mobile/ui/splash/bloc/bloc.dart';

@RoutePage()
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
                context.read<SplashBloc>().add(const TrySync());
              }
            });
          },
          child: BlocConsumer<SplashBloc, SplashState>(
            listenWhen: (_, state) => state is TasksEnd,
            listener: (context, state) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _navigateDelayed(context, const HomeRoute());
              });
            },
            builder: (context, state) {
              return Center(
                child: SizedBox(
                  height: 150,
                  width: 250,
                  child: Column(
                    children: [
                      const Logo(),
                      const SizedBox(height: 24),
                      if (state is BackgroundTaskState) ...[
                        Text(
                          state.task,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: const Color(0xFF71706D)),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
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
