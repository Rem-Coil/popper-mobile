import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operations_sync/bloc/bloc.dart';
import 'package:popper_mobile/screen/operations_sync/ui/widgets/synchronization_operation.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class OperationsSyncScreen extends StatefulWidget implements AutoRouteWrapper {
  final List<Operation> operations;

  const OperationsSyncScreen({
    Key? key,
    required this.operations,
  }) : super(key: key);

  @override
  State<OperationsSyncScreen> createState() => _OperationsSyncScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OperationSyncBloc>(
      create: (_) => getIt.get<OperationSyncBloc>(param1: operations),
      child: this,
    );
  }
}

class _OperationsSyncScreenState extends State<OperationsSyncScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OperationSyncBloc>(context)
        .add(const StartOperationsSynchronization());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Синхронизация операций'),
        leading: SizedBox.shrink(),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<OperationSyncBloc, OperationSyncState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 10,
                  child: ListView.separated(
                    separatorBuilder: (context, _) => SizedBox(height: 8),
                    itemCount: state.operations.length,
                    itemBuilder: (context, i) {
                      return SynchronizationOperation(
                        operation: state.operations[i],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: state.isSyncEnd
                      ? SimpleButton(
                          width: 150,
                          borderRadius: 20,
                          child: Text('Готово', style: TextStyle(fontSize: 18)),
                          onPressed: () =>
                              context.router.navigate(const HomeRoute()),
                        )
                      : SizedBox.expand(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
