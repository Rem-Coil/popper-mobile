import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/operation_info.dart';
import 'package:popper_mobile/screen/operation_info/update_operation/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/screen/scanner_result/ui/scanner_result_screen.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';

class UpdateOperationScreen extends StatelessWidget {
  static const String route = '/operation_update';

  const UpdateOperationScreen({Key? key}) : super(key: key);

  bool isLoad(OperationUpdateState state) {
    return state is UpdateProcessState && state.status.isLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сохранить операцию?')),
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
                SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        child: Text('Отмена', style: TextStyle(fontSize: 18)),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        child: isLoad(state)
                            ? CircularLoader(size: 25, strokeWidth: 3)
                            : Text('Обновить', style: TextStyle(fontSize: 18)),
                        onPressed: state.isCanSave
                            ? () => _updateOperation(context)
                            : null,
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
        message: "Операция успешно обновлена",
        image: "assets/images/success.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    } else {
      final args = ScannerResultArguments(
        message: state.failure!.message,
        image: "assets/images/save_exception.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    }
  }

  void _updateOperation(BuildContext context) =>
      BlocProvider.of<OperationUpdateBloc>(context).add(UpdateOperation());
}
