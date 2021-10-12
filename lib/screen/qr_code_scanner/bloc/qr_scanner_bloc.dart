import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrCodeEvent, QrScannerState> {
  QrScannerBloc() : super(QrScannerState.initial()) {
    on<OnCodeEntered>((event, emit) => emit(state.addCode(event.code)));
    on<OnActionEntered>((event, emit) => emit(state.addAction(event.action)));
    on<OnSaveButtonClicked>(onSaveClicked);
  }

  void onSaveClicked(
    OnSaveButtonClicked event,
    Emitter<QrScannerState> emit,
  ) {
    // todo - отправить запрос на сервер
    emit(QrScannerState.initial());
  }
}
