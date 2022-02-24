import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/di/injection.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/operation_info.dart';
import 'package:popper_mobile/screen/operation_info/save_operation/bloc/bloc.dart';
import 'package:popper_mobile/screen/routing/app_router.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class OperationSaveScreen extends StatelessWidget implements AutoRouteWrapper {
  final Operation operation;

  const OperationSaveScreen({Key? key, required this.operation})
      : super(key: key);

  bool isLoad(OperationSaveState state) {
    return state is SaveProcessState && state.status.isLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сохранить операцию?')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BlocConsumer<OperationSaveBloc, OperationSaveState>(
          listener: (context, state) async {
            if (state is SaveProcessState && !state.status.isLoad) {
              await _onSaveEnd(context, state);
            }

            if (state is CacheProcessState && !state.status.isLoad) {
              await _onSaveInCacheEnd(context, state);
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
                    BlocProvider.of<OperationSaveBloc>(context)
                        .add(ChangeOperation(t));
                  },
                ),
                SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        color: Colors.red,
                        child: isLoad(state)
                            ? CircularLoader(size: 25, strokeWidth: 3)
                            : Text('Брак', style: TextStyle(fontSize: 18)),
                        onPressed: state.isCanSave
                            ? () => _rejectOperation(context)
                            : null,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SimpleButton(
                        height: 55,
                        color: Colors.green,
                        child: isLoad(state)
                            ? CircularLoader(size: 25, strokeWidth: 3)
                            : Text('Сохранить', style: TextStyle(fontSize: 18)),
                        onPressed: state.isCanSave
                            ? () => _saveOperation(context)
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

  Future<void> _onSaveEnd(BuildContext context, SaveProcessState state) async {
    if (state.status.isSuccessful) {
      final args = ScannerResultArguments(
        message: "Операция успешно сохранена",
        image: "assets/images/success.png",
      );
      context.router.replace(ScannerResultRoute(args: args));
    } else if (state.isSaveError) {
      final isSaveInCache = await _showSaveDialog(context);
      if (isSaveInCache == null || !isSaveInCache) {
        context.router.navigate(const HomeRoute());
      } else {
        BlocProvider.of<OperationSaveBloc>(context).add(CacheOperation());
      }
    } else {
      final args = ScannerResultArguments(
        message: state.failure!.message,
        image: "assets/images/save_exception.png",
      );
      context.router.replace(ScannerResultRoute(args: args));
    }
  }

  Future<void> _onSaveInCacheEnd(
    BuildContext context,
    CacheProcessState state,
  ) async {
    if (state.status.isSuccessful) {
      final args = ScannerResultArguments(
        message: "Операция успешно сохранена в кеш",
        image: "assets/images/success.png",
      );
      context.router.replace(ScannerResultRoute(args: args));
    } else {
      final args = ScannerResultArguments(
        message: "Ошибка сохранения в кеш, проверте правильность данных",
        image: "assets/images/save_exception.png",
      );
      context.router.replace(ScannerResultRoute(args: args));
    }
  }

  Future<bool?> _showSaveDialog(BuildContext context) async {
    final isCacheOperation = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return DecisionDialog(
          title: 'Операция не была сохранена',
          message: 'Произошла ошибка сохранения операции. '
              'Сохранить на устройстве? '
              '(необходимо будет позже произвести ручную синхронизацию)',
        );
      },
    );
    return isCacheOperation;
  }

  void _saveOperation(BuildContext context) =>
      BlocProvider.of<OperationSaveBloc>(context).add(SuccessOperation());

  void _rejectOperation(BuildContext context) =>
      BlocProvider.of<OperationSaveBloc>(context).add(RejectOperation());

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<OperationSaveBloc>(
      create: (_) => getIt.get<OperationSaveBloc>(param1: operation),
      child: this,
    );
  }
}
