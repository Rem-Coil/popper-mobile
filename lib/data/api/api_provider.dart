import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/data/api/api_service.dart';
import 'package:popper_mobile/data/api/token_interceptor.dart';

@singleton
class ApiProvider {
  ApiProvider(@Named('BaseUrl') this.baseUrl);

  final String baseUrl;

  final _options = BaseOptions();

  ApiService getApiService({bool isSafe = false, bool isLogging = false}) {
    final dio = Dio(_options);
    if (isSafe) {
      dio.interceptors.add(getIt<TokenInterceptor>());
    }

    if (isLogging) {
      dio.interceptors.add(_allMessagesInterceptor);
    }

    return ApiService(dio, baseUrl: baseUrl);
  }

  LogInterceptor get _allMessagesInterceptor {
    return LogInterceptor(
      logPrint: _logPrint,
      error: true,
      requestBody: true,
      responseHeader: true,
      request: true,
      requestHeader: true,
      responseBody: true,
    );
  }

  void _logPrint(Object object) => log(object.toString());
}

@module
abstract class ServerAddressModule {
  @Named('BaseUrl')
  @Environment('dev')
  @Environment('prod')
  String get baseUrlTest => 'https://api.popper.remcoil.space';
}
