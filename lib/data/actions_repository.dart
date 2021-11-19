import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/local_repositories/local_actions_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/local_action.dart';

@singleton
class ActionsRepository {
  final LocalActionsRepository _localActionsRepository;

  ActionsRepository(this._localActionsRepository);

  Future<Either<Failure, bool>> saveAction(Action action) async {
    try {
      final service = ApiProvider().getApiService();
      final actionFromApi = await service.saveAction(action.toJson());
      _saveToCache(actionFromApi, true);
      return Right(true);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.forbidden:
          return Left(ActionAlreadyExistFailure());
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
      }
      return Left(UnknownFailure());
    }
  }

  Future<void> saveToCache(Action action) async {
    await _saveToCache(action, false);
  }

  Future<void> _saveToCache(Action action, bool isSuccess) async {
    final actionToLocal = action.toLocalAction(isSuccess);
    await _localActionsRepository.saveAction(actionToLocal);
  }

  Future<Either<Failure, List<LocalAction>>> getActions() async {
    final actions = await _localActionsRepository.getActions();
    return Right(actions.toList());
  }

  Future<Either<Failure, List<LocalAction>>> syncActions() async {
    final actions = await _localActionsRepository.syncEvents();
    return Right(actions.toList());
  }
}
