part of 'bloc.dart';

@immutable
class LoadTypesEvent {
  const LoadTypesEvent(this.specificationId);

  final int specificationId;
}
