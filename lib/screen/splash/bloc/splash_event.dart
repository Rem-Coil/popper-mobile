part of 'splash_bloc.dart';

@immutable
class SplashEvent {}

class Initialize extends SplashEvent {
  final User? user;

  Initialize(this.user);
}
