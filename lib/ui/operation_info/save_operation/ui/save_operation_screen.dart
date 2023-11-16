import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';
import 'package:popper_mobile/domain/models/operation/qe_operation_type.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/ui/operation_info/general/views/info_loading_view.dart';
import 'package:popper_mobile/ui/operation_info/general/views/result_view.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/bloc/bloc.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/ui/widgets/operation_type_dialog.dart';
import 'package:popper_mobile/ui/operation_info/save_operation/ui/widgets/select_operation_type_view.dart';

@RoutePage()
class SaveOperationScreen extends StatefulWidget implements AutoRouteWrapper {
  const SaveOperationScreen({Key? key, required this.codeData})
      : super(key: key);

  final ProductCodeData codeData;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OperationSaveBloc>(
          create: (_) => getIt.get<OperationSaveBloc>(param1: codeData),
        ),
      ],
      child: this,
    );
  }

  @override
  State<SaveOperationScreen> createState() => _SaveOperationScreenState();
}

class _SaveOperationScreenState extends State<SaveOperationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OperationSaveBloc, OperationSaveState>(
      listener: (context, state) async {
        if (state is CanCacheState) {
          await _showCacheDialog();
        } else if (state is ChooseOperationState) {
          await _showChooseOperationTypeDialog();
        }
      },
      buildWhen: (_, state) => state is! ChooseOperationState,
      builder: (context, state) {
        if (state is FetchInfoState) {
          return const InfoLoadingView();
        }

        if (state is SuccessState) {
          return ResultView(message: state.message);
        }

        if (state is FailedState) {
          return ResultView(
            message: state.failure.toString(),
            isSuccess: false,
          );
        }

        return SelectOperationTypeView(state: state as WithOperationState);
      },
    );
  }

  Future<void> _showCacheDialog() async {
    final isSaveInCache = await _showSaveDialog();

    if (!mounted) return;
    if (isSaveInCache == true) {
      context.read<OperationSaveBloc>().add(const CacheOperation());
    } else {
      context.router.navigate(const HomeRoute());
    }
  }

  Future<bool?> _showSaveDialog() {
    return showCupertinoDialog<bool>(
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
  }

  Future<void> _showChooseOperationTypeDialog() async {
    final userChoice = await _showSaveOperationType();

    if (!mounted) return;
    context.read<OperationSaveBloc>().add(ChooseOperationEvent(userChoice));
  }

  Future<OperationType?> _showSaveOperationType() {
    return showCupertinoDialog<OperationType>(
      context: context,
      builder: (BuildContext context) {
        return const OperationTypeDialog();
      },
    );
  }
}
