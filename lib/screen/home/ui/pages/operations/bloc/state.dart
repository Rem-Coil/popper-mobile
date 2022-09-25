part of 'bloc.dart';

@immutable
class OperationsState {
  const OperationsState.initial() : operations = const [];

  const OperationsState.update(this.operations);

  final List<Operation> operations;

  int get todayTotal => operations.where((o) => o.time.isToday).length;
}
