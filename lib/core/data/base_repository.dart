import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';

typedef StatusMappingRule = Map<int, Failure>;

abstract class BaseRepository {
  const BaseRepository(this.apiProvider);

  @protected
  final ApiProvider apiProvider;

  @protected
  Result<T> handleDioException<T>(
    DioException e, [
    StatusMappingRule rules = const {},
  ]) {
    log(e.logMessage);

    if (e.error is SocketException) {
      return Left(NoInternetFailure(e));
    }

    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return Left(ServerFailure(e));
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure(e));
      }

      final mapped = rules[statusCode];
      if (mapped != null) return Left(mapped);
    }

    return Left(UnknownFailure(e));
  }
}

extension _LogDioExceptionWithResponse on DioException {
  String get logMessage {
    String msg = toString();

    if (response != null) {
      msg += '\nResponse data: ${response?.data.toString()}';
    }

    return msg;
  }
}