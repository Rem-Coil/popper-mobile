part of 'bloc.dart';

@immutable
abstract class PagesControllerEvent {}

class ChangeScreenEvent implements PagesControllerEvent {
  final int index;

  const ChangeScreenEvent(this.index);
}
