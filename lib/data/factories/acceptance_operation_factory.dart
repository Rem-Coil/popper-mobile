import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/many_products_remote_operation_body.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
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
      productsId: operation.products.map((p) => p.id).toList(),
      time: operation.time,
      status: mapOperationStatus(operation.status),
    );
  }

  LocalAcceptanceOperation mapRemoteToLocal(
      List<RemoteAcceptanceOperation> operations) {
    final operation = operations.first;
    return LocalAcceptanceOperation(
      id: operation.id,
      userId: operation.userId,
      productsId: operations.map((o) => o.productId).toList(),
      time: operation.time,
      status: LocalOperationStatus.sync,
    );
  }

  Future<AcceptanceOperation> mapToOperation(LocalAcceptanceOperation local) {
    return mapWithConstruct(
      local,
      (user, products, type) => AcceptanceOperation(
        id: local.id,
        user: user ?? const User.unknown(),
        products: products,
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
        products: [product],
        time: remote.time,
        status: OperationStatus.sync,
      ),
    );
  }

  ManyProductsRemoteAcceptanceOperationBody mapToBody(
      AcceptanceOperation operation) {
    return ManyProductsRemoteAcceptanceOperationBody(
      productsId: operation.products.map((p) => p.id).toList(),
      time: operation.time,
    );
  }

  ManyProductsRemoteAcceptanceOperationBody mapLocalToBody(
      LocalAcceptanceOperation operation) {
    return ManyProductsRemoteAcceptanceOperationBody(
      productsId: operation.productsId,
      time: operation.time,
    );
  }
}
