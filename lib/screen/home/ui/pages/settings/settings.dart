import 'package:flutter/material.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
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
            Text(
              'Настроки',
              style: theme.textTheme.headlineSmall.bold,
            ),
          ],
        ),
      ),
    );
  }
}
