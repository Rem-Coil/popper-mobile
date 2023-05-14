import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';

abstract class OperationTypesRepository {
  FResult<OperationType?> getTypeById(int typeId);

  Future<void> syncTypes();

  FResult<List<OperationType>> getTypesBySpec(int specificationId);

  Future<OperationType?> getLastType(int specificationId);

  Future<void> setLastType(
    int specificationId,
    OperationType type,
  );
}
