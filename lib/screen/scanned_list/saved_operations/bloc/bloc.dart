import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/error/failure.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';
import 'package:popper_mobile/models/operation/operation.dart';

part 'event.dart';

part 'state.dart';

@injectable
class SavedOperationsBloc
    extends Bloc<SavedOperationsEvent, SavedOperationsState> {
  final OperationsCache _operationsCache;

  SavedOperationsBloc(this._operationsCache) : super(LoadingState()) {
    on<LoadOperations>(onLoadActions);
  }

  Future<void> onLoadActions(LoadOperations event, Emitter emit) async {
    emit(LoadingState());
    try {
      final operations = await _operationsCache.getSavedOperation();

      operations.sort((a, b) => a.time.compareTo(b.time));
      final sortedOperations = operations.reversed.toList();

      emit(OperationsLoaded(sortedOperations));
    } catch (e) {
      emit(ErrorState(CacheFailure()));
    }
  }
}
