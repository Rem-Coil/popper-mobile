import 'package:flutter/material.dart';
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
    return const Center(child: Text('Настройки'));
  }
}
