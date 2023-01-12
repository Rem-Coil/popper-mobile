import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:popper_mobile/ui/scanner/ui/widgets/icon_button_with_dual_state.dart';
import 'package:popper_mobile/ui/scanner/ui/widgets/scanner_view.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late final MobileScannerController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отсканируйте катушку:'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: ScannerView(controller: cameraController),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButtonWithDualState(
                      onPressed: () => cameraController.toggleTorch(),
                      valueListenable: cameraController.torchState,
                      firstValue: TorchState.off,
                      firstIcon: const Icon(
                        Icons.flash_off,
                        color: Colors.grey,
                      ),
                      anotherIcon: const Icon(
                        Icons.flash_on,
                        color: Colors.yellow,
                      ),
                    ),
                    IconButtonWithDualState(
                      onPressed: () => cameraController.switchCamera(),
                      valueListenable: cameraController.cameraFacingState,
                      firstValue: CameraFacing.front,
                      firstIcon: const Icon(
                        Icons.camera_front,
                        color: Colors.grey,
                      ),
                      anotherIcon: const Icon(
                        Icons.camera_rear,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
