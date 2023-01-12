import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_comment.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/comment_button.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/select_operation_field.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/value_info_field.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/widgets/fields/value_info_warning.dart';

final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

class OperationInfo extends StatelessWidget {
  const OperationInfo({
    Key? key,
    required this.operation,
    required this.isImmutable,
    this.onTypeSelected,
    this.onCommentEntered,
  })  : assert(isImmutable || onTypeSelected != null),
        super(key: key);

  final Operation operation;
  final bool isImmutable;
  final OnTypeSelected? onTypeSelected;
  final OnCommentEntered? onCommentEntered;

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
        ValueInfoField(
          title: 'Сотрудник',
          value: ValueInfoText(operation.user.fullName),
        ),
        ValueInfoField(
          title: 'Операция',
          value: SelectOperationButton(
            type: currentType,
            isImmutable: isImmutable,
            onTypeSelected: onTypeSelected,
          ),
        ),
        if (operation is OperationWithComment) ...[
          ValueInfoField(
            title: 'Комментарий',
            value: CommentButton(
              comment: (operation as OperationWithComment).comment,
              isImmutable: isImmutable,
              onCommentEntered: onCommentEntered,
            ),
          ),
        ],
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
    // );
    // },
    // ),
    // );
  }
}
