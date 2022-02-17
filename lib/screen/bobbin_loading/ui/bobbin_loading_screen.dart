import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/models/bobbin/bobbin.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/bobbin_loading/bloc/bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/loading_widget.dart';

class BobbinLoadingScreen extends StatefulWidget implements AutoRouteWrapper {
  final ScannedEntity bobbin;

  const BobbinLoadingScreen({Key? key, required this.bobbin}) : super(key: key);

  @override
  State<BobbinLoadingScreen> createState() => _BobbinLoadingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<BobbinLoadingBloc>(
      create: (_) => getIt<BobbinLoadingBloc>(),
      child: this,
    );
  }
}

class _BobbinLoadingScreenState extends State<BobbinLoadingScreen> {
  @override
  void initState() {
    BlocProvider.of<BobbinLoadingBloc>(context).add(LoadInfo(widget.bobbin));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<BobbinLoadingBloc, BobbinLoadingState>(
          listenWhen: (_, s) => !s.isLoading,
          listener: (context, state) {
            if (state.isSuccessful || state.hasError) {
              final bobbin = state.bobbin ?? Bobbin.unknown(widget.bobbin.id);
              final operation = generateOperation(context, bobbin);
              context.router.replace(OperationSaveRoute(operation: operation));
            }
          },
          builder: (_, __) {
            return Center(
              child: LoadingWidget(
                message: 'Загружаем информацию по катушке...',
              ),
            );
          },
        ),
      ),
    );
  }

  Operation generateOperation(BuildContext context, Bobbin bobbin) {
    final userId = BlocProvider.of<AuthBloc>(context).state.user!.id;
    return Operation.create(
      userId: userId,
      bobbin: bobbin,
      date: DateTime.now(),
    );
  }
}
