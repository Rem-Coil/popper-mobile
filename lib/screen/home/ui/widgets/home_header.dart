import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/widgets/circle_icon_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final username = state.user?.firstname ?? 'Незнакомец';
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
