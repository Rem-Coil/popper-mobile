import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/api/api_service.dart';

@singleton
class ApiProvider {
  final String baseUrl;
  final Dio _dio = Dio();

  ApiProvider(@Named('BaseUrl') this.baseUrl);

  ApiService getApiService() {
    // _dio.interceptors.add(_logInterceptor);
    return ApiService(_dio, baseUrl: baseUrl);
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
  String get baseUrlTest => 'https://popper-service.herokuapp.com';

  @Named('BaseUrl')
  @Environment('prod')
  String get baseUrlProd => 'https://webpanel.remcoil.space';
}
