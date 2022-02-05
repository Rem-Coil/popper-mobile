// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/actions_repository.dart' as _i3;
import '../../data/auth_repository.dart' as _i4;
import '../../data/bobbins_repository.dart' as _i5;
import '../../models/bobbin/bobbin.dart' as _i7;
import '../../screen/auth/bloc/auth_bloc.dart' as _i9;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i10;
import '../../screen/login/bloc/login_bloc.dart' as _i11;
import '../../screen/scanned_info/bloc/bloc.dart' as _i6;
import '../../screen/splash/bloc/splash_bloc.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ActionsRepository>(_i3.ActionsRepository());
  gh.singleton<_i4.AuthRepository>(_i4.AuthRepository());
  gh.singleton<_i5.BobbinsRepository>(_i5.BobbinsRepository());
  gh.factoryParam<_i6.SaveActionBloc, _i7.Bobbin?, dynamic>(
      (bobbin, _) => _i6.SaveActionBloc(bobbin, get<_i3.ActionsRepository>()));
  gh.singleton<_i8.SplashBloc>(_i8.SplashBloc());
  gh.singleton<_i9.AuthBloc>(_i9.AuthBloc(get<_i4.AuthRepository>()));
  gh.factory<_i10.BobbinLoadingBloc>(
      () => _i10.BobbinLoadingBloc(get<_i5.BobbinsRepository>()));
  gh.singleton<_i11.LoginBloc>(
      _i11.LoginBloc(get<_i4.AuthRepository>(), get<_i9.AuthBloc>()));
  return get;
}
