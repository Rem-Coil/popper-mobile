import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/actions_repository.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/data/bobbins_repository.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_event.dart';
import 'package:popper_mobile/screen/qr_code_scanner/bloc/qr_scanner_state.dart';

@singleton
class QrScannerBloc extends Bloc<QrCodeEvent, QrScannerState> {
  final BobbinsRepository _bobbinsRepository;
  final ActionsRepository _actionsRepository;
  final AuthRepository _authRepository;

  QrScannerBloc(
      this._actionsRepository, this._authRepository, this._bobbinsRepository)
      : super(QrScannerState.initial()) {
    on<OnCodeEntered>(onCodeEntered);
    on<OnActionEntered>((event, emit) => emit(state.setAction(event.action)));
    on<OnBottomSheetClose>((_, emit) => emit(state.clearBobbin()));
    on<OnSaveButtonClicked>(onSaveClicked);
    on<OnSaveToCacheButtonClicked>(onSaveToCacheButtonClicked);
  }

  Future<void> onCodeEntered(
    OnCodeEntered event,
    Emitter<QrScannerState> emit,
  ) async {
    emit(state.load());
    final bobbin = await _bobbinsRepository.getBobbinInfo(event.bobbinId);
    emit(bobbin.fold(
      (f) => state.onNeedCacheError(event.bobbinId, f),
      (b) => state.setBobbin(b),
    ));
  }

  Future<void> onSaveClicked(
    OnSaveButtonClicked event,
    Emitter<QrScannerState> emit,
  ) async {
    final result = await _generateAction(state.bobbin!.id, state.action!)
        .then((action) async => await _actionsRepository.saveAction(action));

    emit(result.fold(
      (failure) => state.error(failure),
      (_) => state.clearBobbin(),
    ));
  }

  Future<Action> _generateAction(int bobbinId, ActionType actionType) async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) throw Exception();

    return Action.fromQr(
      userId: user.id,
      bobbinId: bobbinId,
      type: actionType,
    );
  }

  Future<void> onSaveToCacheButtonClicked(
    OnSaveToCacheButtonClicked event,
    Emitter<QrScannerState> emit,
  ) async {
    _generateAction(state.bobbin!.id, state.action!)
        .then((action) async => await _actionsRepository.saveToCache(action));
    emit(state.clearBobbin());
  }
}
