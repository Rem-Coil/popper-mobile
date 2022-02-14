part of 'bloc.dart';

@immutable
abstract class SaveActionEvent {}

class Initialize extends SaveActionEvent {}

class OnActionChanged extends SaveActionEvent {
  final ActionType? action;

  OnActionChanged(this.action);
}

class OnSaveAction extends SaveActionEvent {}

class OnSaveInCache extends SaveActionEvent {}
