part of 'bloc.dart';

@immutable
abstract class OperationSyncEvent {
  const OperationSyncEvent();
}

class StartOperationsSynchronization extends NextOperation {
  const StartOperationsSynchronization() : super(-1);
}

class NextOperation extends OperationSyncEvent {
  final int operationIndex;

  const NextOperation(int currentOperation)
      : operationIndex = currentOperation + 1;
}
