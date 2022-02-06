import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AuthRepository {
  static const token_key = 'token';
  final ApiProvider _apiProvider;

  AuthRepository(this._apiProvider);

  Future<Either<Failure, User>> singIn(UserCredentials credentials) async {
    try {
      final service = _apiProvider.getApiService();
      final token = await service.singIn(credentials);
      await saveToken(token);
      final user = User.fromToken(token.token);
      return Right(user);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
      }

      return Left(UnknownFailure());
    }
  }

  Future<User?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(token_key);
    return token != null ? User.fromToken(token) : null;
  }

  Future<void> saveToken(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(token_key, token.token);
  }
}