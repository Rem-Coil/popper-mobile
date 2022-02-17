import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/select_operation_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_warning.dart';

class OperationInfo extends StatelessWidget {
  final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

  final Operation operation;
  final bool isImmutable;
  final OnTypeSelected? onTypeSelected;

  OperationInfo({
    Key? key,
    required this.operation,
    required this.isImmutable,
    this.onTypeSelected,
  })  : assert(isImmutable || onTypeSelected != null),
        super(key: key);

  String get currentType =>
      operation.type?.localizedName ?? 'Выберете операцию';

  bool get isBobbinNotLoaded => operation.bobbin.isUnknown;

  String get bobbinNumber => operation.bobbin.bobbinNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueInfoField(
          title: 'Идентификатор катушки',
          value: ValueInfoText('${operation.bobbin.id}'),
        ),
        SizedBox(height: 24),
        ValueInfoField(
          title: 'Номер катушки',
          value: isBobbinNotLoaded
              ? ValueInfoWarning(bobbinNumber)
              : ValueInfoText(bobbinNumber),
        ),
        SizedBox(height: 24),
        ValueInfoField(
          title: 'Сотрудник',
          value: ValueInfoText(_getUserName(context)),
        ),
        SizedBox(height: 24),
        ValueInfoField(
          title: 'Операция',
          value: !isImmutable
              ? SelectOperationButton(
                  type: currentType,
                  onTypeSelected: onTypeSelected!,
                )
              : ValueInfoText(currentType),
        ),
        SizedBox(height: 24),
        ValueInfoField(
          title: 'Дата сканирования',
          value: ValueInfoText(formatter.format(operation.time)),
        ),
      ],
    );
  }

  String _getUserName(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    return authState.user!.fullName;
  }
}
