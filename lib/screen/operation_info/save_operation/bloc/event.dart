part of 'bloc.dart';

@immutable
abstract class OperationSaveEvent {}

class _Initialize implements OperationSaveEvent {
  const _Initialize();
}

class ChangeOperation implements OperationSaveEvent {
  const ChangeOperation(this.operationType);

  final OperationType? operationType;
}

class ChangeComment implements OperationSaveEvent {
  const ChangeComment(this.comment);

  final String? comment;
}

class SaveOperation implements OperationSaveEvent {
  const SaveOperation();
}

class CacheOperation implements OperationSaveEvent {
  const CacheOperation();
}
