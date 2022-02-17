import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

part 'event.dart';
part 'state.dart';

@injectable
class BobbinLoadingBloc extends Bloc<BobbinLoadingEvent, BobbinLoadingState> {
  final BobbinsRepository _bobbinsRepository;

  BobbinLoadingBloc(this._bobbinsRepository)
      : super(BobbinLoadingState.initial()) {
    on<LoadInfo>(onLoadInfo);
  }

  Future<void> onLoadInfo(LoadInfo event, Emitter emit) async {
    emit(state.setLoad());
    final result = await _bobbinsRepository.getBobbinInfo(event.bobbin.id);
    emit(result.fold(
      (f) => state.setFailure(f),
      (b) => state.setSuccess(b),
    ));
  }
}
