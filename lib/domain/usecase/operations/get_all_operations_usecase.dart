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
    this._authRepository,
  );

  final AuthRepository _authRepository;
  final CheckOperationsRepository _checkOperationsRepository;
  final OperatorOperationsRepository _operatorOperationsRepository;

  Future<List<Operation>> call() async {
    final user = await _authRepository.getCurrentUser();
    final operations = user.role == Role.operator
        ? await _operatorOperationsRepository.getAllSaved()
        : await _checkOperationsRepository.getAllSaved();

    operations.sort((a, b) => b.time.compareTo(a.time));
    return operations;
  }
}
