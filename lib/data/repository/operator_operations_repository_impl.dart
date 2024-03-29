import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/data/factories/operator_operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operator_operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@Singleton(as: OperatorOperationsRepository)
class OperatorOperationsRepositoryImpl extends BaseRepository
    implements OperatorOperationsRepository {
  const OperatorOperationsRepositoryImpl(
    super.apiProvider,
    this._cache,
    this._factory,
  );

  final OperatorOperationsCache _cache;
  final OperatorOperationFactory _factory;

  @override
  Future<List<OperatorOperation>> getAllSaved() async {
    final operations = await _cache.getAll();
    return Future.wait(operations.map(_factory.mapToOperation));
  }

  @override
  FResult<List<OperatorOperation>> getByProduct(int productId) async {
    try {
      final service = apiProvider.getApiService();
      final operations =
          await service.getOperatorOperationsByProduct(productId);

      final operationsByProduct = await Future.wait(
        operations.map(_factory.mapRemoteToOperation),
      );

      return Right(operationsByProduct);
    } on DioError catch (e) {
      final failure = await handleError(e);
      return Left(failure);
    }
  }

  @override
  FResult<void> save(OperatorOperation operation) {
    final remoteOperation = _factory.mapToBody(operation);
    return _save(remoteOperation);
  }

  @override
  FResult<void> cache(OperatorOperation operation) async {
    try {
      final notSyncOperation = operation.setStatus(OperationStatus.notSync);
      final local = _factory.mapToLocal(notSyncOperation as OperatorOperation);
      await _cache.save(local);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  FResult<void> delete(OperatorOperation operation) async {
    if (operation.status == OperationStatus.sync) {
      try {
        final api = apiProvider.getApiService(isSafe: true);
        await api.deleteOperatorOperation(operation.id);
      } on DioError catch (e) {
        return Left(await handleError(e));
      }
    }

    final local = _factory.mapToLocal(operation);
    await _cache.delete(local.key);
    return const Right(null);
  }

  @override
  FResult<void> syncOperations() async {
    final operations = await _cache.getAll();
    final notSync =
        operations.where((o) => o.status == LocalOperationStatus.notSync);

    var isContainsError = false;
    for (var o in notSync) {
      final remote = _factory.mapLocalToBody(o);
      final r = await _save(remote);

      if (r.isRight) {
        await _cache.delete(o.key);
      } else {
        final error = r.left;
        if (error is! NoInternetFailure) {
          isContainsError = true;
        }
      }
    }

    return isContainsError
        ? const Left(SynchronizationWithErrorFailure())
        : const Right(null);
  }

  FResult<void> _save(RemoteOperatorOperationBody operationBody) async {
    try {
      final api = apiProvider.getApiService(isSafe: true);
      final answer = await api.saveOperatorOperation(operationBody);
      final local = _factory.mapRemoteToLocal(answer);
      await _cache.save(local);
      return const Right(null);
    } on DioError catch (e) {
      final failure = await handleError(e, {
        HttpStatus.badRequest: const ProductNotExistOrNotActiveFailure(),
        HttpStatus.conflict: const OperationAlreadyExistFailure(),
      });

      return Left(failure);
    }
  }
}
