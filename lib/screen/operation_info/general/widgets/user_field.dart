import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/current_user/bloc/bloc.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';

class UserField extends StatelessWidget {
  const UserField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = context.read<CurrentUserBloc>().state as WithUserState;
    return ValueInfoField(
      title: 'Сотрудник',
      value: ValueInfoText(userState.user.fullName),
    );
  }
}
