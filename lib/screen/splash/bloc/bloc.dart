import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';

part 'event.dart';
part 'state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository _authRepository;

  SplashBloc(this._authRepository) : super(InitialState()) {
    on<Initialize>(initial);
  }

  Future<void> initial(
    Initialize event,
    Emitter<SplashState> emit,
  ) async {
    final user = await _authRepository.getCurrentUserOrNull();
    if (user == null) {
      emit(NavigateToLogin());
    } else {
      emit(NavigateToHome());
    }
  }
}
