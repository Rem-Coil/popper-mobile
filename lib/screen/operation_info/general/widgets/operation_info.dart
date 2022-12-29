import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/select_operation_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/user_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_field.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_text.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/value_info_warning.dart';

final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

class OperationInfo extends StatelessWidget {
  const OperationInfo({
    Key? key,
    required this.operation,
    required this.isImmutable,
    this.onTypeSelected,
  })  : assert(isImmutable || onTypeSelected != null),
        super(key: key);

  final Operation operation;
  final bool isImmutable;
  final OnTypeSelected? onTypeSelected;

  String get currentType =>
      operation.type?.localizedName ?? 'Выберете операцию';

  String get number => operation.item.number;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ValueInfoField(
                title: 'Тип',
                value: ValueInfoText(operation.item.type),
              ),
            ),
            Expanded(
              child: ValueInfoField(
                title: 'Идентификатор',
                value: ValueInfoText('${operation.item.id}'),
              ),
            ),
          ],
        ),
        ValueInfoField(
          title: 'Номер',
          value: !operation.item.isLoaded
              ? ValueInfoWarning(number)
              : ValueInfoText(number),
        ),
        const UserField(),
        ValueInfoField(
          title: 'Операция',
          value: !isImmutable
              ? SelectOperationButton(
                  type: currentType,
                  onTypeSelected: onTypeSelected!,
                )
              : ValueInfoText(currentType),
        ),
        ValueInfoField(
          title: 'Дата сканирования',
          value: ValueInfoText(formatter.format(operation.time)),
        ),
        ValueInfoField(
          title: 'Тип операции',
          value: ValueInfoText(operation.isSuccessful ? 'Успешная' : 'Брак'),
        ),
      ],
    );
  }
}
