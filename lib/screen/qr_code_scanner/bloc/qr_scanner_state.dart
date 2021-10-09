import 'package:flutter/foundation.dart';

@immutable
class QrScannerState {}

class QrCodeNotEntered extends QrScannerState {}

class QrCodeEntered extends QrScannerState {
  QrCodeEntered(this.code);

  final String code;
}