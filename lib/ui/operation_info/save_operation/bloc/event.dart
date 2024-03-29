part of 'bloc.dart';

@immutable
abstract class OperationSaveEvent {}

class _Initialize implements OperationSaveEvent {
  const _Initialize();
}

class ModifyOperationEvent implements OperationSaveEvent {
  const ModifyOperationEvent(this.event);

  final ModifyEvent event;
}

class SaveOperation implements OperationSaveEvent {
  const SaveOperation();
}

class CacheOperation implements OperationSaveEvent {
  const CacheOperation();
}
