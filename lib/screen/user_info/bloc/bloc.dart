import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/domain/repository/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';

part 'event.dart';

part 'state.dart';

@injectable
class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final AuthRepository _authRepository;

  UserInfoBloc(this._authRepository) : super(UserInfoLoadingState()) {
    on<LoadUserEvent>(onLoadUser);
    on<LogOutEvent>(onLogOut);
  }

  Future<void> onLoadUser(
    LoadUserEvent event,
    Emitter<UserInfoState> emit,
  ) async {
    final user = await _authRepository.getCurrentUser();
    emit(UserInfoSuccessState(user!));
  }

  Future<void> onLogOut(LogOutEvent event, Emitter<UserInfoState> emit) async {
    await _authRepository.logOut();
    emit(LogOutState(state as UserInfoSuccessState));
  }
}
