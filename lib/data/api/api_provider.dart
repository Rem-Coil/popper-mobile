import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/data/api/api_service.dart';
import 'package:popper_mobile/data/api/token_interceptor.dart';

@singleton
class ApiProvider {
  final String baseUrl;

  final _options = BaseOptions(
    connectTimeout: 500,
    sendTimeout: 500,
    receiveTimeout: 1500,
  );

  ApiProvider(@Named('BaseUrl') this.baseUrl);

  ApiService getApiService({bool isSafe = false, bool isLogging = false}) {
    final dio = Dio(_options);
    if (isSafe) {
      dio.interceptors.add(getIt<TokenInterceptor>());
    }

    if (isLogging) {
      dio.interceptors.add(_logInterceptor);
    }

    return ApiService(dio, baseUrl: baseUrl);
  }

  // ignore: unused_element
  LogInterceptor get _logInterceptor {
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
  String get baseUrlTest => 'http://remcoil.space:8080';
}
