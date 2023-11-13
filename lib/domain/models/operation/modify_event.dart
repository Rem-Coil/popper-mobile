import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_type.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';

abstract class ModifyEvent<T> {
  const ModifyEvent(this.value);

  final T value;

  Operation updateOperation(Operation operation);
}

class ChangeCommentEvent extends ModifyEvent<String?> {
  const ChangeCommentEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! CheckOperation) return operation;
    return operation.copy(comment: value);
  }
}

class ChangeCheckTypeEvent extends ModifyEvent<CheckType> {
  const ChangeCheckTypeEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! CheckOperation) return operation;
    return operation.copy(checkType: value);
  }
}

class ChangeCheckResultEvent extends ModifyEvent<bool> {
  const ChangeCheckResultEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! CheckOperation) return operation;
    return operation.copy(
      isSuccessful: value,
      isNeedRepair: !value,
    );
  }
}

class ChangeNeedRepairStatusEvent extends ModifyEvent<bool> {
  const ChangeNeedRepairStatusEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! CheckOperation) return operation;
    return operation.copy(isNeedRepair: value);
  }
}

class ChangeRepairStatusEvent extends ModifyEvent<bool> {
  const ChangeRepairStatusEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! OperatorOperation) return operation;
    return operation.copy(isRepair: value);
  }
}

class ChangeOperationTypeEvent extends ModifyEvent<OperationType?> {
  const ChangeOperationTypeEvent(super.value);

  @override
  Operation updateOperation(Operation operation) {
    if (operation is! OperationWithType) return operation;
    return operation.setType(value);
  }
}
