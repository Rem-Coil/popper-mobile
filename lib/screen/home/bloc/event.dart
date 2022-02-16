part of 'bloc.dart';

@immutable
abstract class HomeEvent {}

class Initial extends HomeEvent {}

class ChangeSavedCount extends HomeEvent {
  final int count;

  ChangeSavedCount(this.count);
}

class ChangeCachedCount extends HomeEvent {
  final int count;

  ChangeCachedCount(this.count);
}
