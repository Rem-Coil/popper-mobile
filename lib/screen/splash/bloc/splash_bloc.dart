import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_event.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_state.dart';

@singleton
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState()) {
    on<Initialize>(initial);
  }

  Future<void> initial(
    Initialize event,
    Emitter<SplashState> emit,
  ) async {
    if (event.user == null) {
      emit(NavigateToLogin());
    } else {
      emit(NavigateToHome());
    }
  }
}
