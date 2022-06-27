import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/user_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/buttons/circle_icon_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserInfoBloc>(context).add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoBloc, UserInfoState>(
      listenWhen: (_, state) => state is LogOutState,
      listener: (context, state) =>
          context.router.replaceAll([const LoginRoute()]),
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                (state is UserInfoLoadingState)
                    ? const CircularLoader(size: 24)
                    : _HelloUserWidget(state: state as UserInfoSuccessState),
                const Spacer(),
                CircleIconButton(
                  icon: Icons.people,
                  iconColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: _logOut,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _logOut() async {
    final isNotLogOut = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
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
      if (!mounted) return;
      context.read<UserInfoBloc>().add(LogOutEvent());
    }
  }
}

class _HelloUserWidget extends StatelessWidget {
  const _HelloUserWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final UserInfoSuccessState state;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Привет, ${state.user.firstName}',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
