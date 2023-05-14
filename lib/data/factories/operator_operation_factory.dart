import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

@singleton
class OperatorOperationFactory extends OperationFactory<OperatorOperation> {
  const OperatorOperationFactory(
    super._usersRepository,
    super._productsRepository,
    super._operationTypesRepository,
  );

  LocalOperatorOperation mapToLocal(OperatorOperation operation) {
    return LocalOperatorOperation(
      id: operation.id,
      operationId: operation.type?.id ?? defaultOperationId,
      userId: operation.user.id,
      productId: operation.product.id,
      time: operation.time,
      status: mapOperationStatus(operation.status),
      isRepair: operation.isRepair,
    );
  }

  LocalOperatorOperation mapRemoteToLocal(RemoteOperatorOperation operation) {
    return LocalOperatorOperation(
      id: operation.id,
      operationId: operation.operationId,
      userId: operation.userId,
      productId: operation.productId,
      time: operation.time,
      status: LocalOperationStatus.sync,
      isRepair: operation.isRepair,
    );
  }

  Future<OperatorOperation> mapToOperation(LocalOperatorOperation local) {
    return mapWithConstruct(
      local,
      (user, product, type) => OperatorOperation(
        id: local.id,
        user: user ?? const User.unknown(),
        product: product,
        type: type,
        time: local.time,
        status: mapLocalOperationStatus(local.status),
        isRepair: local.isRepair,
      ),
    );
  }

  RemoteOperatorOperationBody mapToBody(OperatorOperation operation) {
    return RemoteOperatorOperationBody(
      operationId: operation.type!.id,
      productId: operation.product.id,
      time: operation.time, isRepair: operation.isRepair,
    );
  }

  RemoteOperatorOperationBody mapLocalToBody(LocalOperatorOperation operation) {
    return RemoteOperatorOperationBody(
      operationId: operation.operationId,
      productId: operation.productId,
      time: operation.time,
      isRepair: operation.isRepair,
    );
  }
}
