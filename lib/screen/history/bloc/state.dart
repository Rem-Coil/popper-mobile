part of 'bloc.dart';

abstract class HistoryState {
  const HistoryState();
}

class LoadHistoryState extends HistoryState {
  const LoadHistoryState();
}

class SuccessHistoryState extends HistoryState {
  final List<PanelItem> items;

  const SuccessHistoryState(this.items);

  SuccessHistoryState changeExpandedState(int index) {
    final changedItems = List<PanelItem>.from(items);
    changedItems[index].expand();
    return SuccessHistoryState(changedItems);
  }
}

class FailureHistoryState extends HistoryState {
  final Failure failure;

  const FailureHistoryState(this.failure);
}
