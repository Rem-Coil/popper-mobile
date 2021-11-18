import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/action/action_type.dart';

@immutable
class QrCodeEvent {}

class OnCodeEntered extends QrCodeEvent {
  final String code;

  OnCodeEntered(this.code);

  int get bobbinId => int.parse(code);
}

class OnActionEntered extends QrCodeEvent {
  final ActionType action;

  OnActionEntered(this.action);
}

class OnSaveButtonClicked extends QrCodeEvent {}

class OnBottomSheetClose extends QrCodeEvent {}
