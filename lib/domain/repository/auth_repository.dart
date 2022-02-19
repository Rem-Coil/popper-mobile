import 'package:dartz/dartz.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/auth/token.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/models/auth/user_credentials.dart';
import 'package:popper_mobile/models/auth/user_remote.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> singIn(UserCredentials credentials);

  Future<Either<Failure, User>> singUp(UserRemote remote);

  Future<void> logOut();

  Future<User?> getCurrentUser();

  Future<void> saveToken(Token token);
}
