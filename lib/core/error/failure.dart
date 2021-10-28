import 'package:flutter/cupertino.dart';

@immutable
abstract class Failure {
  String get message;
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server error';
}

class WrongCredentials extends Failure {
  @override
  String get message => 'Неправильные данные пользователя';
}

class WrongOperation extends Failure {
  @override
  String get message => 'Wrong operation';
}

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown error';
}

class NoUserFailure extends Failure {
  @override
  String get message => 'No user';
}
