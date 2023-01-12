import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/repository/bobbins_repository.dart';

part 'event.dart';

part 'state.dart';

@injectable
class DefectingBloc extends Bloc<DefectingEvent, DefectingState> {
  DefectingBloc(this._repository) : super(const DefectingInitialState()) {
    on<StartDefectingEvent>(_onStartDefecting);
  }

  final BobbinsRepository _repository;

  Future<void> _onStartDefecting(
    StartDefectingEvent event,
    Emitter emit,
  ) async {
    emit(const DefectingStartState());
    final result = await _repository.defectBobbin(event.id);
    emit(result.fold(
      (f) => DefectingFailedState(f),
      (_) => const DefectingEndState(),
    ));
  }
}
