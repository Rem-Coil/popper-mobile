// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i7;
import '../../data/cache/operations_cache_impl.dart' as _i5;
import '../../data/repository/auth_repository_impl.dart' as _i9;
import '../../data/repository/bobbins_repository_impl.dart' as _i11;
import '../../data/repository/operations_repository_impl.dart' as _i15;
import '../../domain/cache/operations_cache.dart' as _i4;
import '../../domain/repository/auth_repository.dart' as _i8;
import '../../domain/repository/bobbins_repository.dart' as _i10;
import '../../domain/repository/operations_repository.dart' as _i14;
import '../../domain/usecase/operation_history_usecase.dart' as _i3;
import '../../models/bobbin/bobbin.dart' as _i20;
import '../../models/operation/operation.dart' as _i23;
import '../../screen/auth/bloc/auth_bloc.dart' as _i17;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i18;
import '../../screen/history/bloc/bloc.dart' as _i19;
import '../../screen/home/bloc/bloc.dart' as _i13;
import '../../screen/login/bloc/bloc.dart' as _i21;
import '../../screen/operation_info/save_operation/bloc/bloc.dart' as _i22;
import '../../screen/operation_info/update_operation/bloc/bloc.dart' as _i25;
import '../../screen/operations_sync/bloc/bloc.dart' as _i24;
import '../../screen/registration/bloc/bloc.dart' as _i26;
import '../../screen/scanned_list/cached_operations/bloc/bloc.dart' as _i12;
import '../../screen/scanned_list/saved_operations/bloc/bloc.dart' as _i16;
import '../../screen/splash/bloc/splash_bloc.dart' as _i6;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final serverAddressModule = _$ServerAddressModule();
  gh.singleton<_i3.OperationHistoryUsecase>(_i3.OperationHistoryUsecase());
  gh.singleton<_i4.OperationsCache>(_i5.OperationsCacheImpl(),
      dispose: (i) => i.dispose());
  gh.singleton<_i6.SplashBloc>(_i6.SplashBloc());
  gh.factory<String>(() => serverAddressModule.baseUrlTest,
      instanceName: 'BaseUrl', registerFor: {_dev});
  gh.factory<String>(() => serverAddressModule.baseUrlProd,
      instanceName: 'BaseUrl', registerFor: {_prod});
  gh.singleton<_i7.ApiProvider>(
      _i7.ApiProvider(get<String>(instanceName: 'BaseUrl')));
  gh.singleton<_i8.AuthRepository>(
      _i9.AuthRepositoryImpl(get<_i7.ApiProvider>()));
  gh.singleton<_i10.BobbinsRepository>(
      _i11.BobbinsRepositoryImpl(get<_i7.ApiProvider>()));
  gh.factory<_i12.CachedOperationsBloc>(
      () => _i12.CachedOperationsBloc(get<_i4.OperationsCache>()));
  gh.singleton<_i13.HomeBloc>(_i13.HomeBloc(get<_i4.OperationsCache>()));
  gh.singleton<_i14.OperationsRepository>(_i15.OperationsRepositoryImpl(
      get<_i7.ApiProvider>(), get<_i4.OperationsCache>()));
  gh.factory<_i16.SavedOperationsBloc>(() => _i16.SavedOperationsBloc(
      get<_i4.OperationsCache>(), get<_i14.OperationsRepository>()));
  gh.singleton<_i17.AuthBloc>(_i17.AuthBloc(get<_i8.AuthRepository>()));
  gh.factory<_i18.BobbinLoadingBloc>(
      () => _i18.BobbinLoadingBloc(get<_i10.BobbinsRepository>()));
  gh.factoryParam<_i19.HistoryBloc, _i20.Bobbin?, dynamic>((bobbin, _) =>
      _i19.HistoryBloc(bobbin, get<_i14.OperationsRepository>(),
          get<_i3.OperationHistoryUsecase>()));
  gh.singleton<_i21.LoginBloc>(
      _i21.LoginBloc(get<_i8.AuthRepository>(), get<_i17.AuthBloc>()));
  gh.factoryParam<_i22.OperationSaveBloc, _i23.Operation?, dynamic>(
      (operation, _) =>
          _i22.OperationSaveBloc(operation, get<_i14.OperationsRepository>()));
  gh.factoryParam<_i24.OperationSyncBloc, List<_i23.Operation>?, dynamic>(
      (operations, _) =>
          _i24.OperationSyncBloc(operations, get<_i14.OperationsRepository>()));
  gh.factoryParam<_i25.OperationUpdateBloc, _i23.Operation?, dynamic>(
      (operation, _) => _i25.OperationUpdateBloc(
          operation, get<_i14.OperationsRepository>()));
  gh.singleton<_i26.RegistrationBloc>(
      _i26.RegistrationBloc(get<_i8.AuthRepository>(), get<_i17.AuthBloc>()));
  return get;
}

class _$ServerAddressModule extends _i7.ServerAddressModule {}
