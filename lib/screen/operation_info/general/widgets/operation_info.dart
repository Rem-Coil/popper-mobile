import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/select_operation_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/user_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_warning.dart';
import 'package:popper_mobile/screen/user_info/bloc/bloc.dart';

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
        const SizedBox(height: 24),
        ValueInfoField(
          title: 'Номер катушки',
          value: isBobbinNotLoaded
              ? ValueInfoWarning(bobbinNumber)
              : ValueInfoText(bobbinNumber),
        ),
        const SizedBox(height: 24),
        BlocProvider(
          create: (ctx) => getIt<UserInfoBloc>(),
          child: const UserField(),
        ),
        const SizedBox(height: 24),
        ValueInfoField(
          title: 'Операция',
          value: !isImmutable
              ? SelectOperationButton(
                  type: currentType,
                  onTypeSelected: onTypeSelected!,
                )
              : ValueInfoText(currentType),
        ),
        const SizedBox(height: 24),
        ValueInfoField(
          title: 'Дата сканирования',
          value: ValueInfoText(formatter.format(operation.time)),
        ),
        const SizedBox(height: 24),
        ValueInfoField(
          title: 'Статус',
          value: ValueInfoText(operation.isSuccessful ? 'Успешно' : 'Брак'),
        ),
      ],
    );
  }
}
