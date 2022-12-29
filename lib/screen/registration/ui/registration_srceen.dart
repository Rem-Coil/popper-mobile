import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/current_user/bloc/bloc.dart';
import 'package:popper_mobile/screen/registration/bloc/bloc.dart';
import 'package:popper_mobile/screen/registration/ui/widgets/select_role_button.dart';
import 'package:popper_mobile/widgets/buttons/loading_button.dart';
import 'package:popper_mobile/widgets/field.dart';
import 'package:popper_mobile/widgets/logo.dart';

class RegistrationScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (_) => getIt<RegistrationBloc>(),
      child: this,
    );
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isValidFields => _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationSuccessful) {
                context.showSuccessSnackBar('Успешно');
                context.read<CurrentUserBloc>().add(const LoadUserEvent());

                Future.delayed(const Duration(seconds: 1), () {
                  context.router.replaceAll([const HomeRoute()]);
                });
              }

              if (state is RegistrationFailed) {
                context.showErrorSnackBar(state.failure.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Logo(250),
                      const SizedBox(height: 32),
                      const Text(
                        'Регистрация',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Field(
                        icon: Icons.account_circle,
                        hintText: 'Имя',
                        controller: firstnameController,
                        validator: (value) => value == null || value.isNotEmpty
                            ? null
                            : 'Введите своё имя',
                      ),
                      const SizedBox(height: 16),
                      Field(
                        icon: Icons.account_circle,
                        hintText: 'Фамилия',
                        controller: secondNameController,
                        validator: (value) => value == null || value.isNotEmpty
                            ? null
                            : 'Введите свою фамилию',
                      ),
                      const SizedBox(height: 16),
                      Field(
                        icon: Icons.account_circle,
                        hintText: 'Отчество',
                        controller: surnameController,
                        validator: (value) => value == null || value.isNotEmpty
                            ? null
                            : 'Введите своё отчество',
                      ),
                      const SizedBox(height: 16),
                      Field(
                        icon: Icons.local_phone_outlined,
                        hintText: 'Телефон',
                        controller: phoneController,
                        isNumberField: true,
                        validator: (value) => value == null || value.isNotEmpty
                            ? null
                            : 'Введите телефон',
                      ),
                      const SizedBox(height: 16),
                      Field(
                        icon: Icons.lock_outline_rounded,
                        isHidden: true,
                        hintText: 'Пароль',
                        controller: passwordController,
                        validator: (value) => value == null || value.isNotEmpty
                            ? null
                            : 'Введите пароль',
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 59,
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(Icons.people, color: Colors.grey),
                            ),
                            Expanded(
                              child: SelectRoleButton(
                                current: state.role,
                                onChanged: (role) {
                                  context
                                      .read<RegistrationBloc>()
                                      .add(ChangeUserRole(role));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      Center(
                        child: LoadingButton(
                          width: 270,
                          isLoad: state is TryRegister,
                          text: 'Зарегистрироваться',
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
                          child: const Text('Назад'),
                          onPressed: () => context.router.navigateBack(),
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
    );
  }

  void checkUserData(BuildContext context) {
    BlocProvider.of<RegistrationBloc>(context).add(
      OnDataEntered(
        firstName: firstnameController.text,
        secondName: secondNameController.text,
        surname: surnameController.text,
        phone: phoneController.text,
        password: passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    firstnameController.dispose();
    secondNameController.dispose();
    surnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
