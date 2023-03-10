import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(String env) => $initGetIt(getIt, environment: env);
