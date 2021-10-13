import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const token_key = 'token';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Either<Failure, User>> singIn(UserCredentials credentials) async {
    try {
      final service = ApiProvider().getApiService();
      final token = await service.singIn(credentials.toJson());
      await saveToken(token);
      final user = User.fromToken(token.token);
      return Right(user);

    } on DioError catch (e) {

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentials());
      }

      return Left(UnknownFailure());
    }
  }

  Future<User?> getCurrentUser() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString(token_key);
    return token != null ? User.fromToken(token) : null;
  }

  Future<void> saveToken(Token token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(token_key, token.token);
  }
}
