import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class OperationRepository {
  static const String _OPERATION_TYPE_KEY = 'operation_type';
  final ApiProvider _apiProvider;
  final OperationsCache _operationsCache;

  OperationRepository(this._operationsCache, this._apiProvider);

  Future<Either<Failure, void>> saveOperation(Operation operation) async {
    try {
      final remoteOperation = operation.toRemote();
      final api = _apiProvider.getApiService();
      final savedOperation = await api.saveOperation(remoteOperation);
      final operationWithId = operation.copyWithId(savedOperation);
      await _operationsCache.saveOperation(operationWithId);
      await _setLastOperationType(savedOperation.type);
      return Right(null);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
        case HttpStatus.forbidden:
          return Left(OperationAlreadyExistFailure());
      }

      return Left(UnknownFailure());
    }
  }

  Future<Either<Failure, void>> updateOperation(Operation operation) async {
    try {
      final remoteAction = operation.toRemote();
      final api = _apiProvider.getApiService();
      await api.updateOperation(remoteAction);
      await _operationsCache.updateOperation(operation);
      return Right(null);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
        case HttpStatus.forbidden:
          return Left(OperationAlreadyExistFailure());
      }

      return Left(UnknownFailure());
    }
  }

  Future<Either<Failure, void>> cacheOperation(Operation operation) async {
    try {
      await _operationsCache.cacheOperation(operation);
      return Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  Future<OperationType?> getLastOperationType() async {
    final prefs = await SharedPreferences.getInstance();
    final operation = prefs.getString(_OPERATION_TYPE_KEY);

    if (operation == null) return null;
    return OperationType.values.firstWhere(
      (o) => o.name == operation,
      orElse: null,
    );
  }

  Future<void> _setLastOperationType(OperationType? actionType) async {
    if (actionType == null) return;
    final prefs = await SharedPreferences.getInstance();
    final action = actionType.name;
    prefs.setString(_OPERATION_TYPE_KEY, action);
  }
}
