import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/iterable_utils.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/cached_operations_cache.dart';
import 'package:popper_mobile/data/cache/completed_operations_cache.dart';
import 'package:popper_mobile/data/factories/operation_factory.dart';
import 'package:popper_mobile/data/models/operation/cached_operation.dart';
import 'package:popper_mobile/data/models/operation/completed_operation.dart';
import 'package:popper_mobile/data/models/operation/local_operation.dart';
import 'package:popper_mobile/data/models/operation/remote_operation.dart';
import 'package:popper_mobile/data/repository/scanned_entities_repository_impl.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/operation/operation_type.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _operationTypeKey = 'operation_type';

@Singleton(as: OperationsRepository)
class OperationsRepositoryImpl extends BaseRepository
    implements OperationsRepository {
  const OperationsRepositoryImpl(
    this._completedOperationCache,
    this._cachedOperationCache,
    this._scannedEntitiesRepository,
    this._authRepository,
    this._apiProvider,
  );

  final CompletedOperationsCache _completedOperationCache;
  final CachedOperationsCache _cachedOperationCache;

  final LocalScannedEntitiesRepository _scannedEntitiesRepository;
  final AuthRepository _authRepository;

  final ApiProvider _apiProvider;

  @override
  Future<List<Operation>> getAll() async {
    final operations = await Future.wait([
      _completedOperationCache.getAll(),
      _cachedOperationCache.getAll(),
    ]);

    return await Future.wait(
      operations.expand((e) => e).map(_updateOperationInfo),
    );
  }

  Future<Operation> _updateOperationInfo(LocalOperation local) async {
    final user = await _authRepository.getCurrentUserOrNull();
    final entity = await _scannedEntitiesRepository.getLocalEntityInfo(
      local.entityId,
      local.entityType,
    );

    return OperationFactory.mapToOperation(
      user!,
      local,
      entity,
    );
  }

  @override
  FResult<List<Operation>> getByBobbin(Bobbin bobbin) {
    // TODO: implement getByBobbin
    throw UnimplementedError();
  }

  @override
  FResult<void> save(Operation operation) async {
    try {
      final api = _apiProvider.getApiService(isSafe: true);
      final remoteOperation = OperationFactory.mapToRemote(operation);

      if (remoteOperation is RemoteBobbinOperation) {
        final answer = await api.saveBobbinOperation(remoteOperation);
        final saved = operation.setId(answer.id);
        await _saveLocally(saved);
      }

      if (remoteOperation is RemoteBatchOperation) {
        final remotes = await api.saveBatchOperation(remoteOperation);
        final operations = await _getOperationInfo(remotes);

        for (var o in operations) {
          await _saveLocally(o);
        }
      }

      await setLastOperationType(operation.type);
      return const Right(null);
    } on DioError catch (e) {
      final failure = handleError(e, {
        HttpStatus.badRequest: ItemNotExistOrNotActiveFailure(),
      });

      return Left(failure);
    }
  }

  Future<List<Operation>> _getOperationInfo(
    List<RemoteBobbinOperation> remotes,
  ) async {
    final user = await _authRepository.getCurrentUserOrNull();

    return remotes.map((remote) {
      final entity = Bobbin.unknown(remote.bobbinId);
      return OperationFactory.mapFromRemoteToOperation(
        user!,
        remote,
        entity,
      );
    }).toList();
  }

  Future<void> _saveLocally(Operation operation) async {
    final local = OperationFactory.mapToLocal(operation) as CompletedOperation;
    await _completedOperationCache.save(local);
  }

  @override
  FResult<void> cache(Operation operation) async {
    try {
      final notSynced = operation.setStatus(OperationStatus.notSync);
      final local = OperationFactory.mapToLocal(notSynced) as CachedOperation;

      await _cachedOperationCache.save(local);

      return const Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  FResult<void> delete(Operation operation) async {
    final local = OperationFactory.mapToLocal(operation);

    if (local is CompletedOperation) {
      await _completedOperationCache.delete(local);
    }

    if (local is CachedOperation) {
      await _cachedOperationCache.delete(local);
    }

    return const Right(null);
  }

  @override
  FResult<void> syncOperations() async {
    final operations = await _cachedOperationCache.getAll();

    for (var o in operations) {
      final operation = await _updateOperationInfo(o);
      final result = await save(operation);

      if (result.isLeft) {
        return Left(result.left);
      } else {
        await delete(operation);
      }
    }

    return const Right(null);
  }

  @override
  Future<OperationType?> getLastOperationType() async {
    final prefs = await SharedPreferences.getInstance();
    final operation = prefs.getString(_operationTypeKey);

    if (operation == null) return null;
    return OperationType.values.firstWhereOrNull((o) => o.name == operation);
  }

  @override
  Future<void> setLastOperationType(OperationType? actionType) async {
    if (actionType == null) return;
    final prefs = await SharedPreferences.getInstance();
    final action = actionType.name;
    prefs.setString(_operationTypeKey, action);
  }

  @override
  Future<void> subscribe(VoidCallback listener) async {
    _completedOperationCache.subscribe(listener);
    _cachedOperationCache.subscribe(listener);
  }

  @override
  Future<void> unsubscribe(VoidCallback listener) async {
    _completedOperationCache.unsubscribe(listener);
    _cachedOperationCache.unsubscribe(listener);
  }
}
