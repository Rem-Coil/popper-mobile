import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';

@singleton
class CacheOperationUsecase {
  const CacheOperationUsecase(
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
    this._typesRepository,
  );

  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;
  final OperationTypesRepository _typesRepository;

  FResult<void> call(Operation operation) async {
    if (operation is CheckOperation) {
      return _checkOperationsRepository.cache(operation);
    }

    if (operation is OperatorOperation) {
      await _operatorOperationsRepository.cache(operation);
      final specId = operation.product.specification!.id;
      final type = operation.type!;
      await _typesRepository.setLastType(specId, type);
      return const Right(null);
    }

    return const Left(UnknownFailure());
  }
}
