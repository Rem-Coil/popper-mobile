import 'package:dartz/dartz.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';

abstract class OperationsRepository {
  Future<Either<Failure, void>> saveOperation(Operation operation);

  Future<Either<Failure, void>> cacheOperation(Operation operation);

  Future<Either<Failure, void>> updateOperation(Operation operation);

  Future<Either<Failure, void>> deleteSavedOperation(Operation operation);

  Future<Either<Failure, void>> deleteCachedOperation(Operation operation);

  Future<OperationType?> getLastOperationType();

  Future<void> setLastOperationType(OperationType? actionType);
}
