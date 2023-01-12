import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';

class ExitButton extends StatefulWidget {
  const ExitButton({super.key});

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onExit,
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

  Future<void> _onExit() async {
    final isExit = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Вы уверены что хотите выйти?',
          acceptActionTitle: 'Да',
          cancelActionTitle: 'Нет',
        );
      },
    );

    if (isExit == true && mounted) {
      context.read<CurrentUserBloc>().add(const LogOutEvent());
      context.router.replaceAll([const LoginRoute()]);
    }
  }
}
