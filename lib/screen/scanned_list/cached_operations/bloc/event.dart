part of 'bloc.dart';

@immutable
class CachedOperationsEvent {}

class LoadOperations extends CachedOperationsEvent {
  LoadOperations();
}
