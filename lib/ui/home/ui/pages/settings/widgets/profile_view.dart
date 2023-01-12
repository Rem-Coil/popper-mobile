import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/domain/models/user/user.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/pages/settings/widgets/container_with_shadow.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.read<CurrentUserBloc>().state as WithUserState;
    final user = userState.user;

    return ContainerWithShadow(
      verticalMargin: 32,
      child: Row(
        children: [
          _Avatar(user: user),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '${user.secondName} ${user.firstName} ${user.surname}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user});

  final User user;

  String get initials =>
      user.firstName[0].toUpperCase() + user.secondName[0].toUpperCase();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      child: Text(initials, style: const TextStyle(color: Colors.white)),
    );
  }
}
