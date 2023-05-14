import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/domain/models/operation/modify_event.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

@singleton
class ModifyOperationUsecase {
  const ModifyOperationUsecase();

  FResult<Operation> call(Operation operation, ModifyEvent event) async {
    return Right(event.updateOperation(operation));
  }
}
