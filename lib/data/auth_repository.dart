import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/token.dart';
import 'package:popper_mobile/models/user_credentials.dart';

class AuthRepository {
  Future<Either<Failure, Token>> singIn(UserCredentials credentials) async {
    try {
      final service = ApiProvider().getApiService();
      final token = await service.singIn(credentials.toJson());
      return Right(token);

    } on DioError catch (e) {

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentials());
      }

      return Left(UnknownFailure());
    }
  }
}
