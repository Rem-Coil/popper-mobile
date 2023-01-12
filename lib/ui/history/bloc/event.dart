part of 'bloc.dart';

class HistoryEvent {}

class GetHistory extends HistoryEvent {
  final Bobbin bobbin;

  GetHistory(this.bobbin);
}
