import 'package:flutter/foundation.dart';
import 'package:popper_mobile/models/action/action.dart';

@immutable
class QrScannerState {
  final String? code;
  final ActionType? action;

  QrScannerState._(this.code, this.action);

  factory QrScannerState.initial() {
    return QrScannerState._(null, null);
  }

  QrScannerState addAction(ActionType action) {
    return QrScannerState._(code, action);
  }

  QrScannerState addCode(String code) {
    return QrScannerState._(code, action);
  }

  bool get isReady => code != null && action != null;
}