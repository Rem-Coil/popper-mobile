import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/operation_info/simple_info/ui/simple_info_screen.dart';
import 'package:popper_mobile/screen/scanned_list/cached_operations/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_list/general/widgets/operations_list.dart';
import 'package:popper_mobile/screen/scanned_list/models/operation_status.dart';

class CachedOperationsScreen extends StatefulWidget {
  static const route = "/cached_operations";
  final status = OperationStatus.cached;

  const CachedOperationsScreen({Key? key}) : super(key: key);

  @override
  State<CachedOperationsScreen> createState() => _CachedOperationsScreenState();
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
        title: Text(widget.status.title),
        backgroundColor: widget.status.color,
      ),
      body: BlocBuilder<CachedOperationsBloc, CachedOperationsState>(
        builder: (context, state) {
          return OperationsList(
            failure: state is ErrorState ? state.failure : null,
            operations: state is OperationsLoaded ? state.operations : null,
            onTap: (o) => context.push(SimpleInfoScreen.route, args: o),
            onDelete: (o) {},
          );
        },
      ),
    );
  }
}
