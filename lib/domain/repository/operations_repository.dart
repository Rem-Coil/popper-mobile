import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';

abstract class OperationsRepository<T extends Operation> {
  Future<List<T>> getAllSaved();

  FResult<List<T>> getByProduct(int productId);

  FResult<void> save(T operation);

  FResult<void> cache(T operation);

  FResult<void> syncOperations();

  FResult<void> delete(T operation);
}

abstract class CheckOperationsRepository
    extends OperationsRepository<CheckOperation> {}

abstract class OperatorOperationsRepository
    extends OperationsRepository<OperatorOperation> {}
