import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
          await FirebaseCrashlytics.instance.recordError(
            e.error,
            e.stackTrace,
            reason: 'Server Error',
          );
          return ServerFailure(e);
        case HttpStatus.unauthorized:
          return WrongCredentialsFailure(e);
      }

      final mapped = rules[statusCode];
      if (mapped != null) return mapped;
    }

    await FirebaseCrashlytics.instance.recordError(
      e.error,
      e.stackTrace,
      reason: 'UnknownFailure',
    );
    return UnknownFailure(e);
  }
}
