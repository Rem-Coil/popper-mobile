import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/data/auth_repository.dart';
import 'package:popper_mobile/models/auth/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _repository;

  AuthBloc(this._repository) : super(AuthState.initial()) {
    on<ChangeUser>(onChangeUser);
    on<LoadSavedUser>(onLoadSavedUser);
    add(LoadSavedUser());
  }

  void onChangeUser(ChangeUser event, Emitter emit) {
    emit(state.setUser(event.user));
  }

  Future<void> onLoadSavedUser(LoadSavedUser event, Emitter emit) async {
    emit(state.loading());
    final user = await _repository.getCurrentUser();
    add(ChangeUser(user));
  }
}