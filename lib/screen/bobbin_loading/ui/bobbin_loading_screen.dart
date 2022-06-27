import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
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
        child: BlocConsumer<BobbinLoadingBloc, BobbinState>(
          listenWhen: (_, s) => s is BobbinSuccessState,
          listener: (context, state) {
            final operation = (state as BobbinSuccessState).operation;
            context.router.replace(OperationSaveRoute(operation: operation));
          },
          builder: (_, __) {
            return const Center(
              child: LoadingWidget(
                message: 'Загружаем информацию по катушке...',
              ),
            );
          },
        ),
      ),
    );
  }
}
