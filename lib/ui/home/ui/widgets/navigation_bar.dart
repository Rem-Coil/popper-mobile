import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget {
  const NavigationAppBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
  });

  final List<PageModel> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final buttons = <Widget>[];
    final theme = Theme.of(context);

    for (var i = 0; i < items.length; i++) {
      buttons.add(_Tile(
        item: items[i],
        color: i == currentIndex ? theme.primaryColor : Colors.grey,
        onTap: () => onTap(i),
      ));
    }

    buttons.add(TextButton(
      onPressed: () {
        throw Exception();
      },
      child: const Text('Throw Test Exception'),
    ));

    return Container(
      color: backgroundColor,
      child: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buttons,
            ),
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.item,
    required this.color,
    required this.onTap,
  });

  final PageModel item;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      onPressed: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, color: color),
          Text(item.label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}

class PageModel {
  const PageModel({
    required this.page,
    required this.label,
    required this.icon,
    this.color,
  });

  final Widget page;
  final String label;
  final IconData icon;
  final Color? color;
}
