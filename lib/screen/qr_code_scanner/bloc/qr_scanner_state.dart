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

  QrScannerState error(Failure failure) {
    return QrScannerState._(null, action, failure);
  }

  QrScannerState addAction(ActionType action) {
    return QrScannerState._(code, action, null);
  }

  QrScannerState addCode(String code) {
    return QrScannerState._(code, action, null);
  }

  QrScannerState codeSaved() {
    return QrScannerState._(null, action, null);
  }

  bool get isReady => code != null && action != null;
}