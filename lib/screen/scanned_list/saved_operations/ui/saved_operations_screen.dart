import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanned_list/general/widgets/operations_list.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/screen/scanned_list/saved_operations/bloc/bloc.dart';

const status = OperationStatus.saved;

class SavedOperationsScreen extends StatefulWidget implements AutoRouteWrapper {
  const SavedOperationsScreen({Key? key}) : super(key: key);

  @override
  State<SavedOperationsScreen> createState() => _SavedOperationsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SavedOperationsBloc>(
      create: (_) => getIt<SavedOperationsBloc>(),
      child: this,
    );
  }
}

class _SavedOperationsScreenState extends State<SavedOperationsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SavedOperationsBloc>(context)..add(LoadOperations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(status.title),
        backgroundColor: status.color,
      ),
      body: BlocConsumer<SavedOperationsBloc, SavedOperationsState>(
        listenWhen: (previous, current) =>
        previous.deleteFailure == null && current.deleteFailure != null,
        listener: (context, state) {
          context.errorSnackBar(state.deleteFailure!.message);
        },
        builder: (context, state) {
          return Column(
            children: [
              if (state.status.isLoad) LinearProgressIndicator(),
              Expanded(
                child: OperationsList(
                  failure: state.mainFailure,
                  operations: state.operations,
                  onTap: (o) =>
                      context.router.push(UpdateOperationRoute(operation: o)),
                  onDelete: (o) {
                    BlocProvider.of<SavedOperationsBloc>(context)
                        .add(DeleteOperation(o));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
