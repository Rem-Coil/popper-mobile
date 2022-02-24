import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/bloc/bloc.dart';
import 'package:popper_mobile/screen/operations_sync/ui/widgets/synchronization_operation.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class OperationsSyncScreen extends StatelessWidget implements AutoRouteWrapper {
  final List<Operation> operations;

  const OperationsSyncScreen({
    Key? key,
    required this.operations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Синхронизация операций')),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<OperationSyncBloc, OperationSyncState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    itemCount: state.operations.length,
                    itemBuilder: (context, i) {
                      final operation = state.operations[i];
                      return SynchronizationOperation(
                        operation: operation.operation,
                        status: operation.status,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SimpleButton(
                    width: 150,
                    borderRadius: 20,
                    child: Text('Отмена', style: TextStyle(fontSize: 18)),
                    onPressed: () => context.router.navigate(const HomeRoute()),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OperationSyncBloc>(
      create: (_) => getIt.get<OperationSyncBloc>(param1: operations),
      child: this,
    );
  }
}
