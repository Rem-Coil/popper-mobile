import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

@singleton
class ModifyOperationUsecase {
  const ModifyOperationUsecase();

  Operation call(Operation operation, ModifyEvent event) {
    return event.updateOperation(operation);
  }
}
