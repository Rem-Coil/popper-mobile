// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i6;
import '../../data/cache/operations_cache_impl.dart' as _i4;
import '../../data/repository/auth_repository_impl.dart' as _i8;
import '../../data/repository/bobbins_repository_impl.dart' as _i10;
import '../../data/repository/operations_repository_impl.dart' as _i14;
import '../../domain/cache/operations_cache.dart' as _i3;
import '../../domain/repository/auth_repository.dart' as _i7;
import '../../domain/repository/bobbins_repository.dart' as _i9;
import '../../domain/repository/operations_repository.dart' as _i13;
import '../../models/operation/operation.dart' as _i20;
import '../../screen/auth/bloc/auth_bloc.dart' as _i16;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i17;
import '../../screen/home/bloc/bloc.dart' as _i12;
import '../../screen/login/bloc/login_bloc.dart' as _i18;
import '../../screen/operation_info/save_operation/bloc/bloc.dart' as _i19;
import '../../screen/operation_info/update_operation/bloc/bloc.dart' as _i21;
import '../../screen/scanned_list/cached_operations/bloc/bloc.dart' as _i11;
import '../../screen/scanned_list/saved_operations/bloc/bloc.dart' as _i15;
import '../../screen/splash/bloc/splash_bloc.dart' as _i5;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serverAddressModule = _$ServerAddressModule();
  gh.singleton<_i3.OperationsCache>(_i4.OperationsCacheImpl(),
      dispose: (i) => i.dispose());
  gh.singleton<_i5.SplashBloc>(_i5.SplashBloc());
  gh.factory<String>(() => serverAddressModule.baseUrlTest,
      instanceName: 'BaseUrl', registerFor: {_dev});
  gh.factory<String>(() => serverAddressModule.baseUrlProd,
      instanceName: 'BaseUrl', registerFor: {_prod});
  gh.singleton<_i6.ApiProvider>(
      _i6.ApiProvider(get<String>(instanceName: 'BaseUrl')));
  gh.singleton<_i7.AuthRepository>(
      _i8.AuthRepositoryImpl(get<_i6.ApiProvider>()));
  gh.singleton<_i9.BobbinsRepository>(
      _i10.BobbinsRepositoryImpl(get<_i6.ApiProvider>()));
  gh.factory<_i11.CachedOperationsBloc>(
      () => _i11.CachedOperationsBloc(get<_i3.OperationsCache>()));
  gh.singleton<_i12.HomeBloc>(_i12.HomeBloc(get<_i3.OperationsCache>()));
  gh.singleton<_i13.OperationsRepository>(_i14.OperationRepositoryImpl(
      get<_i6.ApiProvider>(), get<_i3.OperationsCache>()));
  gh.factory<_i15.SavedOperationsBloc>(() => _i15.SavedOperationsBloc(
      get<_i3.OperationsCache>(), get<_i13.OperationsRepository>()));
  gh.singleton<_i16.AuthBloc>(_i16.AuthBloc(get<_i7.AuthRepository>()));
  gh.factory<_i17.BobbinLoadingBloc>(
      () => _i17.BobbinLoadingBloc(get<_i9.BobbinsRepository>()));
  gh.singleton<_i18.LoginBloc>(
      _i18.LoginBloc(get<_i7.AuthRepository>(), get<_i16.AuthBloc>()));
  gh.factoryParam<_i19.OperationSaveBloc, _i20.Operation?, dynamic>(
      (operation, _) =>
          _i19.OperationSaveBloc(operation, get<_i13.OperationsRepository>()));
  gh.factoryParam<_i21.OperationUpdateBloc, _i20.Operation?, dynamic>(
      (operation, _) => _i21.OperationUpdateBloc(
          operation, get<_i13.OperationsRepository>()));
  return get;
}

class _$ServerAddressModule extends _i6.ServerAddressModule {}
