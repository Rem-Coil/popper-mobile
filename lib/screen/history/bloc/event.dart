part of 'bloc.dart';

class HistoryEvent {}

class GetHistory extends HistoryEvent {
  final Bobbin bobbin;

  GetHistory(this.bobbin);
}

class ShowHistory extends HistoryEvent {
  final int index;

  ShowHistory(this.index);
}
