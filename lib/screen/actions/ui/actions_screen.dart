import 'package:flutter/material.dart';

class ActionsScreen extends StatelessWidget {
  static const route = '/actions';

  const ActionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История операций'),
      ),
      body: Center(child: Text('Screen')),
    );
  }
}
