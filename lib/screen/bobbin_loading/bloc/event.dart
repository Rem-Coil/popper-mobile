part of 'bloc.dart';

@immutable
abstract class BobbinLoadingEvent {
  const BobbinLoadingEvent();
}

class LoadInfo extends BobbinLoadingEvent {
  final ScannedEntity bobbin;

  const LoadInfo(this.bobbin);
}