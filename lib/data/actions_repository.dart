import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/action/action.dart';

class ActionsRepository {
  Future<Either<Failure, bool>> saveAction(Action action) async {
    try {
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
}