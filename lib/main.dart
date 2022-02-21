import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/theme/colors.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/firebase/firebase_crashlytics.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/models/operation/operation_type.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await crashlyticsInit();

    await hiveInitial();
    configureDependencies(kDebugMode ? 'dev' : 'prod');

    await initializeDateFormatting('ru_RU', null);

    runApp(MyApp());
  }, (e, s) => FirebaseCrashlytics.instance.recordError(e, s));
}

Future<void> hiveInitial() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(BobbinLocalAdapter())
    ..registerAdapter(OperationLocalAdapter())
    ..registerAdapter(OperationTypeAdapter());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Rem&Coil',
        theme: ThemeData(
          textTheme: fonts(context),
          primarySwatch: primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
