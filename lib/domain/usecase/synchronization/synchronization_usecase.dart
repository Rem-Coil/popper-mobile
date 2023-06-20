import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';

@injectable
class SynchronizationUseCase {
  const SynchronizationUseCase(
    this._specificationsRepository,
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
  );

  final OperationTypesRepository _specificationsRepository;
  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;

  FResult<void> call() async {
    final results = await Future.wait([
      _specificationsRepository.syncTypes(),
      _checkOperationsRepository.syncOperations(),
      _operatorOperationsRepository.syncOperations(),
    ]);

    final checkResult = results[1] as Result<void>;
    final operatorResult = results[2] as Result<void>;

    if (checkResult.isLeft) return Left(checkResult.left);
    if (operatorResult.isLeft) return Left(operatorResult.left);
    return const Right(null);
  }
}
