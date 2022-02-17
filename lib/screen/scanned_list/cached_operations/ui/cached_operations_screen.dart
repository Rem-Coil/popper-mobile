import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanned_list/cached_operations/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_list/general/widgets/operations_list.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';

const status = OperationStatus.cached;

class CachedOperationsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const CachedOperationsScreen({Key? key}) : super(key: key);

  @override
  State<CachedOperationsScreen> createState() => _CachedOperationsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<CachedOperationsBloc>(
      create: (_) => getIt<CachedOperationsBloc>(),
      child: this,
    );
  }
}

class _CachedOperationsScreenState extends State<CachedOperationsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CachedOperationsBloc>(context)..add(LoadOperations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(status.title),
        backgroundColor: status.color,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.cached))],
      ),
      body: BlocConsumer<CachedOperationsBloc, CachedOperationsState>(
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
                      context.router.push(SimpleInfoRoute(operation: o)),
                  onDelete: (o) {
                    BlocProvider.of<CachedOperationsBloc>(context)
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
