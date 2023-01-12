import 'package:flutter/cupertino.dart';

@immutable
abstract class Failure {
  String get message;
}

class NoInternetFailure implements Failure {
  const NoInternetFailure();

  @override
  String get message => 'Нет интернета';
}

class ServerFailure implements Failure {
  const ServerFailure();

  @override
  String get message => 'Ошибка сервера';
}

class WrongCredentialsFailure implements Failure {
  const WrongCredentialsFailure();

  @override
  String get message => 'Неправильные данные пользователя';
}

class ItemNotExistOrNotActiveFailure implements Failure {
  const ItemNotExistOrNotActiveFailure();

  @override
  String get message =>
      'Операция не может быть сохранена, так как обект не существует или не активен';
}

class BobbinNotContainOperationsFailure implements Failure {
  const BobbinNotContainOperationsFailure();

  @override
  String get message => 'По данной катушке ещё не выполнено операций';
}

class BatchNotContainOperationsFailure implements Failure {
  const BatchNotContainOperationsFailure();

  @override
  String get message =>
      'По катушкам из выбранной партии ещё не выполнено операций';
}

class UnknownFailure implements Failure {
  const UnknownFailure();

  @override
  String get message => 'Неизвестная ошибка';
}

class CacheFailure implements Failure {
  const CacheFailure();

  @override
  String get message => 'Ошибка кеша';
}

extension Test on Failure {
  bool get isNetworkFailure =>
      this is NoInternetFailure || this is ServerFailure;
}
