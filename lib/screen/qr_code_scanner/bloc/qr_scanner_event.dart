import 'package:flutter/foundation.dart';

@immutable
class QrCodeEvent {}

class OnCodeEntered extends QrCodeEvent {
  OnCodeEntered(this.code);

  final String code;
}