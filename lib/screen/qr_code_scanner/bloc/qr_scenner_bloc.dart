import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrCodeEvent, QrScannerState> {
  QrScannerBloc() : super(QrCodeNotEntered()) {
    on<OnCodeEntered>((event, emit) => emit(QrCodeEntered(event.code)));
  }
}