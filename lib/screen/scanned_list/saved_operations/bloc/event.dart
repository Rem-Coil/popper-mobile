part of 'bloc.dart';

@immutable
class SavedOperationsEvent {}

class LoadOperations extends SavedOperationsEvent {
  LoadOperations();
}
