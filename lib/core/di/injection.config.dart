// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/actions_repository.dart' as _i8;
import '../../data/auth_repository.dart' as _i3;
import '../../data/bobbins_repository.dart' as _i4;
import '../../data/local_repositories/local_actions_repository.dart' as _i5;
import '../../screen/actions/bloc/actions_bloc.dart' as _i10;
import '../../screen/login/bloc/login_bloc.dart' as _i6;
import '../../screen/qr_code_scanner/bloc/qr_scanner_bloc.dart' as _i9;
import '../../screen/splash/bloc/splash_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AuthRepository>(_i3.AuthRepository());
  gh.singleton<_i4.BobbinsRepository>(_i4.BobbinsRepository());
  gh.singleton<_i5.LocalActionsRepository>(_i5.LocalActionsRepository());
  gh.singleton<_i6.LoginBloc>(_i6.LoginBloc(get<_i3.AuthRepository>()));
  gh.singleton<_i7.SplashBloc>(_i7.SplashBloc(get<_i3.AuthRepository>()));
  gh.singleton<_i8.ActionsRepository>(
      _i8.ActionsRepository(get<_i5.LocalActionsRepository>()));
  gh.singleton<_i9.QrScannerBloc>(_i9.QrScannerBloc(
      get<_i8.ActionsRepository>(),
      get<_i3.AuthRepository>(),
      get<_i4.BobbinsRepository>()));
  gh.singleton<_i10.ActionsBloc>(
      _i10.ActionsBloc(get<_i8.ActionsRepository>()));
  return get;
}
