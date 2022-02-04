import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/data/bobbins_repository.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';

part 'state.dart';

part 'event.dart';

@injectable
class BobbinLoadingBloc extends Bloc<BobbinLoadingEvent, BobbinLoadingState> {
  final BobbinsRepository _bobbinsRepository;

  BobbinLoadingBloc(this._bobbinsRepository)
      : super(BobbinLoadingState.initial()) {
    on<LoadInfo>(onLoadInfo);
  }

  Future<void> onLoadInfo(LoadInfo event, Emitter emit) async {
    emit(BobbinLoadingState.load());
    final result = await _bobbinsRepository.getBobbinInfo(event.bobbin.id);
    result.fold(
      (f) => emit(BobbinLoadingState.failure(f)),
      (b) => emit(BobbinLoadingState.success(b)),
    );
  }
}
