import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/operation_info.dart';
import 'package:popper_mobile/screen/operation_info/update_operation/bloc/bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class UpdateOperationScreen extends StatelessWidget
    implements AutoRouteWrapper {
  final Operation operation;

  const UpdateOperationScreen({Key? key, required this.operation})
      : super(key: key);

  bool isLoad(OperationUpdateState state) {
    return state is UpdateProcessState && state.status.isLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Обновить операцию?')),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: BlocConsumer<OperationUpdateBloc, OperationUpdateState>(
          listener: (context, state) async {
            if (state is UpdateProcessState && !state.status.isLoad) {
              await _onUpdateEnd(context, state);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OperationInfo(
                  operation: state.operation,
                  isImmutable: state is ChangeOperation,
                  onTypeSelected: (t) {
                    BlocProvider.of<OperationUpdateBloc>(context)
                        .add(ChangeOperation(t));
                  },
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        color: Colors.red,
                        onPressed: state.isCanSave(true)
                            ? () => _rejectOperation(context)
                            : null,
                        child: isLoad(state)
                            ? const CircularLoader(size: 25, strokeWidth: 3)
                            : const Text('Брак',
                                style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        color: Colors.green,
                        onPressed: state.isCanSave(false)
                            ? () => _updateOperation(context)
                            : null,
                        child: isLoad(state)
                            ? const CircularLoader(size: 25, strokeWidth: 3)
                            : const Text('Успешно',
                                style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _onUpdateEnd(
    BuildContext context,
    UpdateProcessState state,
  ) async {
    if (state.status.isSuccessful) {
      final args = ScannerResultArguments(
        message: 'Операция успешно обновлена',
        image: 'assets/images/success.png',
      );
      context.router.replace(ScannerResultRoute(args: args));
    } else {
      final args = ScannerResultArguments(
        message: state.failure!.message,
        image: 'assets/images/save_exception.png',
      );
      context.router.replace(ScannerResultRoute(args: args));
    }
  }

  void _updateOperation(BuildContext context) =>
      BlocProvider.of<OperationUpdateBloc>(context).add(SuccessOperation());

  void _rejectOperation(BuildContext context) =>
      BlocProvider.of<OperationUpdateBloc>(context).add(RejectOperation());

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OperationUpdateBloc>(
      create: (_) => getIt.get<OperationUpdateBloc>(param1: operation),
      child: this,
    );
  }
}
