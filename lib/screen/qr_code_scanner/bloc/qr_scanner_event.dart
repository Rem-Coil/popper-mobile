import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/auth/user.dart';

@immutable
class QrCodeEvent {}

class OnCodeEntered extends QrCodeEvent {
  final String code;

  OnCodeEntered(this.code);
}

class OnActionEntered extends QrCodeEvent {
  final ActionType action;

  OnActionEntered(this.action);
}

class OnSaveButtonClicked extends QrCodeEvent {
  // todo - пользователь должен передаваться при старате экрана или браться из кеша
  final User user;

  OnSaveButtonClicked(this.user);
}
