import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/action_type.dart';

abstract class OperationTypesRepository {
  FResult<ActionType?> getTypeById(int typeId);

  Future<void> syncTypes();

  FResult<List<ActionType>> getTypesBySpec(int specificationId);

  Future<ActionType?> getLastType(int specificationId);

  Future<void> setLastType(
    int specificationId,
    ActionType type,
  );
}
