import 'package:flutter/material.dart';
import 'package:popper_mobile/widgets/logo.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Column(
        children: [
          Logo(235),
          SizedBox(height: 40),
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              // color: Color(0xFFA8A8A8),
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: 200,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Color(0xFFA8A8A8)),
            ),
          )
        ],
      ),
    );
  }
}
