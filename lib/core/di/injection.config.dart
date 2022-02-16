// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/api/api_provider.dart' as _i3;
import '../../data/cache/operations_cache.dart' as _i6;
import '../../data/repository/auth_repository.dart' as _i4;
import '../../data/repository/bobbins_repository.dart' as _i5;
import '../../data/repository/operations_repository.dart' as _i14;
import '../../models/operation/operation.dart' as _i16;
import '../../screen/auth/bloc/auth_bloc.dart' as _i8;
import '../../screen/bobbin_loading/bloc/bloc.dart' as _i9;
import '../../screen/home/bloc/bloc.dart' as _i10;
import '../../screen/login/bloc/login_bloc.dart' as _i11;
import '../../screen/scanned_info/bloc/bloc.dart' as _i15;
import '../../screen/scanned_list/bloc/bloc.dart' as _i12;
import '../../screen/scanned_list/models/operation_status.dart' as _i13;
import '../../screen/splash/bloc/splash_bloc.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiProvider>(_i3.ApiProvider());
  gh.singleton<_i4.AuthRepository>(_i4.AuthRepository(get<_i3.ApiProvider>()));
  gh.singleton<_i5.BobbinsRepository>(
      _i5.BobbinsRepository(get<_i3.ApiProvider>()));
  gh.singleton<_i6.OperationsCache>(_i6.OperationsCache(),
      dispose: (i) => i.dispose());
  gh.singleton<_i7.SplashBloc>(_i7.SplashBloc());
  gh.singleton<_i8.AuthBloc>(_i8.AuthBloc(get<_i4.AuthRepository>()));
  gh.factory<_i9.BobbinLoadingBloc>(
      () => _i9.BobbinLoadingBloc(get<_i5.BobbinsRepository>()));
  gh.singleton<_i10.HomeBloc>(_i10.HomeBloc(get<_i6.OperationsCache>()));
  gh.singleton<_i11.LoginBloc>(
      _i11.LoginBloc(get<_i4.AuthRepository>(), get<_i8.AuthBloc>()));
  gh.factoryParam<_i12.OperationListBloc, _i13.OperationStatus?, dynamic>(
      (status, _) =>
          _i12.OperationListBloc(status, get<_i6.OperationsCache>()));
  gh.singleton<_i14.OperationRepository>(_i14.OperationRepository(
      get<_i6.OperationsCache>(), get<_i3.ApiProvider>()));
  gh.factoryParam<_i15.OperationSaveBloc, _i16.Operation?, dynamic>(
      (operation, _) =>
          _i15.OperationSaveBloc(operation, get<_i14.OperationRepository>()));
  return get;
}
