import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/actions_cache.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class ActionsRepository {
  static const String _ACTION_TYPE_KEY = 'action_type';
  final ApiProvider _apiProvider;
  final ActionsCache _actionsCache;

  ActionsRepository(this._actionsCache, this._apiProvider);

  Future<Either<Failure, Action>> saveAction(Action action) async {
    try {
      final remoteAction = ActionRemote.fromAction(action);
      final api = _apiProvider.getApiService();
      final savedAction = await api.saveAction(remoteAction);
      await _actionsCache.saveAction(savedAction);
      await setLastActionType(savedAction.type);
      return Right(savedAction);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
        case HttpStatus.forbidden:
          return Left(ActionAlreadyExistFailure());
      }

      return Left(UnknownFailure());
    }
  }

  Future<Either<Failure, void>> saveWrongAction(Action action) async {
    try {
      await _actionsCache.saveNoSavedAction(action);
      return Right(null);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  Future<ActionType?> getLastActionType() async {
    final prefs = await SharedPreferences.getInstance();
    final action = prefs.getString(_ACTION_TYPE_KEY);
    if (action == null) return null;
    return ActionType.values.firstWhere((a) => a.name == action, orElse: null);
  }

  Future<void> setLastActionType(ActionType? actionType) async {
    if (actionType == null) return;
    final prefs = await SharedPreferences.getInstance();
    final action = actionType.name;
    prefs.setString(_ACTION_TYPE_KEY, action);
  }
}
