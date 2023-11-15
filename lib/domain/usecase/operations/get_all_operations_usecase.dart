import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@singleton
class GetAllOperationsUsecase {
  const GetAllOperationsUsecase(
    this._checkOperationsRepository,
    this._operatorOperationsRepository,
    this._acceptanceOperationsRepository,
    this._authRepository,
  );

  final AuthRepository _authRepository;
  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;
  final AcceptanceOperationsRepository _acceptanceOperationsRepository;

  Future<List<Operation>> call() async {
    final user = await _authRepository.getCurrentUser();
    late final List<Operation> operations;
    if (user.role == Role.operator) {
      operations = await _operatorOperationsRepository.getAllSaved();
    } else {
      final List<Operation> checkOperations =
          await _checkOperationsRepository.getAllSaved();
      final List<Operation> acceptanceOperations =
          await _acceptanceOperationsRepository.getAllSaved();
      operations = checkOperations.cast<Operation>() +
          acceptanceOperations.cast<Operation>();
    }

    operations.sort((a, b) => b.time.compareTo(a.time));
    return operations;
  }
}
