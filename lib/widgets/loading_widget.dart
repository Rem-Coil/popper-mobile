import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/circular_loader.dart';
import 'package:popper_mobile/widgets/logo.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          const Logo(235),
          const SizedBox(height: 40),
          const CircularLoader(size: 100, strokeWidth: 5),
          const SizedBox(height: 40),
          SizedBox(
            width: 220,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Color(0xFF71706D)),
            ),
          )
        ],
      ),
    );
  }
}
