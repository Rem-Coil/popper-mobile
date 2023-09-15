import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/app_cache.dart';
import 'package:popper_mobile/core/data/base_repository.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/core/utils/typedefs.dart';
import 'package:popper_mobile/data/factories/auth_factory.dart';
import 'package:popper_mobile/data/factories/user_factory.dart';
import 'package:popper_mobile/data/repository/token_storage.dart';
import 'package:popper_mobile/domain/models/user/credentials.dart';
import 'package:popper_mobile/domain/models/user/user_identity.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  const AuthRepositoryImpl(super.apiProvider, this._storage);

  final TokenStorage _storage;

  @override
  FResult<void> singIn(Credentials credentials) async {
    try {
      final service = apiProvider.getApiService();
      final json = AuthFactory.mapCredentials(credentials);
      final token = await service.singIn(json);
      await _storage.saveToken(token);
      return const Right(null);
    } on DioException catch (e) {
      return handleDioException(e, {
        HttpStatus.badRequest: const WrongCredentialsFailure(),
        HttpStatus.notFound: const NoSuchUserFailure(),
      });
    }
  }

  @override
  FResult<void> singUp(UserIdentity user, String password) async {
    try {
      final service = apiProvider.getApiService();
      final userJson = AuthFactory.mapUser(user, password);
      final token = await service.singUp(userJson);
      await _storage.saveToken(token);
      return const Right(null);
    } on DioException catch (e) {
      return handleDioException(e, {
        HttpStatus.conflict: const UserAlreadyExistFailure(),
      });
    }
  }

  @override
  Future<void> logOut() async {
    await Future.wait([
      _storage.clear(),
      AppCache.clear(),
    ]);
  }

  @override
  Future<UserIdentity> getCurrentUser() async {
    final user = await getCurrentUserOrNull();
    if (user != null) return user;
    throw const UserNotLoginFailure();
  }

  @override
  Future<UserIdentity?> getCurrentUserOrNull() async {
    final token = await _storage.getToken();
    return token != null ? UserFactory.fromString(token.token) : null;
  }
}
