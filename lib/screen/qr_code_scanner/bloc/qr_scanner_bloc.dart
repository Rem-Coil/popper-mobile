import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/data/actions_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrCodeEvent, QrScannerState> {
  final user = User.testUser;
  final _repository = ActionsRepository();

  QrScannerBloc() : super(QrScannerState.initial()) {
    on<OnCodeEntered>((event, emit) => emit(state.addCode(event.code)));
    on<OnActionEntered>((event, emit) => emit(state.addAction(event.action)));
    on<OnSaveButtonClicked>(onSaveClicked);
  }

  Future<void> onSaveClicked(
    OnSaveButtonClicked event,
    Emitter<QrScannerState> emit,
  ) async {
    await _repository.saveAction(state.code!, state.action!);
    emit(QrScannerState.initial());
  }
}
