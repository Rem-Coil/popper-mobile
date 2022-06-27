import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/screen/user_info/bloc/bloc.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class UserField extends StatefulWidget {
  const UserField({
    Key? key,
  }) : super(key: key);

  @override
  State<UserField> createState() => _UserFieldState();
}

class _UserFieldState extends State<UserField> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserInfoBloc>(context).add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return ValueInfoField(
          title: 'Сотрудник',
          value: state is UserInfoSuccessState
              ? ValueInfoText(state.user.fullName)
              : const CircularLoader(size: 24),
        );
      },
    );
  }
}
