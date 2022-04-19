part of 'bloc.dart';

@immutable
class HomeState {
  final int countSavedActions;
  final int countCachedActions;

  const HomeState._({
    required this.countSavedActions,
    required this.countCachedActions,
  });

  factory HomeState.setup(int savedCount, int cachedCount) => HomeState._(
      countSavedActions: savedCount, countCachedActions: cachedCount);

  HomeState changeSaved(int saved) {
    return HomeState._(
      countSavedActions: saved,
      countCachedActions: countCachedActions,
    );
  }

  HomeState changeCached(int cached) {
    return HomeState._(
      countSavedActions: countSavedActions,
      countCachedActions: cached,
    );
  }
}
