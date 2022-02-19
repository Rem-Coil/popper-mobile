import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/cache/operations_cache.dart';

part 'event.dart';
part 'state.dart';

@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OperationsCache _operationsCache;

  HomeBloc(this._operationsCache) : super(HomeState.setup(0, 0)) {
    on<Initial>(onInitial);
    on<ChangeSavedCount>((event, emit) => emit(state.changeSaved(event.count)));
    on<ChangeCachedCount>(
      (event, emit) => emit(state.changeCached(event.count)),
    );
  }

  Future<void> onInitial(Initial event, Emitter emit) async {
    await _operationsCache
        .subscribeToSavedOperations((c) => add(ChangeSavedCount(c.length)));

    await _operationsCache
        .subscribeToCachedOperations((c) => add(ChangeCachedCount(c.length)));

    final operations = await Future.wait([
      _operationsCache.getSavedOperation(),
      _operationsCache.getCachedOperation(),
    ]);

    emit(HomeState.setup(
      operations[0].length,
      operations[1].length,
    ));
  }
}
