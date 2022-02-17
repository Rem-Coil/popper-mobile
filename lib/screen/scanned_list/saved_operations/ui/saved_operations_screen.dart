import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/operation_info/update_operation/ui/update_operation_screen.dart';
import 'package:popper_mobile/screen/scanned_list/general/widgets/operations_list.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';
import 'package:popper_mobile/screen/scanned_list/saved_operations/bloc/bloc.dart';

class SavedOperationsScreen extends StatefulWidget {
  static const route = "/saved_operations";
  final status = OperationStatus.saved;

  const SavedOperationsScreen({Key? key}) : super(key: key);

  @override
  State<SavedOperationsScreen> createState() => _SavedOperationsScreenState();
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
        title: Text(widget.status.title),
        backgroundColor: widget.status.color,
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
                      context.push(UpdateOperationScreen.route, args: o),
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
