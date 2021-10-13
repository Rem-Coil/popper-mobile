import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionsRepository {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Either<Failure, bool>> saveAction(String bobbinId, ActionType actionType) async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        return Left(NoUserFailure());
      }

      final action = Action(user.id, int.parse(bobbinId), actionType);
      final service = ApiProvider().getApiService();
      await service.saveAction(action.toJson());
      return Right(true);
    } on DioError catch (e) {

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
      }

      return Left(UnknownFailure());
    }
  }

  Future<User?> getCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString(AuthRepository.token_key);
    return token != null ? User.fromToken(token) : null;
  }
}