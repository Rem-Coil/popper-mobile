import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';

part 'event.dart';

part 'state.dart';

@injectable
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final AuthRepository _authRepository;

  CurrentUserBloc(this._authRepository) : super(const UnknownUserState()) {
    on<LoadUserEvent>(onLoadUser);
    on<LogOutEvent>(onLogOut);
  }

  Future<void> onLoadUser(
    LoadUserEvent event,
    Emitter<CurrentUserState> emit,
  ) async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      emit(const UserNotSetState());
    } else {
      emit(WithUserState(user));
    }
  }

  Future<void> onLogOut(
    LogOutEvent event,
    Emitter<CurrentUserState> emit,
  ) async {
    await _authRepository.logOut();
    emit(const UserNotSetState());
  }
}
