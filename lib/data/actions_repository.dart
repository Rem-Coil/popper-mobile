import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/action/action.dart';

@singleton
class ActionsRepository {
  Future<Either<Failure, bool>> saveAction(Action action) async {
    try {
      /// cache
      final service = ApiProvider().getApiService();
      await service.saveAction(actionToJson(action));
      return Right(true);
    } on DioError catch (e) {
      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
      }

      return Left(UnknownFailure());
    }
  }

  // TODO Remove - ждём изменения бека
  Map<String, dynamic> actionToJson(Action action) {
    return <String, dynamic>{
      'operator_id': action.userId,
      'bobbin_id': action.bobbinId,
      'action_type': actionTypeEnumMap[action.type],
    };
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
