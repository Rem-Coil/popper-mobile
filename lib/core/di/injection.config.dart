// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i4;
import '../../data/cache/actions_cache.dart' as _i3;
import '../../data/repository/actions_repository.dart' as _i8;
import '../../data/repository/auth_repository.dart' as _i5;
import '../../data/repository/bobbins_repository.dart' as _i6;
import '../../models/action/action.dart' as _i13;
import '../../screen/auth/bloc/auth_bloc.dart' as _i9;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i10;
import '../../screen/login/bloc/login_bloc.dart' as _i11;
import '../../screen/scanned_info/bloc/bloc.dart' as _i12;
import '../../screen/splash/bloc/splash_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ActionsCache>(_i3.ActionsCache());
  gh.singleton<_i4.ApiProvider>(_i4.ApiProvider());
  gh.singleton<_i5.AuthRepository>(_i5.AuthRepository(get<_i4.ApiProvider>()));
  gh.singleton<_i6.BobbinsRepository>(
      _i6.BobbinsRepository(get<_i4.ApiProvider>()));
  gh.singleton<_i7.SplashBloc>(_i7.SplashBloc());
  gh.singleton<_i8.ActionsRepository>(
      _i8.ActionsRepository(get<_i3.ActionsCache>(), get<_i4.ApiProvider>()));
  gh.singleton<_i9.AuthBloc>(_i9.AuthBloc(get<_i5.AuthRepository>()));
  gh.factory<_i10.BobbinLoadingBloc>(
      () => _i10.BobbinLoadingBloc(get<_i6.BobbinsRepository>()));
  gh.singleton<_i11.LoginBloc>(
      _i11.LoginBloc(get<_i5.AuthRepository>(), get<_i9.AuthBloc>()));
  gh.factoryParam<_i12.SaveActionBloc, _i13.Action?, dynamic>(
      (action, _) => _i12.SaveActionBloc(action, get<_i8.ActionsRepository>()));
  return get;
}
