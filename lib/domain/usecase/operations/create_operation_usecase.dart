import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_with_comment.dart';
import 'package:popper_mobile/domain/models/operation/scanned_entity.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/domain/repository/scanned_entities_repository.dart';

@injectable
class CreateOperationUseCase {
  final ScannedEntitiesRepository _entitiesRepository;
  final AuthRepository _authRepository;
  final OperationsRepository _repository;

  const CreateOperationUseCase(
    this._entitiesRepository,
    this._authRepository,
    this._repository,
  );

  Future<Operation> call(ScannedEntity entity) async {
    final item = await _entitiesRepository.getEntityInfo(entity);
    final user = await _authRepository.getCurrentUserOrNull();
    final type = await _repository.getLastOperationType();
    final time = DateTime.now();
    final isSuccessful = user!.role == Role.operator ? true : false;

    if (user.role == Role.qualityEngineer) {
      return OperationWithComment.create(
        user: user,
        item: item,
        type: type,
        time: time,
        isSuccessful: isSuccessful,
      );
    }

    return Operation.create(
      user: user,
      item: item,
      type: type,
      time: time,
      isSuccessful: isSuccessful,
    );
  }
}
