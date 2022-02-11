import 'package:flutter/cupertino.dart';

@immutable
abstract class Failure {
  String get message;
}

class NoInternetFailure extends Failure {
  @override
  String get message => 'Нет интернета';
}

class ServerFailure extends Failure {
  @override
  String get message => 'Ошибка сервера';
}

class WrongCredentialsFailure extends Failure {
  @override
  String get message => 'Неправильные данные пользователя';
}

class NoSuchBobbinException extends Failure {
  @override
  String get message => 'Отсканированной катушки не существует';
}

class ActionAlreadyExistFailure extends Failure {
  @override
  String get message => 'Данная опреация уже совершена над катушкой';
}

class UnknownFailure extends Failure {
  @override
  String get message => 'Неизвестная ошибка';
}

class CacheFailure extends Failure {
  @override
  String get message => 'Ошибка сохранения на устройство';
}