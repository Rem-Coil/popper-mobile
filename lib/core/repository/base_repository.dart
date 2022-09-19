import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';

typedef MappingRule = Map<int, Failure>;

class BaseRepository {
  @protected
  Failure handleError(DioError e, [MappingRule rules = const {}]) {
    if (e.error is SocketException) {
      return NoInternetFailure();
    }

    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return ServerFailure();
        case HttpStatus.unauthorized:
          return WrongCredentialsFailure();
      }

      final mapped = rules[statusCode];
      if (mapped != null) return mapped;
    }

    return UnknownFailure();
  }
}