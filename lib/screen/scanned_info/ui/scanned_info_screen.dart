import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/auth/bloc/auth_bloc.dart';
import 'package:popper_mobile/screen/scanned_info/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_field.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_text.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/scanned_info_warning.dart';
import 'package:popper_mobile/screen/scanned_info/ui/widgets/select_operation_field.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/screen/scanner_result/ui/scanner_result_screen.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class ScannedInfoScreen extends StatelessWidget {
  static const String route = '/scannedInfo';

  const ScannedInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Сохранить операцию?')),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: BlocConsumer<OperationSaveBloc, OperationSaveState>(
            listener: (context, state) async {
              if (state is ProcessSaveState && !state.status.isLoad) {
                await _onSaveEnd(context, state);
              }

              if (state is SaveInCacheState && !state.status.isLoad) {
                await _onSaveInCacheEnd(context, state);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (state.isBobbinNotLoaded) ...[
                    ScannedInfoField(
                      title: 'Идентификатор катушки',
                      value: ScannedInfoText(state.bobbinId),
                    ),
                    SizedBox(height: 24),
                  ],
                  ScannedInfoField(
                    title: 'Номер катушки',
                    value: state.isBobbinNotLoaded
                        ? ScannedInfoWarning(state.bobbinNumber)
                        : ScannedInfoText(state.bobbinNumber),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Сотрудник',
                    value: ScannedInfoText(_getUserName(context)),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Операция',
                    value: (state is SelectTypeState)
                        ? SelectOperationButton(type: state.currentType)
                        : ScannedInfoText(state.currentType),
                  ),
                  SizedBox(height: 24),
                  ScannedInfoField(
                    title: 'Дата сканирования',
                    value: ScannedInfoText(state.formattedDate),
                  ),
                  SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: SimpleButton(
                          height: 55,
                          child: Text(
                            'Отмена',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SimpleButton(
                          height: 55,
                          child: (state is ProcessSaveState &&
                                  state.status.isLoad)
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 3))
                              : Text('Сохранить',
                                  style: TextStyle(fontSize: 18)),
                          onPressed: state.isCanSave
                              ? () => _saveAction(context)
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
      ),
    );
  }

  Future<void> _onSaveEnd(BuildContext context, ProcessSaveState state) async {
    if (state.status.isSuccessful) {
      final args = ScannerResultArguments(
        message: "Операция успешно сохранена",
        image: "assets/images/success.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    } else if (state.isSaveError) {
      final isSaveInCache = await _showSaveDialog(context);
      if (isSaveInCache == null || !isSaveInCache) {
        context.pop();
      } else {
        BlocProvider.of<OperationSaveBloc>(context).add(CacheOperation());
      }
    } else {
      final args = ScannerResultArguments(
        message: state.failure!.message,
        image: "assets/images/save_exception.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    }
  }

  Future<void> _onSaveInCacheEnd(
    BuildContext context,
    SaveInCacheState state,
  ) async {
    if (state.status.isSuccessful) {
      final args = ScannerResultArguments(
        message: "Операция успешно сохранена в кеш",
        image: "assets/images/success.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    } else {
      final args = ScannerResultArguments(
        message: "Ошибка сохранения в кеш, проверте правильность данных",
        image: "assets/images/save_exception.png",
      );
      context.pushReplacement(ScannerResultScreen.route, args: args);
    }
  }

  Future<bool?> _showSaveDialog(BuildContext context) async =>
      showCupertinoDialog<bool>(
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

  void _saveAction(BuildContext context) =>
      BlocProvider.of<OperationSaveBloc>(context).add(SaveOperation());

  String _getUserName(BuildContext context) {
    final authState = BlocProvider.of<AuthBloc>(context).state;
    return authState.user!.fullName;
  }
}
