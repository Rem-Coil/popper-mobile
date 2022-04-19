import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/api/api_provider.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:popper_mobile/models/auth/user_remote.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  static const _tokenKey = 'token';
  final ApiProvider _apiProvider;

  AuthRepositoryImpl(this._apiProvider);

  @override
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
        case HttpStatus.badGateway:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
      }

      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, User>> singUp(UserRemote user) async {
    try {
      final service = _apiProvider.getApiService();
      final token = await service.singUp(user);
      await saveToken(token);
      final savedUser = User.fromToken(token.token);
      return Right(savedUser);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        return Left(NoInternetFailure());
      }

      switch (e.response?.statusCode) {
        case HttpStatus.internalServerError:
        case HttpStatus.badGateway:
          return Left(ServerFailure());
        case HttpStatus.unauthorized:
          return Left(WrongCredentialsFailure());
      }

      return Left(UnknownFailure());
    }
  }

  @override
  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await Hive.deleteFromDisk();
  }

  @override
  Future<User?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null ? User.fromToken(token) : null;
  }

  @override
  Future<void> saveToken(Token token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token.token);
  }
}
