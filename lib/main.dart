import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:popper_mobile/core/firebase/firebase_crashlytics.dart';

import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/theme/colors.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/data/cache/core/app_cache.dart';
import 'package:popper_mobile/ui/current_user/bloc/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppCache.init();
  await initializeDateFormatting();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await crashlyticsInit();

  configureDependencies(kDebugMode ? 'dev' : 'prod');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserBloc>(
      create: (_) => getIt<CurrentUserBloc>(),
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
