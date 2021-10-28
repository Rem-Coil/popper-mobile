import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/actions_repository.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/auth/user.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';

@singleton
class QrScannerBloc extends Bloc<QrCodeEvent, QrScannerState> {
  final user = User.testUser;
  final ActionsRepository _actionsRepository;
  final AuthRepository _authRepository;

  QrScannerBloc(this._actionsRepository, this._authRepository)
      : super(QrScannerState.initial()) {
    on<OnCodeEntered>((event, emit) => emit(state.addCode(event.code)));
    on<OnActionEntered>((event, emit) => emit(state.addAction(event.action)));
    on<OnSaveButtonClicked>(onSaveClicked);
  }

  Future<void> onSaveClicked(
    OnSaveButtonClicked event,
    Emitter<QrScannerState> emit,
  ) async {
    final result = await _generateAction(state.code!, state.action!)
        .then((action) async => await _actionsRepository.saveAction(action));

    emit(result.fold(
      (failure) => QrScannerState.error(failure),
      (_) => QrScannerState.initial(),
    ));
  }

  Future<Action> _generateAction(String code, ActionType actionType) async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) throw Exception();

    return Action.fromQr(
      userId: user.id,
      bobbinId: int.parse(code),
      type: actionType,
    );
  }
}
