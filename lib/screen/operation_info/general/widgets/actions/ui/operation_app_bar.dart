import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/setup/injection.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';
import 'package:popper_mobile/domain/models/user/role.dart';
import 'package:popper_mobile/screen/current_user/bloc/bloc.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/actions/bloc/bloc.dart';
import 'package:popper_mobile/screen/operation_info/general/widgets/actions/ui/actions_button.dart';
import 'package:popper_mobile/widgets/dialogs/decision_dialog.dart';

class OperationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OperationAppBar({
    super.key,
    required this.title,
    required this.operation,
  });

  final String title;
  final Operation operation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final userState = context.read<CurrentUserBloc>().state as WithUserState;
    final user = userState.user;

    final buttons = operation.item is Bobbin
        ? BlocProvider<DefectingBloc>(
            create: (_) => getIt<DefectingBloc>(),
            child: BobbinButtons(bobbin: operation.item as Bobbin),
          )
        : null;

    return AppBar(
      title: Text(title),
      actions: [
        if (operation.item is Bobbin) ...[
          IconButton(
            icon: const Icon(Icons.history),
            splashRadius: 20.0,
            onPressed: () => context.router.push(
              HistoryRoute(bobbin: operation.item as Bobbin),
            ),
          )
        ],
        if (user.role == Role.qualityEngineer && buttons != null) buttons,
      ],
    );
  }
}

class BobbinButtons extends StatefulWidget {
  const BobbinButtons({
    super.key,
    required this.bobbin,
  });

  final Bobbin bobbin;

  @override
  State<BobbinButtons> createState() => _BobbinButtonsState();
}

class _BobbinButtonsState extends State<BobbinButtons> {
  @override
  Widget build(BuildContext context) {
    final buttons = [
      ActionButtonItemInfo(
        icon: Icons.block,
        onPressed: () async => _onDefecting(),
        title: 'Заброковать катушку',
      ),
    ];

    return BlocListener<DefectingBloc, DefectingState>(
      listener: (context, state) {
        if (state is DefectingStartState) {
          context.showLoadingSnackBar(message: 'Отбраковка в процессе');
        }

        if (state is DefectingFailedState) {
          context.hideCurrentSnackBar();
          context.showErrorSnackBar(state.failure.message);
        }

        if (state is DefectingEndState) {
          context.hideCurrentSnackBar();
          context.showSuccessSnackBar('Успешно!');

          Future.delayed(const Duration(seconds: 1), () {
            context.router.pop();
          });
        }
      },
      child: ActionsButton(buttons: buttons),
    );
  }

  Future<void> _onDefecting() async {
    final isClear = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Пометить катушку как отбракованную?',
          acceptActionTitle: 'Да',
          cancelActionTitle: 'Нет',
        );
      },
    );

    if (isClear == true && mounted) {
      context.read<DefectingBloc>().add(StartDefectingEvent(widget.bobbin.id));
    }
  }
}
