part of 'bloc.dart';

@immutable
abstract class OperationsState {
  int get todayTotal;
}

class LoadingOperationsState implements OperationsState {
  const LoadingOperationsState();

  @override
  int get todayTotal => 0;
}

class OperationsLoadedState implements OperationsState {
  const OperationsLoadedState(this.operations);

  final List<Operation> operations;

  @override
  int get todayTotal => operations.where((o) => o.time.isToday).length;
}
