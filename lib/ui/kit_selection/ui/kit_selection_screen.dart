import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/circular_loader.dart';
import 'package:popper_mobile/ui/kit_selection/bloc/bloc.dart';
import 'package:popper_mobile/ui/kit_selection/ui/widgets/kit_scroll_view.dart';

@RoutePage()
class KitSelectionScreen extends StatelessWidget implements AutoRouteWrapper  {
  const KitSelectionScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<KitSelectionBloc>(
      create: (_) => getIt<KitSelectionBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор наборов'),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: BlocBuilder<KitSelectionBloc, KitSelectionState>(
          builder: (context, state) {
            if (state is LoadKitState) {
              return const Center(
                child: CircularLoader(size: 50, strokeWidth: 5),
              );
            }

            return KitScrollView(state: (state as SaveKitSelectionState));
          },
        ),
      ),
    );
  }
}


