import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:popper_mobile/domain/models/operation/acceptance_operation.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_type.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/bobbin_defected_warning.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/check_result_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/check_type_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/checkbox_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/comment_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/entity_info_not_loaded.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/repair_button.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_field.dart';
import 'package:popper_mobile/ui/operation_info/general/fields/value_info_text.dart';
import 'package:popper_mobile/ui/operation_info/general/operation_type_field/ui/operation_type_field.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';

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
                  operation.products.first.specification?.productType ??
                      'Неизвестно',
                ),
              ),
            ),
            Expanded(
              child: ValueInfoField(
                title: 'Идентификатор',
                value: ValueInfoText(operation.products.length > 1
                    ? '${operation.products.first.id} - ${operation.products.last.id}'
                    : '${operation.products.first.id}'),
              ),
            ),
          ],
        ),
        ValueInfoField(
          title: 'Номер',
          value: _ProductNumber(operation),
        ),
        ValueInfoField(
          title: 'Дата сканирования',
          value: ValueInfoText(formatter.format(operation.time)),
        ),
        ValueInfoField(
          title: 'Сотрудник',
          value: ValueInfoText(operation.user.fullName),
        ),
        if (operation is OperationWithType)
          ValueInfoField(
            title: 'Тип операции',
            value: OperationTypeField(
              selected: (operation as OperationWithType).type,
              isImmutable: isImmutable,
              specification: operation.products.first.specification,
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
    this.products, {
    Key? key,
  }) : super(key: key);

  final Operation products;

  String get number => products.productsName;

  @override
  Widget build(BuildContext context) {
    if (products.products.any((p) => !p.isActive)) {
      return ProductDefectedWarning(number);
    }

    if (products.products.any((p) => !p.isLoaded)) {
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
          if (!checkOperation.isSuccessful)
            ValueInfoField(
              title: 'Ремонт',
              value: CheckBoxButton(
                label: 'Нужен ремонт',
                value: checkOperation.isNeedRepair,
                onChange: (value) {
                  final event = ChangeNeedRepairStatusEvent(value);
                  context
                      .read<OperationSaveBloc>()
                      .add(ModifyOperationEvent(event));
                },
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

    if (operation is AcceptanceOperation) {
      final acceptanceOperation = operation as AcceptanceOperation;
      return Column(
        children: [
          ValueInfoField(
            title: 'Тип операции',
            value: ValueInfoText(acceptanceOperation.typeName!),
          ),
        ],
      );
    }

    return const Placeholder();
  }
}
