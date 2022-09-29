import 'package:flutter/material.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/exit_button.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/profile_view.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/settings_button.dart';
import 'package:popper_mobile/screen/home/ui/widgets/navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  static const model = PageModel(
    page: SettingsPage(),
    icon: Icons.settings,
    label: 'Настройки',
  );

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Настроки', style: theme.textTheme.headlineSmall.bold),
            const SizedBox(height: 12),
            const ProfileView(),
            SettingsButton(
              icon: Icons.clear,
              title: 'Очистить кеш',
              onPressed: () {
                context.showErrorSnackBar('Очищение кеша');
              },
            ),
            SettingsButton(
              icon: Icons.sync,
              title: 'Принудительная синхронизация',
              onPressed: () {
                context.showSuccessSnackBar('Синхронизация');
              },
            ),
            const Center(child: ExitButton()),
          ],
        ),
      ),
    );
  }
}
