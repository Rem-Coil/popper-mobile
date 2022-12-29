import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/loading_widget.dart';

class InfoLoadingView extends StatelessWidget {
  const InfoLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingWidget(
          message: 'Загружаем информацию по катушке...',
        ),
      ),
    );
  }
}
