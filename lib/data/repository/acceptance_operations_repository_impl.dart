import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/data/factories/acceptance_operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/domain/models/operation/acceptance_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';

@Singleton(as: AcceptanceOperationsRepository)
class AcceptanceOperationsRepositoryImpl extends BaseRepository
    implements AcceptanceOperationsRepository {
  const AcceptanceOperationsRepositoryImpl(
    super.apiProvider,
    this._cache,
    this._factory,
  );

  final AcceptanceOperationsCache _cache;
  final AcceptanceOperationFactory _factory;

  @override
  Future<List<AcceptanceOperation>> getAllSaved() async {
    final operations = await _cache.getAll();
    return Future.wait(operations.map(_factory.mapToOperation));
  }

  @override
  FResult<List<AcceptanceOperation>> getByProduct(int productId) async {
    try {
      final service = apiProvider.getApiService();
      final operation = await service.getAcceptanceOperationsByProduct(productId);

      final operationByProduct = [await _factory.mapRemoteToOperation(operation)];

      return Right(operationByProduct);
    } on DioException catch (e) {
      if (e.response?.statusCode == HttpStatus.notFound){
        return const Right([]);
      }
      return handleDioException(e);
    }
  }

  @override
  FResult<void> save(AcceptanceOperation operation) {
    final remoteOperation = _factory.mapToBody(operation);
    return _save(remoteOperation);
  }

  FResult<void> _save(RemoteAcceptanceOperationBody operationBody) async {
    try {
      final api = apiProvider.getApiService(isSafe: true);
      final answer = await api.saveAcceptanceOperation(operationBody);
      final local = answer.map(_factory.mapRemoteToLocal);
      await _cache.saveAll(local);
      return const Right(null);
    } on DioException catch (e) {
      return handleDioException(e, {
        HttpStatus.badRequest: const ProductNotExistOrNotActiveFailure(),
        HttpStatus.conflict: const OperationAlreadyExistFailure(),
      });
    }
  }

  @override
  FResult<void> cache(AcceptanceOperation operation) async {
    try {
      final notSyncOperation = operation.setStatus(OperationStatus.notSync);
      final local =
          _factory.mapToLocal(notSyncOperation as AcceptanceOperation);
      await _cache.save(local);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  FResult<void> delete(AcceptanceOperation operation) async {
    if (operation.status == OperationStatus.sync) {
      try {
        final api = apiProvider.getApiService(isSafe: true);
        await api.deleteAcceptanceOperation(operation.id);
      } on DioException catch (e) {
        return handleDioException(e);
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
}
