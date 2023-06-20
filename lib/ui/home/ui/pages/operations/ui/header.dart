import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.total,
  });

  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.colorScheme.background,
      expandedHeight: 80,
      floating: true,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 8),
        title: SizedBox(
          height: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Выполнено сегодня',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.white54,
                ),
              ),
              Text('$total'),
            ],
          ),
        ),
      ),
    );
  }
}
