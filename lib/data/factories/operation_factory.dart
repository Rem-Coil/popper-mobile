import 'package:flutter/foundation.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/repository/users_repository.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/models/product/product_info.dart';
import 'package:popper_mobile/domain/models/user/user.dart';
import 'package:popper_mobile/domain/repository/operations_types_repository.dart';
import 'package:popper_mobile/domain/repository/products_repository.dart';

abstract class OperationFactory<T extends Operation> {
  const OperationFactory(
    this._usersRepository,
    this._productsRepository,
    this._operationTypesRepository,
  );

  final UsersRepository _usersRepository;
  final ProductsRepository _productsRepository;
  final OperationTypesRepository _operationTypesRepository;

  @protected
  Future<T> mapWithConstruct(
    LocalOperation local,
    T Function(User? user, ProductInfo product, OperationType? type) construct,
  ) async {
    final userRes = await _usersRepository.getById(local.userId);
    final user = userRes.fold((_) => null, (u) => u);

    final product = await _productsRepository.getInfo(local.productId);

    final typeRes =
        await _operationTypesRepository.getTypeById(local.operationId);
    final type = typeRes.fold((_) => null, (t) => t);

    return construct(user, product, type);
  }

  @protected
  Future<T> mapRemoteWithConstruct(
    RemoteOperation remote,
    T Function(User? user, ProductInfo product, OperationType? type) construct,
  ) async {
    final userRes = await _usersRepository.getById(remote.userId);
    final user = userRes.fold((_) => null, (u) => u);

    final product = await _productsRepository.getInfo(remote.productId);

    final typeRes =
        await _operationTypesRepository.getTypeById(remote.operationId);
    final type = typeRes.fold((_) => null, (t) => t);

    return construct(user, product, type);
  }

  @protected
  LocalOperationStatus mapOperationStatus(OperationStatus status) {
    switch (status) {
      case OperationStatus.draft:
        return LocalOperationStatus.draft;
      case OperationStatus.sync:
        return LocalOperationStatus.sync;
      case OperationStatus.notSync:
        return LocalOperationStatus.notSync;
    }
  }

  @protected
  OperationStatus mapLocalOperationStatus(LocalOperationStatus status) {
    switch (status) {
      case LocalOperationStatus.draft:
        return OperationStatus.draft;
      case LocalOperationStatus.sync:
        return OperationStatus.sync;
      case LocalOperationStatus.notSync:
        return OperationStatus.notSync;
    }
  }
}
