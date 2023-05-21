import 'package:flutter/foundation.dart';

@immutable
abstract class Failure {
  const Failure([this.exception]);

  final Exception? exception;

  String get message;

  @override
  String toString() {
    return kDebugMode && exception != null ? '$message: $exception' : message;
  }
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.exception]);

  @override
  String get message => 'Неизвестная ошибка';
}

class NoInternetFailure extends Failure {
  const NoInternetFailure([super.exception]);

  @override
  String get message => 'Нет интернета';
}

class ServerFailure extends Failure {
  const ServerFailure([super.exception]);

  @override
  String get message => 'Ошибка сервера';
}

class WrongCredentialsFailure extends Failure {
  const WrongCredentialsFailure([super.exception]);

  @override
  String get message => 'Неправильные данные пользователя';
}

class UserNotLoginFailure extends Failure {
  const UserNotLoginFailure([super.exception]);

  @override
  String get message => 'Пользователь не вошел в приложение';
}

class NoSuchUserFailure extends Failure {
  const NoSuchUserFailure([super.exception]);

  @override
  String get message => 'Нет пользователя с таким номером телефона';
}

class ProductNotExistOrNotActiveFailure extends Failure {
  const ProductNotExistOrNotActiveFailure([super.exception]);

  @override
  String get message =>
      'Операция не может быть сохранена, так как объект не существует или не активен';
}

class OperationAlreadyExistFailure extends Failure {
  const OperationAlreadyExistFailure([super.exception]);

  @override
  String get message => 'Операция уже сохранена';
}

class BobbinNotContainOperationsFailure extends Failure {
  const BobbinNotContainOperationsFailure([super.exception]);

  @override
  String get message => 'По данной катушке ещё не выполнено операций';
}

class CacheFailure extends Failure {
  const CacheFailure([super.exception]);

  @override
  String get message => 'Ошибка кеша';
}

extension NetworkFailureExtension on Failure {
  bool get isNetworkFailure =>
      this is NoInternetFailure || this is ServerFailure;
}
