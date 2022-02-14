import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/theme/colors.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/models/action/action.dart';
import 'package:popper_mobile/models/action/action_type.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/routing/routing.dart';
import 'package:popper_mobile/screen/splash/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  Hive
    ..initFlutter()
    ..registerAdapter(BobbinLocalAdapter())
    ..registerAdapter(ActionLocalAdapter())
    ..registerAdapter(ActionTypeAdapter());

  await initializeDateFormatting('ru_RU', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Routing _routing = Routing();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
      ],
      child: MaterialApp(
        title: 'Rem&Coil',
        theme: ThemeData(
          textTheme: fonts(context),
          primarySwatch: primarySwatch,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (s) => _routing.routeFactory(s),
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
