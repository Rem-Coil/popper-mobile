import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/models/auth/user.dart';

part 'splash_event.dart';
part 'splash_state.dart';

@injectable
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
