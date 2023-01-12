part of 'bloc.dart';

@immutable
abstract class DefectingEvent {}

class StartDefectingEvent implements DefectingEvent {
  const StartDefectingEvent(this.id);

  final int id;
}
