import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/api/api_service.dart';

@singleton
class ApiProvider {
  static const String baseUrl = 'https://popper-service.herokuapp.com';
  final Dio _dio = Dio();

  ApiService getApiService() {
    // _dio.interceptors.add(_logInterceptor);
    return ApiService(_dio, baseUrl: baseUrl);
  }

  LogInterceptor get _logInterceptor {
    return LogInterceptor(
      logPrint: _logPrint,
      request: false,
      requestHeader: false,
      responseBody: false,
    );
  }

  void _logPrint(Object object) => log(object.toString());
}
