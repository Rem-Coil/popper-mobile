import 'package:flutter/foundation.dart';

@immutable
abstract class Failure {
  const Failure([this.exception]);

  final Exception? exception;

  String get message;

  @override
  String toString() {
    return kDebugMode ? '$message: $exception' : message;
  }
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

class ItemNotExistOrNotActiveFailure extends Failure {
  const ItemNotExistOrNotActiveFailure([super.exception]);

  @override
  String get message =>
      'Операция не может быть сохранена, так как обект не существует или не активен';
}

class BobbinNotContainOperationsFailure extends Failure {
  const BobbinNotContainOperationsFailure([super.exception]);

  @override
  String get message => 'По данной катушке ещё не выполнено операций';
}

class BatchNotContainOperationsFailure extends Failure {
  const BatchNotContainOperationsFailure([super.exception]);

  @override
  String get message =>
      'По катушкам из выбранной партии ещё не выполнено операций';
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.exception]);

  @override
  String get message => 'Неизвестная ошибка';
}

class CacheFailure extends Failure {
  const CacheFailure([super.exception]);

  @override
  String get message => 'Ошибка кеша';
}

extension Test on Failure {
  bool get isNetworkFailure =>
      this is NoInternetFailure || this is ServerFailure;
}
