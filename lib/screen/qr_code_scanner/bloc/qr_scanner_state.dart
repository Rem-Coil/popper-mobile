import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/action/action_type.dart';

@immutable
class QrScannerState {
  final String? code;
  final ActionType? action;
  final Failure? errorMessage;

  QrScannerState._(this.code, this.action, this.errorMessage);

  factory QrScannerState.initial() {
    return QrScannerState._(null, null, null);
  }

  factory QrScannerState.error(Failure failure) {
    return QrScannerState._(null, null, failure);
  }

  QrScannerState addAction(ActionType action) {
    return QrScannerState._(code, action, null);
  }

  QrScannerState addCode(String code) {
    return QrScannerState._(code, action, null);
  }

  bool get isReady => code != null && action != null;
}