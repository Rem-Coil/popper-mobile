import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';

typedef MappingRule = Map<int, Failure>;

abstract class BaseRepository {
  const BaseRepository(this.apiProvider);

  @protected
  final ApiProvider apiProvider;

  @protected
  Future<Failure> handleError(
    DioError e, [
    MappingRule rules = const {},
  ]) async {
    log(e.error.toString());

    if (e.error is SocketException) {
      return NoInternetFailure(e);
    }

    final statusCode = e.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return ServerFailure(e);
        case HttpStatus.unauthorized:
          return WrongCredentialsFailure(e);
      }

      final mapped = rules[statusCode];
      if (mapped != null) return mapped;
    }

    return UnknownFailure(e);
  }
}
