import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@injectable
class DeleteOperationUseCase {
  const DeleteOperationUseCase(
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
  );

  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;

  FResult<void> call(Operation operation) async {
    if (operation is CheckOperation) {
      return _checkOperationsRepository.delete(operation);
    }

    if (operation is OperatorOperation) {
      return _operatorOperationsRepository.delete(operation);
    }

    return const Left(UnknownFailure());
  }
}
