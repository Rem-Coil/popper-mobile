import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/core/data/app_cache.dart';
import 'package:popper_mobile/ui/home/ui/pages/settings/bloc/bloc.dart';
import 'package:popper_mobile/ui/home/ui/pages/settings/widgets/settings_button.dart';
import 'package:popper_mobile/core/widgets/dialogs/decision_dialog.dart';

class ClearCacheButton extends StatefulWidget {
  const ClearCacheButton({super.key});

  @override
  State<ClearCacheButton> createState() => _ClearCacheButtonState();
}

class _ClearCacheButtonState extends State<ClearCacheButton> {
  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      icon: Icons.clear,
      title: 'Очистить кеш',
      onPressed: _onClear,
    );
  }

  Future<void> _onClear() async {
    final isClear = await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return const DecisionDialog(
          title: 'Очистить кеш?',
          message: 'Все сохраненные на телефоне данные будут уничтожены.'
              ' Вы уверены что хотите очистить кеш?',
          acceptActionTitle: 'Да',
          cancelActionTitle: 'Нет',
        );
      },
    );

    if (isClear == true && mounted) {
      await AppCache.clear();
    }
  }
}

class SyncButton extends StatefulWidget {
  const SyncButton({super.key});

  @override
  State<SyncButton> createState() => _SyncButtonState();
}

class _SyncButtonState extends State<SyncButton> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SynchronizationBloc, SynchronizationState>(
      listener: (context, state) {
        if (state is SynchronizationStartState) {
          context.showLoadingSnackBar(message: 'Синхронизация');
        }

        if (state is SynchronizationFailedState) {
          context.hideCurrentSnackBar();
          context.showWarningSnackBar(state.failure.toString());
        }

        if (state is SynchronizationEndState) {
          context.hideCurrentSnackBar();
          context.showSuccessSnackBar('Успешно!');
        }
      },
      child: SettingsButton(
        icon: Icons.sync,
        title: 'Принудительная синхронизация',
        onPressed: () => context
            .read<SynchronizationBloc>()
            .add(const StartSynchronizationEvent()),
      ),
    );
  }
}

class KitSelectionButton extends StatelessWidget {
  const KitSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      icon: Icons.save,
      title: 'Сохранение наборов',
      onPressed: () => context.router.push(const KitSelectionRoute()),
    );
  }
}
