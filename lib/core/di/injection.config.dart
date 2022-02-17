// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i3;
import '../../data/cache/operations_cache_impl.dart' as _i9;
import '../../data/repository/auth_repository_impl.dart' as _i5;
import '../../data/repository/bobbins_repository_impl.dart' as _i7;
import '../../data/repository/operations_repository_impl.dart' as _i11;
import '../../domain/cache/operations_cache.dart' as _i8;
import '../../domain/repository/auth_repository.dart' as _i4;
import '../../domain/repository/bobbins_repository.dart' as _i6;
import '../../domain/repository/operations_repository.dart' as _i10;
import '../../models/operation/operation.dart' as _i20;
import '../../screen/auth/bloc/auth_bloc.dart' as _i14;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i15;
import '../../screen/home/bloc/bloc.dart' as _i17;
import '../../screen/login/bloc/login_bloc.dart' as _i18;
import '../../screen/operation_info/save_operation/bloc/bloc.dart' as _i19;
import '../../screen/operation_info/update_operation/bloc/bloc.dart' as _i21;
import '../../screen/scanned_list/cached_operations/bloc/bloc.dart' as _i16;
import '../../screen/scanned_list/saved_operations/bloc/bloc.dart' as _i12;
import '../../screen/splash/bloc/splash_bloc.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiProvider>(_i3.ApiProvider());
  gh.singleton<_i4.AuthRepository>(
      _i5.AuthRepositoryImpl(get<_i3.ApiProvider>()));
  gh.singleton<_i6.BobbinsRepository>(
      _i7.BobbinsRepositoryImpl(get<_i3.ApiProvider>()));
  gh.singleton<_i8.OperationsCache>(_i9.OperationsCacheImpl(),
      dispose: (i) => i.dispose());
  gh.singleton<_i10.OperationsRepository>(_i11.OperationRepositoryImpl(
      get<_i3.ApiProvider>(), get<_i8.OperationsCache>()));
  gh.factory<_i12.SavedOperationsBloc>(() => _i12.SavedOperationsBloc(
      get<_i8.OperationsCache>(), get<_i10.OperationsRepository>()));
  gh.singleton<_i13.SplashBloc>(_i13.SplashBloc());
  gh.singleton<_i14.AuthBloc>(_i14.AuthBloc(get<_i4.AuthRepository>()));
  gh.factory<_i15.BobbinLoadingBloc>(
      () => _i15.BobbinLoadingBloc(get<_i6.BobbinsRepository>()));
  gh.factory<_i16.CachedOperationsBloc>(
      () => _i16.CachedOperationsBloc(get<_i8.OperationsCache>()));
  gh.singleton<_i17.HomeBloc>(_i17.HomeBloc(get<_i8.OperationsCache>()));
  gh.singleton<_i18.LoginBloc>(
      _i18.LoginBloc(get<_i4.AuthRepository>(), get<_i14.AuthBloc>()));
  gh.factoryParam<_i19.OperationSaveBloc, _i20.Operation?, dynamic>(
      (operation, _) =>
          _i19.OperationSaveBloc(operation, get<_i10.OperationsRepository>()));
  gh.factoryParam<_i21.OperationUpdateBloc, _i20.Operation?, dynamic>(
      (operation, _) => _i21.OperationUpdateBloc(
          operation, get<_i10.OperationsRepository>()));
  return get;
}
