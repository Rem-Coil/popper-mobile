import 'package:flutter/foundation.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/qr_code/bobbin.dart';

@immutable
class QrScannerState {
  // todo - какая то путаница с статусами
  final Status status;
  final Bobbin? bobbin;
  final ActionType? action;
  final Failure? errorMessage;

  QrScannerState._(this.status, this.bobbin, this.action, this.errorMessage);

  factory QrScannerState.initial() {
    return QrScannerState._(Status.INITIAL, null, null, null);
  }

  QrScannerState load() {
    return QrScannerState._(Status.LOAD, bobbin, action, errorMessage);
  }

  QrScannerState error(Failure failure) {
    return QrScannerState._(Status.ERROR, bobbin, action, failure);
  }

  QrScannerState setAction(ActionType action) {
    return QrScannerState._(Status.CORRECT, bobbin, action, errorMessage);
  }

  QrScannerState setBobbin(Bobbin bobbin) {
    return QrScannerState._(Status.CORRECT, bobbin, action, null);
  }

  QrScannerState onNeedCacheError(int bobbinId, Failure failure) {
    return QrScannerState._(
      Status.ERROR,
      Bobbin.defaultValue(bobbinId),
      action,
      failure,
    );
  }

  QrScannerState clearBobbin() {
    return QrScannerState._(Status.CORRECT, null, action, null);
  }

  bool get hasError => errorMessage != null;

  bool get isReady =>
      status == Status.CORRECT && bobbin != null && action != null;

  bool get isLoad => status == Status.LOAD;
}

enum Status { INITIAL, LOAD, ERROR, CORRECT }
