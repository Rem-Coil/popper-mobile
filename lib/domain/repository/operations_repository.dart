import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

abstract class OperationsRepository {
  Future<List<Operation>> getAll();

  FResult<void> save(Operation operation);

  FResult<void> cache(Operation operation);

  FResult<void> syncOperations();

  FResult<void> delete(Operation operation);

  FResult<void> deleteFromCache(Operation operation);

  Future<void> subscribe(VoidCallback listener);

  Future<void> unsubscribe(VoidCallback listener);

  Future<OperationType?> getLastOperationType();

  Future<void> setLastOperationType(OperationType? actionType);
}
