import 'package:flutter/material.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';

class BobbinLoadingScreen extends StatelessWidget {
  static const String route = '/bobbinLoading';

  final ScannedEntity bobbin;

  const BobbinLoadingScreen({Key? key, required this.bobbin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          bobbin.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
