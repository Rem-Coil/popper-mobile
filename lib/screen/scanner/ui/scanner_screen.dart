import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/models/barcode/scanned_entity.dart';
import 'package:popper_mobile/screen/bobbin_loading/ui/bobbin_loading_screen.dart';
import 'package:popper_mobile/widgets/buttons/simple_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  static const String route = '/scanner';

  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isBusy = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Отсканируйте катушку:')),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SimpleButton(
                      height: 40,
                      width: 40,
                      borderRadius: 20,
                      padding: const EdgeInsets.all(8),
                      child: FutureBuilder<bool?>(
                        future: controller?.getFlashStatus(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null || !snapshot.data!) {
                            return Icon(Icons.flash_on);
                          }
                          return Icon(Icons.flash_off);
                        },
                      ),
                      onPressed: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                      },
                    ),
                    SimpleButton(
                      height: 40,
                      width: 40,
                      borderRadius: 20,
                      padding: const EdgeInsets.all(8),
                      child: Icon(Icons.flip_camera_android),
                      onPressed: () async {
                        await controller?.flipCamera();
                        setState(() {});
                      },
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

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(onCode);
  }

  void onCode(Barcode code) {
    if (isBusy) return;
    setState(() {
      isBusy = true;
    });

    try {
      final scanned = ScannedEntity.fromString(code.code);
      if (scanned.type == EntityType.bobbin) {
        context.pushReplacement(BobbinLoadingScreen.route, args: scanned);
      } else {
        _showError('Вы отсканировали не катушку');
      }
    } catch (e) {
      _showError('Ошибка сканирования катушки, попробуйте позже');
    }
  }

  void _showError(String message) {
    context.errorSnackBar(message);
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => isBusy = false),
    );
  }

  void _onPermissionSet(QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
