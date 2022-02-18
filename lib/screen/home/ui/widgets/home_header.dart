import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/buttons/circle_icon_button.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (_, state) => state.user == null,
      listener: (context, state) {
        context.router.navigate(const LoginRoute());
      },
      builder: (context, state) {
        final username = state.user?.firstName ?? 'Незнакомец';
        return Container(
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                children: [
                  Text(
                    'Привет, $username',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Spacer(),
                  CircleIconButton(
                    icon: Icons.people,
                    iconColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _logOut(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _logOut(BuildContext context) async {
    final isNotLogOut = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return DecisionDialog(
          title: 'Выйти из приложения?',
          message:
              'После выхода из приложения все сохранённые на телефоне операции '
              'будут удалены и изменить информацию по ним сможет только администратор. '
              'Вы действительно хотите выйти?',
          destructiveActionTitle: 'Выйти',
          saveActionTitle: 'Отмена',
        );
      },
    );
    if (isNotLogOut != true) {
      BlocProvider.of<AuthBloc>(context).add(LogOut());
    }
  }
}
