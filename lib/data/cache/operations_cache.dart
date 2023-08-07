import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';

const _checkOperationsBox = 'check_operations';
const _operatorOperationsBox = 'operator_operations';

@singleton
class OperatorOperationsCache extends Cache<String, LocalOperatorOperation> {
  const OperatorOperationsCache() : super(_operatorOperationsBox);
}

@singleton
class CheckOperationsCache extends Cache<String, LocalCheckOperation> {
  const CheckOperationsCache() : super(_checkOperationsBox);
}
