part of 'bloc.dart';

abstract class HistoryState {
  const HistoryState();
}

class LoadHistoryState extends HistoryState {
  const LoadHistoryState();
}

class SuccessHistoryState extends HistoryState {
  final List<OperationHistoryItem> items;

  const SuccessHistoryState(this.items);

  SuccessHistoryState changeExtendedState(int index) {
    final changedItems = List<OperationHistoryItem>.from(items);
    changedItems[index].isExpanded = !changedItems[index].isExpanded;
    return SuccessHistoryState(changedItems);
  }
}

class FailureHistoryState extends HistoryState {
  final Failure failure;

  const FailureHistoryState(this.failure);
}
