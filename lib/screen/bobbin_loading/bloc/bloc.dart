import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';

part 'event.dart';

part 'state.dart';

@injectable
class BobbinLoadingBloc extends Bloc<BobbinLoadingEvent, BobbinState> {
  final BobbinsRepository _bobbinsRepository;
  final AuthRepository _authRepository;

  BobbinLoadingBloc(this._bobbinsRepository, this._authRepository)
      : super(BobbinLoadingState()) {
    on<LoadInfo>(onLoadInfo);
  }

  Future<void> onLoadInfo(LoadInfo event, Emitter emit) async {
    emit(BobbinLoadingState());
    final result = await _bobbinsRepository.getBobbinInfo(event.bobbin.id);
    final bobbin = result.fold(
      (f) => Bobbin.unknown(event.bobbin.id),
      (b) => b,
    );

    final user = await _authRepository.getCurrentUser();
    final operation = Operation.create(
      userId: user!.id,
      bobbin: bobbin,
      time: DateTime.now(),
    );

    emit(BobbinSuccessState(operation));
  }
}
