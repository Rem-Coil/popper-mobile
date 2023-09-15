import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/ui/home/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/pages/operations/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/pages/settings/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/widgets/navigation_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OperationsBloc>(create: (_) => getIt<OperationsBloc>()),
        BlocProvider<SynchronizationBloc>(
          create: (_) => getIt<SynchronizationBloc>(),
        ),
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
            color: theme.colorScheme.background,
            child: SafeArea(
              child: Container(
                color: state.page.color ?? theme.scaffoldBackgroundColor,
                padding: const EdgeInsets.only(bottom: 16),
                child: state.page.page,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: не забыть убрать перед коммитом в релиз
              final codeData = ProductCodeData.fromCode('s:1;p:1;');
              context.router.push(SaveOperationRoute(codeData: codeData));
              // context.router.push(const ScannerRoute());
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: NavigationAppBar(
            backgroundColor: state.page.color,
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
