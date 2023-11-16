part of 'bloc.dart';

@immutable
abstract class OperationSaveEvent {}

class _Initialize implements OperationSaveEvent {
  const _Initialize();
}

class ChooseOperationEvent implements OperationSaveEvent {
  const ChooseOperationEvent(this.operationType);

  final OperationType? operationType;
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
