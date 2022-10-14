import 'package:flutter/material.dart';
import 'package:popper_mobile/core/theme/fonts.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/buttons.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/exit_button.dart';
import 'package:popper_mobile/screen/home/ui/pages/settings/widgets/profile_view.dart';
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

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Настроки',
                              style: theme.textTheme.headlineSmall.bold),
                          const SizedBox(height: 12),
                          const ProfileView(),
                          const ClearCacheButton(),
                          const SyncButton(),
                        ],
                      ),
                    ),
                    const Center(child: ExitButton()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
