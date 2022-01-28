import 'package:flutter/material.dart';
import 'package:popper_mobile/screen/home/ui/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            HomeHeader(),
          ],
        ),
      ),
    );
  }
}
