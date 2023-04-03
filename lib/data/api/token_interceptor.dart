import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/repository/token_storage.dart';

@injectable
class TokenInterceptor extends Interceptor {
  TokenInterceptor(this._storage);

  final TokenStorage _storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer ${token.token}';
    }

    handler.next(options);
  }
}
