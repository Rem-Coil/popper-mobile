part of 'bloc.dart';

class HistoryEvent {}

class GetHistory implements HistoryEvent {
  const GetHistory(this.bobbin);

  final ScannedEntity bobbin;
}
