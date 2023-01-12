part of 'bloc.dart';

abstract class HistoryState {
  const HistoryState();
}

class LoadHistoryState extends HistoryState {
  const LoadHistoryState();
}

class SuccessHistoryState extends HistoryState {
  const SuccessHistoryState(this.history);

  final BobbinHistory history;
}

class FailureHistoryState extends HistoryState {
  final Failure failure;

  const FailureHistoryState(this.failure);
}
