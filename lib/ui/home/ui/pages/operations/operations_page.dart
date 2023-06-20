import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/ui/home/ui/pages/operations/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/pages/operations/ui/body.dart';
import 'package:popper_mobile/ui/home/ui/pages/operations/ui/header.dart';
import 'package:popper_mobile/ui/home/ui/widgets/navigation_bar.dart';

class OperationsPage extends StatefulWidget {
  static const model = PageModel(
    icon: Icons.home,
    label: 'Главная',
    page: OperationsPage(),
    color: Colors.white,
  );

  const OperationsPage({super.key});

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage>
    with AutoRouteAwareStateMixin<OperationsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.background,
      child: BlocBuilder<OperationsBloc, OperationsState>(
        builder: (context, state) {
          late final Widget body;

          if (state is LoadingOperationsState) {
            body = const Center(child: CircularLoader(size: 50));
          }

          if (state is OperationsLoadedState) {
            body = BodyWithList(operations: state.operations);
          }

          return NestedScrollView(
            headerSliverBuilder: (context, _) => [
              Header(total: state.todayTotal),
            ],
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: body,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void didPush() {
    context.read<OperationsBloc>().add(const UpdateEvent());
  }

  @override
  void didPopNext() {
    context.read<OperationsBloc>().add(const UpdateEvent());
  }
}
