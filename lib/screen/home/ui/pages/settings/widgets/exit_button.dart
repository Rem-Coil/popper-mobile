import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/screen/current_user/bloc/bloc.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CurrentUserBloc>().add(const LogOutEvent());
        context.router.replaceAll([const LoginRoute()]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Выйти',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: Colors.blue),
        ),
      ),
    );
  }
}
