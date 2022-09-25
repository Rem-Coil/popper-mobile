import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/bloc/status.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/models/auth/user_role.dart';
import 'package:popper_mobile/models/operation/operation.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/operation_info.dart';
import 'package:popper_mobile/screen/operation_info/save_operation/bloc/bloc.dart';
import 'package:popper_mobile/screen/scanner_result/model/scanner_result_arguments.dart';
import 'package:popper_mobile/screen/user_info/bloc/bloc.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class OperationSaveScreen extends StatefulWidget implements AutoRouteWrapper {
  final Operation operation;

  const OperationSaveScreen({Key? key, required this.operation})
      : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OperationSaveBloc>(
            create: (_) => getIt.get<OperationSaveBloc>(param1: operation)),
        BlocProvider<UserInfoBloc>(create: (_) => getIt<UserInfoBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<OperationSaveScreen> createState() => _OperationSaveScreenState();
}

class _OperationSaveScreenState extends State<OperationSaveScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserInfoBloc>(context).add(LoadUserEvent());
  }

  bool isLoad(OperationSaveState state) {
    return state is SaveProcessState && state.status.isLoad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сохранить операцию?'),
        actions: [
          IconButton(
            onPressed: () {
              context.router
                  .push(HistoryRoute(bobbin: widget.operation.bobbin));
            },
            icon: const Icon(Icons.history),
            splashRadius: 20.0,
          ),
        ],
      ),
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
                const SizedBox(height: 48),
                BlocBuilder<UserInfoBloc, UserInfoState>(
                    builder: (userContext, userState) {
                  if (userState is UserInfoSuccessState) {
                    switch (userState.user.role) {
                      case UserRole.operator:
                        return SimpleButton(
                          width: double.infinity,
                          height: 55,
                          color: Colors.green,
                          onPressed: state.isCanSave
                              ? () => _saveOperation(context)
                              : null,
                          child: isLoad(state)
                              ? const CircularLoader(size: 25, strokeWidth: 3)
                              : const Text('Сохранить',
                                  style: TextStyle(fontSize: 18)),
                        );
                      case UserRole.qualityEngineer:
                        return SimpleButton(
                          width: double.infinity,
                          height: 55,
                          color: Colors.red,
                          onPressed: state.isCanSave
                              ? () => _rejectOperation(context)
                              : null,
                          child: isLoad(state)
                              ? const CircularLoader(size: 25, strokeWidth: 3)
                              : const Text('Брак',
                                  style: TextStyle(fontSize: 18)),
                        );
                    }
                  } else {
                    return const CircularLoader(size: 24);
                  }
                }),
                const SizedBox(width: 16),
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
        message: 'Операция успешно сохранена',
        image: 'assets/images/success.png',
      );
      context.router.replace(ScannerResultRoute(args: args));
    } else if (state.isSaveError) {
      final isSaveInCache = await _showSaveDialog(context);
      if (isSaveInCache == null || !isSaveInCache) {
        context.router.navigate(const HomeRoute());
      } else {
        context.read<OperationSaveBloc>().add(CacheOperation());
      }
    } else {
      final args = ScannerResultArguments(
        message: state.failure!.message,
        image: 'assets/images/save_exception.png',
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
        message: 'Операция успешно сохранена в кеш',
        image: 'assets/images/success.png',
      );
      context.router.replace(ScannerResultRoute(args: args));
    } else {
      final args = ScannerResultArguments(
        message: 'Ошибка сохранения в кеш, проверте правильность данных',
        image: 'assets/images/save_exception.png',
      );
      context.router.replace(ScannerResultRoute(args: args));
    }
  }

  Future<bool?> _showSaveDialog(BuildContext context) async {
    final isCacheOperation = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
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
}
