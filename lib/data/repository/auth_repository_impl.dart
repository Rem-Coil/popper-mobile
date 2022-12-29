import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/repository/base_repository.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/data/cache/core/app_cache.dart';
import 'package:popper_mobile/data/factories/auth_factory.dart';
import 'package:popper_mobile/data/factories/user_factory.dart';
import 'package:popper_mobile/data/repository/token_storage.dart';
import 'package:popper_mobile/domain/models/user/credentials.dart';
import 'package:popper_mobile/domain/models/user/user.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  const AuthRepositoryImpl(this._apiProvider, this._storage);

  final ApiProvider _apiProvider;
  final TokenStorage _storage;

  @override
  FResult<void> singIn(Credentials credentials) async {
    try {
      final service = _apiProvider.getApiService();
      final json = AuthFactory.mapCredentials(credentials);
      final token = await service.singIn(json);
      await _storage.saveToken(token);
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  FResult<void> singUp(User user, String password) async {
    try {
      final service = _apiProvider.getApiService();
      final userJson = AuthFactory.mapUser(user, password);
      final token = await service.singUp(userJson);
      await _storage.saveToken(token);
      return const Right(null);
    } on DioError catch (e) {
      return Left(handleError(e));
    }
  }

  @override
  Future<User?> getCurrentUserOrNull() async {
    final token = await _storage.getToken();
    return token != null ? UserFactory.fromString(token.token) : null;
  }

  @override
  Future<void> logOut() async {
    await Future.wait([
      _storage.clear(),
      AppCache.clear(),
    ]);
  }
}
