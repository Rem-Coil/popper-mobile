// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i8;
import '../../data/cache/operations_cache_impl.dart' as _i6;
import '../../data/repository/auth_repository_impl.dart' as _i10;
import '../../data/repository/bobbins_repository_impl.dart' as _i12;
import '../../data/repository/operations_repository_impl.dart' as _i16;
import '../../domain/cache/operations_cache.dart' as _i5;
import '../../domain/repository/auth_repository.dart' as _i9;
import '../../domain/repository/bobbins_repository.dart' as _i11;
import '../../domain/repository/operations_repository.dart' as _i15;
import '../../models/operation/operation.dart' as _i4;
import '../../screen/auth/bloc/auth_bloc.dart' as _i18;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i19;
import '../../screen/home/bloc/bloc.dart' as _i14;
import '../../screen/login/bloc/bloc.dart' as _i20;
import '../../screen/operation_info/save_operation/bloc/bloc.dart' as _i21;
import '../../screen/operation_info/update_operation/bloc/bloc.dart' as _i22;
import '../../screen/operations_sync/bloc/bloc.dart' as _i3;
import '../../screen/registration/bloc/bloc.dart' as _i23;
import '../../screen/scanned_list/cached_operations/bloc/bloc.dart' as _i13;
import '../../screen/scanned_list/saved_operations/bloc/bloc.dart' as _i17;
import '../../screen/splash/bloc/splash_bloc.dart' as _i7;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serverAddressModule = _$ServerAddressModule();
  gh.factoryParam<_i3.OperationSyncBloc, List<_i4.Operation>?, dynamic>(
      (operations, _) => _i3.OperationSyncBloc(operations));
  gh.singleton<_i5.OperationsCache>(_i6.OperationsCacheImpl(),
      dispose: (i) => i.dispose());
  gh.singleton<_i7.SplashBloc>(_i7.SplashBloc());
  gh.factory<String>(() => serverAddressModule.baseUrlTest,
      instanceName: 'BaseUrl', registerFor: {_dev});
  gh.factory<String>(() => serverAddressModule.baseUrlProd,
      instanceName: 'BaseUrl', registerFor: {_prod});
  gh.singleton<_i8.ApiProvider>(
      _i8.ApiProvider(get<String>(instanceName: 'BaseUrl')));
  gh.singleton<_i9.AuthRepository>(
      _i10.AuthRepositoryImpl(get<_i8.ApiProvider>()));
  gh.singleton<_i11.BobbinsRepository>(
      _i12.BobbinsRepositoryImpl(get<_i8.ApiProvider>()));
  gh.factory<_i13.CachedOperationsBloc>(
      () => _i13.CachedOperationsBloc(get<_i5.OperationsCache>()));
  gh.singleton<_i14.HomeBloc>(_i14.HomeBloc(get<_i5.OperationsCache>()));
  gh.singleton<_i15.OperationsRepository>(_i16.OperationRepositoryImpl(
      get<_i8.ApiProvider>(), get<_i5.OperationsCache>()));
  gh.factory<_i17.SavedOperationsBloc>(() => _i17.SavedOperationsBloc(
      get<_i5.OperationsCache>(), get<_i15.OperationsRepository>()));
  gh.singleton<_i18.AuthBloc>(_i18.AuthBloc(get<_i9.AuthRepository>()));
  gh.factory<_i19.BobbinLoadingBloc>(
      () => _i19.BobbinLoadingBloc(get<_i11.BobbinsRepository>()));
  gh.singleton<_i20.LoginBloc>(
      _i20.LoginBloc(get<_i9.AuthRepository>(), get<_i18.AuthBloc>()));
  gh.factoryParam<_i21.OperationSaveBloc, _i4.Operation?, dynamic>(
      (operation, _) =>
          _i21.OperationSaveBloc(operation, get<_i15.OperationsRepository>()));
  gh.factoryParam<_i22.OperationUpdateBloc, _i4.Operation?, dynamic>((operation,
          _) =>
      _i22.OperationUpdateBloc(operation, get<_i15.OperationsRepository>()));
  gh.singleton<_i23.RegistrationBloc>(
      _i23.RegistrationBloc(get<_i9.AuthRepository>(), get<_i18.AuthBloc>()));
  return get;
}

class _$ServerAddressModule extends _i8.ServerAddressModule {}
