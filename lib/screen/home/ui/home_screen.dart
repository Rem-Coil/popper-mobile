import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              HomeHeader()
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Container(
        child: Text('Привет, ${state.user?.firstname ?? 'Незнакомец'}'),
      ),
    );
  }
}
