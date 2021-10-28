import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/local_repositories/local_actions_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/action/local_action.dart';

@singleton
class ActionsRepository {
  final LocalActionsRepository _localActionsRepository;

  ActionsRepository(this._localActionsRepository);

  Future<Either<Failure, bool>> saveAction(Action action) async {
    try {
      final service = ApiProvider().getApiService();
      final actionFromApi = await service.saveAction(_actionToJson(action));
      _saveToCache(actionFromApi, true);
      return Right(true);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        _saveToCache(action, false);
        return Left(ServerFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.forbidden:
          return Left(WrongOperation());
        case HttpStatus.internalServerError:
          _saveToCache(action, false);
          return Left(ServerFailure());
      }

      _saveToCache(action, false);
      return Left(UnknownFailure());
    }
  }

  Future<void> _saveToCache(Action action, bool isSuccess) async {
    final actionToLocal = action.toLocalAction(isSuccess);
    await _localActionsRepository.saveAction(actionToLocal);
  }

  // TODO Remove - ждём изменения бека
  Map<String, dynamic> _actionToJson(Action action) {
    return <String, dynamic>{
      'operator_id': action.userId,
      'bobbin_id': action.bobbinId,
      'action_type': actionTypeEnumMap[action.type],
    };
  }

  Future<Either<Failure, List<LocalAction>>> getActions() async {
    final actions = await _localActionsRepository.getActions();
    return Right(actions.toList());
  }
}

// TODO Remove - ждём изменения бека
const actionTypeEnumMap = {
  ActionType.winding: 'winding',
  ActionType.output: 'output',
  ActionType.isolation: 'isolation',
  ActionType.molding: 'molding',
  ActionType.crimping: 'crimping',
  ActionType.quality: 'quality',
  ActionType.testing: 'testing',
};
