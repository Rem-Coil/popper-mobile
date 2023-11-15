import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/domain/models/operation/acceptance_operation.dart';

import '../../domain/models/operation/operation.dart';
import '../../domain/models/user/user.dart';

@singleton
class AcceptanceOperationFactory extends OperationFactory<AcceptanceOperation> {
  const AcceptanceOperationFactory(
    super._usersRepository,
    super._productsRepository,
    super._operationTypesRepository,
  );

  LocalAcceptanceOperation mapToLocal(AcceptanceOperation operation) {
    return LocalAcceptanceOperation(
      id: operation.id,
      userId: operation.user.id,
      productId: operation.product.id,
      time: operation.time,
      status: mapOperationStatus(operation.status),
    );
  }

  LocalAcceptanceOperation mapRemoteToLocal(
      RemoteAcceptanceOperation operation) {
    return LocalAcceptanceOperation(
      id: operation.id,
      userId: operation.userId,
      productId: operation.productId,
      time: operation.time,
      status: LocalOperationStatus.sync,
    );
  }

  Future<AcceptanceOperation> mapToOperation(LocalAcceptanceOperation local) {
    return mapWithConstruct(
      local,
      (user, product, type) => AcceptanceOperation(
        id: local.id,
        user: user ?? const User.unknown(),
        product: product,
        time: local.time,
        status: mapLocalOperationStatus(local.status),
      ),
    );
  }

  Future<AcceptanceOperation> mapRemoteToOperation(
      RemoteAcceptanceOperation remote) {
    return mapRemoteWithConstruct(
      remote,
      (user, product, type) => AcceptanceOperation(
        id: remote.id,
        user: user ?? const User.unknown(),
        product: product,
        time: remote.time,
        status: OperationStatus.sync,
      ),
    );
  }

  RemoteAcceptanceOperationBody mapToBody(AcceptanceOperation operation) {
    return RemoteAcceptanceOperationBody(
      productId: operation.product.id,
      time: operation.time,
    );
  }

  RemoteAcceptanceOperationBody mapLocalToBody(
      LocalAcceptanceOperation operation) {
    return RemoteAcceptanceOperationBody(
      productId: operation.productId,
      time: operation.time,
    );
  }
}
