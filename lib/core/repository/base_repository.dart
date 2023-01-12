import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';

typedef MappingRule = Map<int, Failure>;

abstract class BaseRepository {
  const BaseRepository();

  @protected
  Failure handleError(DioError e, [MappingRule rules = const {}]) {
    log(e.error.toString());

    if (e.error is SocketException) {
      return const NoInternetFailure();
    }

    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return const ServerFailure();
        case HttpStatus.unauthorized:
          return const WrongCredentialsFailure();
      }

      final mapped = rules[statusCode];
      if (mapped != null) return mapped;
    }

    return const UnknownFailure();
  }
}
