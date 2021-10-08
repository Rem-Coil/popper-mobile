import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:popper_mobile/data/api/api_service.dart';

class ApiProvider {
  static const String baseUrl = 'https://popper-service.herokuapp.com';

  static ApiProvider? _instance;
  final Dio _dio = Dio();

  ApiProvider._();

  factory ApiProvider() {
    if (_instance == null) {
      _instance = ApiProvider._();
    }
    return _instance!;
  }

  ApiService getApiService() {
    // _dio.interceptors.add(LogInterceptor(
    //   logPrint: _logPrint,
    //   request: false,
    //   requestHeader: false,
    //   responseBody: false,
    // ));

    return ApiService(_dio, baseUrl: baseUrl);
  }

  void _logPrint(Object object) => log(object.toString());
}