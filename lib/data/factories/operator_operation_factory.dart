import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/many_products_remote_operation_body.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
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
      productsId: operation.products.map((p) => p.id).toList(),
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
      productsId: [operation.productId],
      time: operation.time,
      status: LocalOperationStatus.sync,
      isRepair: operation.isRepair,
    );
  }

  Future<OperatorOperation> mapToOperation(LocalOperatorOperation local) {
    return mapWithConstruct(
      local,
      (user, products, type) => OperatorOperation(
        id: local.id,
        user: user ?? const User.unknown(),
        products: products,
        type: type,
        time: local.time,
        status: mapLocalOperationStatus(local.status),
        isRepair: local.isRepair,
      ),
    );
  }

  Future<OperatorOperation> mapRemoteToOperation(
    RemoteOperatorOperation remote,
  ) {
    return mapRemoteWithConstruct(
      remote,
      (user, product, type) => OperatorOperation(
        id: remote.id,
        user: user ?? const User.unknown(),
        products: [product],
        type: type,
        time: remote.time,
        status: OperationStatus.sync,
        isRepair: remote.isRepair,
      ),
    );
  }

  ManyProductsRemoteOperatorOperationBody mapToBody(
      OperatorOperation operation) {
    return ManyProductsRemoteOperatorOperationBody(
      operationId: operation.type!.id,
      productsId: operation.products.map((p) => p.id).toList(),
      time: operation.time,
      isRepair: operation.isRepair,
    );
  }

  ManyProductsRemoteOperatorOperationBody mapLocalToBody(
      LocalOperatorOperation operation) {
    return ManyProductsRemoteOperatorOperationBody(
      operationId: operation.operationId,
      productsId: operation.productsId,
      time: operation.time,
      isRepair: operation.isRepair,
    );
  }
}
