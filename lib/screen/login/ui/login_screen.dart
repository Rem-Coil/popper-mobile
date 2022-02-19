import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/login/bloc/bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/buttons/loading_button.dart';
import 'package:popper_mobile/widgets/field.dart';
import 'package:popper_mobile/widgets/logo.dart';

class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => getIt<LoginBloc>(),
      child: this,
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isValidFields => _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 320,
            height: 540,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.user != null) {
                  context.successSnackBar('Успешно');
                  Future.delayed(Duration(seconds: 1), () {
                    context.router.replace(const HomeRoute());
                  });
                }

                if (state.errorMessage != null) {
                  context.errorSnackBar(state.errorMessage!.message);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Logo(250),
                        SizedBox(height: 32),
                        Text(
                          'Войти',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 32),
                        Field(
                          icon: Icons.local_phone_outlined,
                          hintText: 'Телефон',
                          controller: phoneController,
                          isNumberField: true,
                          validator: (value) =>
                              value == null || value.isNotEmpty
                                  ? null
                                  : 'Введите телефон',
                        ),
                        SizedBox(height: 16),
                        Field(
                          icon: Icons.lock_outline_rounded,
                          isHidden: true,
                          hintText: 'Пароль',
                          controller: passwordController,
                          validator: (value) =>
                              value == null || value.isNotEmpty
                                  ? null
                                  : 'Введите пароль',
                        ),
                        SizedBox(height: 48),
                        Center(
                          child: LoadingButton(
                            width: 270,
                            isLoad: state.isLoad,
                            text: 'Войти',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (isValidFields) {
                                checkUserData(context);
                              }
                            },
                          ),
                        ),
                        Center(
                          child: TextButton(
                            child: Text('Регистрация'),
                            onPressed: () =>
                                context.router.push(const RegistrationRoute()),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void checkUserData(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(
      OnDataEntered(
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
