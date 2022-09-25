import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/home/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/pages/operations/bloc/bloc.dart';
import 'package:popper_mobile/screen/home/ui/widgets/navigation_bar.dart';

class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OperationsBloc>(create: (_) => getIt<OperationsBloc>()),
        BlocProvider<PagesControllerBloc>(
          create: (_) => getIt<PagesControllerBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PagesControllerBloc, PagesControllerState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            color: theme.backgroundColor,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.only(bottom: 16),
                color: Colors.white,
                child: state.page,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: не забыть убрать перед коммитом в релиз
              // final scanned = ScannedEntity.fromString('bobbin:201');
              // context.router.push(BobbinLoadingRoute(bobbin: scanned));
              context.router.push(const ScannerRoute());
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: NavigationAppBar(
            items: state.items,
            currentIndex: state.currentPage,
            onTap: (i) {
              context.read<PagesControllerBloc>().add(ChangeScreenEvent(i));
            },
          ),
        );
      },
    );
  }
}
