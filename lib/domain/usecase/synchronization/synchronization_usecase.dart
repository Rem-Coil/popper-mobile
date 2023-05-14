import 'package:injectable/injectable.dart';
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

  Future<void> call() async {
    await Future.wait([
      _specificationsRepository.syncTypes(),
      _checkOperationsRepository.syncOperations(),
      _operatorOperationsRepository.syncOperations(),
    ]);
  }
}
