import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/data/factories/check_operation_factory.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation_body.dart';
import 'package:popper_mobile/domain/models/operation/check_operation.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';

@Singleton(as: CheckOperationsRepository)
class CheckOperationsRepositoryImpl extends BaseRepository
    implements CheckOperationsRepository {
  const CheckOperationsRepositoryImpl(
    super.apiProvider,
    this._cache,
    this._factory,
  );

  final CheckOperationsCache _cache;
  final CheckOperationFactory _factory;

  @override
  Future<List<CheckOperation>> getAll() async {
    final operations = await _cache.getAll();
    return Future.wait(operations.map(_factory.mapToOperation));
  }

  @override
  FResult<void> save(CheckOperation operation) {
    final remoteOperation = _factory.mapToBody(operation);
    return _save(remoteOperation);
  }

  FResult<void> _save(RemoteCheckOperationBody operationBody) async {
    try {
      final api = apiProvider.getApiService(isSafe: true);
      final answer = await api.saveCheckOperation(operationBody);
      final local = _factory.mapRemoteToLocal(answer);
      await _cache.save(local);
      return const Right(null);
    } on DioError catch (e) {
      final failure = await handleError(e, {
        HttpStatus.badRequest: const ProductNotExistOrNotActiveFailure(),
      });

      return Left(failure);
    }
  }

  @override
  FResult<void> cache(CheckOperation operation) async {
    try {
      final notSyncOperation = operation.setStatus(OperationStatus.notSync);
      final local = _factory.mapToLocal(notSyncOperation as CheckOperation);
      await _cache.save(local);
      return const Right(null);
    } on Exception {
      return const Left(CacheFailure());
    }
  }

  @override
  FResult<void> syncOperations() async {
    final operations = await _cache.getAll();
    final notSynced =
        operations.where((o) => o.status == LocalOperationStatus.notSync);

    for (var o in notSynced) {
      final operation = _factory.mapLocalToBody(o);
      final result = await _save(operation);

      if (result.isLeft) {
        return Left(result.left);
      } else {
        await _cache.delete(o.key);
      }
    }

    return const Right(null);
  }

  @override
  FResult<void> delete(CheckOperation operation) async {
    if (operation.status == OperationStatus.sync) {
      try {
        final api = apiProvider.getApiService();
        await api.deleteCheckOperation(operation.id);
      } on DioError catch (e) {
        return Left(await handleError(e));
      }
    }

    final local = _factory.mapToLocal(operation);
    await _cache.delete(local.key);
    return const Right(null);
  }
}
