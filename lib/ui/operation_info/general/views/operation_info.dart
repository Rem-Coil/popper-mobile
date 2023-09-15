import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/bobbin_defected_warning.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/check_result_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/check_type_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/comment_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/entity_info_not_loaded.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/repair_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_field.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/ui/operation_type_field.dart';

final formatter = DateFormat('d MMM yyyy, HH:mm', 'ru_RU');

class OperationInfo extends StatelessWidget {
  const OperationInfo.changeable(
    this.operation, {
    Key? key,
  })  : isImmutable = false,
        super(key: key);

  const OperationInfo.immutable(
    this.operation, {
    Key? key,
  })  : isImmutable = true,
        super(key: key);

  final Operation operation;
  final bool isImmutable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ValueInfoField(
                title: 'Тип',
                value: ValueInfoText(
                  operation.product.specification?.productType ?? 'Неизвестно',
                ),
              ),
            ),
            Expanded(
              child: ValueInfoField(
                title: 'Идентификатор',
                value: ValueInfoText('${operation.product.id}'),
              ),
            ),
          ],
        ),
        ValueInfoField(
          title: 'Номер',
          value: _ProductNumber(operation.product),
        ),
        ValueInfoField(
          title: 'Дата сканирования',
          value: ValueInfoText(formatter.format(operation.time)),
        ),
        ValueInfoField(
          title: 'Сотрудник',
          value: ValueInfoText(operation.user.fullName),
        ),
        ValueInfoField(
          title: 'Тип операции',
          value: OperationTypeField(
            selected: operation.type,
            isImmutable: isImmutable,
            specification: operation.product.specification,
          ),
        ),
        _OperationActions(
          operation: operation,
          isImmutable: isImmutable,
        ),
      ],
    );
  }
}

class _ProductNumber extends StatelessWidget {
  const _ProductNumber(
    this.product, {
    Key? key,
  }) : super(key: key);

  final ProductInfo product;

  String get number => product.number;

  @override
  Widget build(BuildContext context) {
    if (!product.isActive) {
      return ProductDefectedWarning(number);
    }

    if (!product.isLoaded) {
      return EntityInfoNotLoadedWarning(number);
    }

    return ValueInfoText(number);
  }
}

class _OperationActions extends StatelessWidget {
  const _OperationActions({
    Key? key,
    required this.operation,
    required this.isImmutable,
  }) : super(key: key);

  final Operation operation;
  final bool isImmutable;

  @override
  Widget build(BuildContext context) {
    if (operation is CheckOperation) {
      final checkOperation = operation as CheckOperation;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueInfoField(
            title: 'Комментарий',
            value: CommentButton(
              comment: checkOperation.comment,
              isImmutable: isImmutable,
            ),
          ),
          ValueInfoField(
            title: 'Результат проверки',
            value: CheckResultButton(
              isSuccessful: checkOperation.isSuccessful,
              isImmutable: isImmutable,
            ),
          ),
          ValueInfoField(
            title: 'Вид проверки',
            value: CheckTypeButton(
              selected: checkOperation.checkType,
              isImmutable: isImmutable,
            ),
          ),
        ],
      );
    }

    if (operation is OperatorOperation) {
      final operatorOperation = operation as OperatorOperation;
      return Column(
        children: [
          ValueInfoField(
            title: 'Тип операции',
            value: RepairButton(
              isRepair: operatorOperation.isRepair,
              isImmutable: isImmutable,
            ),
          ),
        ],
      );
    }

    return const Placeholder();
  }
}
