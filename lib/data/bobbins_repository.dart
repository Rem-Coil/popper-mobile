import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/qr_code/bobbin.dart';


@singleton
class BobbinsRepository {

  Future<Either<Failure, Bobbin>> getBobbinInfo(int id) async {
    try {
      final service = ApiProvider().getApiService();
      final bobbin = await service.getBobbinInfo(id);
      return Right(bobbin);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

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