import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/user/user.dart';

@singleton
class CheckOperationFactory extends OperationFactory<CheckOperation> {
  const CheckOperationFactory(
    super._usersRepository,
    super._productsRepository,
    super._operationTypesRepository,
  );

  LocalCheckOperation mapToLocal(CheckOperation operation) {
    return LocalCheckOperation(
      id: operation.id,
      operationId: operation.type?.id ?? defaultOperationId,
      userId: operation.user.id,
      productId: operation.product.id,
      time: operation.time,
      status: mapOperationStatus(operation.status),
      isSuccessful: operation.isSuccessful,
      isNeedRepair: operation.isNeedRepair,
      checkType: _checkTypeToString(operation.checkType),
      comment: operation.comment,
    );
  }

  LocalCheckOperation mapRemoteToLocal(RemoteCheckOperation operation) {
    return LocalCheckOperation(
      id: operation.id,
      operationId: operation.operationId,
      userId: operation.userId,
      productId: operation.productId,
      time: operation.time,
      status: LocalOperationStatus.sync,
      isSuccessful: operation.isSuccessful,
      isNeedRepair: operation.isNeedRepair,
      checkType: operation.checkType,
      comment: operation.comment,
    );
  }

  Future<CheckOperation> mapToOperation(LocalCheckOperation local) {
    return mapWithConstruct(
      local,
      (user, product, type) => CheckOperation(
        id: local.id,
        user: user ?? const User.unknown(),
        product: product,
        type: type,
        time: local.time,
        status: mapLocalOperationStatus(local.status),
        comment: local.comment,
        isSuccessful: local.isSuccessful,
        isNeedRepair: local.isNeedRepair,
        checkType: _mapToCheck(local.checkType),
      ),
    );
  }

  Future<CheckOperation> mapRemoteToOperation(RemoteCheckOperation remote) {
    return mapRemoteWithConstruct(
      remote,
      (user, product, type) => CheckOperation(
        id: remote.id,
        user: user ?? const User.unknown(),
        product: product,
        type: type,
        time: remote.time,
        status: OperationStatus.sync,
        comment: remote.comment,
        isSuccessful: remote.isSuccessful,
        isNeedRepair: remote.isNeedRepair,
        checkType: _mapToCheck(remote.checkType),
      ),
    );
  }

  RemoteCheckOperationBody mapToBody(CheckOperation operation) {
    return RemoteCheckOperationBody(
      operationId: operation.type!.id,
      productId: operation.product.id,
      time: operation.time,
      isSuccessful: operation.isSuccessful,
      isNeedRepair: operation.isNeedRepair,
      controlType: _checkTypeToString(operation.checkType),
      comment: operation.comment,
    );
  }

  RemoteCheckOperationBody mapLocalToBody(LocalCheckOperation operation) {
    return RemoteCheckOperationBody(
      operationId: operation.operationId,
      productId: operation.productId,
      time: operation.time,
      isSuccessful: operation.isSuccessful,
      isNeedRepair: operation.isNeedRepair,
      controlType: operation.checkType,
      comment: operation.comment,
    );
  }

  String _checkTypeToString(CheckType type) {
    switch (type) {
      case CheckType.testing:
        return 'TESTING';
      case CheckType.otk:
        return 'OTK';
    }
  }

  CheckType _mapToCheck(String type) {
    switch (type) {
      case 'TESTING':
        return CheckType.testing;
      case 'OTK':
        return CheckType.otk;
      default:
        throw Exception('Wrong check type');
    }
  }
}
