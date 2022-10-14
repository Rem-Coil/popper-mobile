import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/iterable_utils.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/operations_repository.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO - протестировать появление повторяющихся операций
@Singleton(as: OperationsRepository)
class OperationsRepositoryImpl extends BaseRepository
    implements OperationsRepository {
  static const String _operationTypeKey = 'operation_type';
  final ApiProvider _apiProvider;
  final OperationsCache _operationsCache;
  final AuthRepository _authRepository;

  OperationsRepositoryImpl(
    this._apiProvider,
    this._operationsCache,
    this._authRepository,
  );

  @override
  Future<Either<Failure, void>> saveOperation(Operation operation) async {
    try {
      final remoteOperation = operation.toRemote();
      final api = _apiProvider.getApiService();
      final token = await _authRepository.getUserToken();
      final savedOperation =
          await api.saveOperation('Bearer $token', remoteOperation);
      final operationWithId = operation.copyWithId(savedOperation);
      await _operationsCache.addCompletedOperation(operationWithId);
      await setLastOperationType(savedOperation.type);
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateOperation(Operation operation) async {
    try {
      final remoteAction = operation.toRemote();
      final api = _apiProvider.getApiService();
      final token = await _authRepository.getUserToken();
      await api.updateOperation('Bearer $token', remoteAction);
      await _operationsCache.moveCachedToCompleted(operation);
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  Future<void> _syncOperation(Operation operation) async {
    final remoteOperation = operation.toRemote();
    final api = _apiProvider.getApiService();

    final token = await _authRepository.getUserToken();
    final savedOperation =
        await api.saveOperation('Bearer $token', remoteOperation);

    final operationWithId = operation.copyWithId(savedOperation);

    await _operationsCache.addCompletedOperation(operationWithId);
    await _operationsCache.deleteCacheOperation(operation);
  }

  @override
  Future<Either<Failure, void>> syncOperations() async {
    try {
      final cached = await _operationsCache.getCachedOperations();
      for (var operation in cached) {
        await _syncOperation(operation);
      }
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> cacheOperation(Operation operation) async {
    try {
      await _operationsCache.addCachedOperation(operation);
      return const Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
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
  Future<Either<Failure, void>> deleteCachedOperation(
    Operation operation,
  ) async {
    try {
      _operationsCache.deleteCacheOperation(operation);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteSavedOperation(
    Operation operation,
  ) async {
    try {
      final api = _apiProvider.getApiService();
      final token = await _authRepository.getUserToken();
      await api.deleteOperation('Bearer $token', operation.id);
      await _operationsCache.deleteCompletedOperation(operation);
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<FullOperation>>> getAll(Bobbin bobbin) async {
    try {
      final api = _apiProvider.getApiService();
      final operations = await api.getBobbinHistory(bobbin.id);
      return Right(operations);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }
}
