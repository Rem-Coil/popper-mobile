import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/screen/home/ui/widgets/actions_list_button.dart';
import 'package:popper_mobile/screen/home/ui/widgets/home_header.dart';
import 'package:popper_mobile/screen/scanner/ui/scanner_screen.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: 47),
            Row(
              children: [
                Expanded(
                  child: ActionsListButton(
                    color: 0xFFF4B41A,
                    title: 'Завершённые катушки:',
                    count: 8,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ActionsListButton(
                    color: 0xFFF50303,
                    title: 'Не загруженные катушки',
                    count: 1,
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            SimpleButton(
              width: double.infinity,
              height: 67,
              borderRadius: 16,
              onPressed: () {
                // final scanned = ScannedEntity.fromString('bobbin:1');
                // context.push(BobbinLoadingScreen.route, args: scanned);
                context.push(ScannerScreen.route);
              },
              child: Row(
                children: [
                  Text(
                    'Сканировать',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
