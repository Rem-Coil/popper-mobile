import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_event.dart';
import 'package:popper_mobile/screen/splash/bloc/splash_state.dart';

@singleton
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;

  SplashBloc(this._authRepository) : super(InitialState()) {
    on<Initialize>(initial);
  }

  Future<void> initial(
    Initialize event,
    Emitter<SplashState> emit,
  ) async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      emit(NavigateToLogin());
    } else {
      emit(NavigateToScanner());
    }
  }
}
