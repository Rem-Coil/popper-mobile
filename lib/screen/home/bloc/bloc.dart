import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/operations_cache.dart';

part 'event.dart';
part 'state.dart';

@singleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final OperationsCache _actionsCache;

  HomeBloc(this._actionsCache) : super(HomeState.setup(0, 0)) {
    on<Initial>(onInitial);
    on<ChangeSavedCount>((event, emit) => emit(state.changeSaved(event.count)));
    on<ChangeCachedCount>(
      (event, emit) => emit(state.changeCached(event.count)),
    );
  }

  Future<void> onInitial(Initial event, Emitter emit) async {
    final savedActions = await _actionsCache.savedActionListenable;
    savedActions.addListener(() {
      add(ChangeSavedCount(savedActions.value.length));
    });

    final cachedActions = await _actionsCache.cachedActionListenable;
    cachedActions.addListener(() {
      add(ChangeCachedCount(cachedActions.value.length));
    });

    emit(HomeState.setup(
      savedActions.value.length,
      cachedActions.value.length,
    ));
  }
}
