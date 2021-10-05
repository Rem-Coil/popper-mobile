import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';
import 'package:popper_mobile/widgets/column_divider.dart';
import 'package:popper_mobile/widgets/field.dart';
import 'package:popper_mobile/widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.user!)),
                  );
                }

                if (state.isLoad) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Loading')),
                  );
                }

                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Logo(250),
                      ColumnDivider(48),
                      Text(
                        'Войти',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ColumnDivider(32),
                      Field(
                        icon: Icons.local_phone_outlined,
                        hintText: 'Телефон',
                        controller: phoneController,
                        isNumberField: true,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Введите телефон'
                            : null,
                      ),
                      ColumnDivider(16),
                      Field(
                        icon: Icons.lock_outline_rounded,
                        isHidden: true,
                        hintText: 'Пароль',
                        controller: passwordController,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Введите пароль'
                            : null,
                      ),
                      ColumnDivider(48),
                      Center(
                        child: Container(
                          width: 270,
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                'Войти',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context)
                                  ..add(OnDataEntered(
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  ));
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: Text('Регистрация'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
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
