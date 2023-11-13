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
class SaveOperationUsecase {
  const SaveOperationUsecase(
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
    this._typesRepository,
  );

  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;
  final OperationTypesRepository _typesRepository;

  FResult<void> call(Operation operation) async {
    if (operation is CheckOperation) {
      return _checkOperationsRepository.save(operation);
    }

    if (operation is OperatorOperation) {
      final saveResult = await _operatorOperationsRepository.save(operation);
      return saveResult.map((_) async => await _updateLastType(operation));
    }

    return const Left(UnknownFailure());
  }

  Future<void> _updateLastType(OperatorOperation operation) async {
    final specId = operation.product.specification!.id;
    final type = operation.type!;
    await _typesRepository.setLastType(specId, type);
  }
}
