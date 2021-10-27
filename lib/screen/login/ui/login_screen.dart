import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_bloc.dart';
import 'package:popper_mobile/screen/login/bloc/login_event.dart';
import 'package:popper_mobile/screen/login/bloc/login_state.dart';
import 'package:popper_mobile/screen/qr_code_scanner/ui/qr_scanner_screen.dart';
import 'package:popper_mobile/widgets/button.dart';
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

  bool get isValidFields => _formKey.currentState!.validate();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 320,
            height: 510,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Успешно'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Future.delayed(
                    Duration(seconds: 1),
                    () => Navigator.of(context)
                        .pushReplacementNamed(QrScannerScreen.route),
                  );
                }

                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        state.errorMessage!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
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
                      ColumnDivider(32),
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
                        child: LoadingButton(
                          width: 270,
                          isLoad: state.isLoad,
                          text: 'Войти',
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (isValidFields) {
                              checkUserData(context);
                              clear();
                            }
                          },
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

  void checkUserData(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(
      OnDataEntered(
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
  }

  void clear() {
    phoneController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
