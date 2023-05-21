import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:popper_mobile/core/setup/app_router.dart';
import 'package:popper_mobile/core/utils/context_utils.dart';
import 'package:popper_mobile/domain/models/product/product_code_data.dart';
import 'package:popper_mobile/ui/scanner/ui/widgets/scanner_overlay_shape.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key, required this.controller});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MobileScanner(
        controller: controller,
        onDetect: (b) => onCode(context, b),
      ),
      Padding(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: const ShapeDecoration(
            shape: QrScannerOverlayShape(
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 200.0,
            ),
          ),
        ),
      )
    ]);
  }

  void onCode(BuildContext context, BarcodeCapture capture) {
    try {
      final barcode = capture.barcodes.first;
      final codeData = ProductCodeData.fromCode(barcode.rawValue);
      context.router.replace(SaveOperationRoute(codeData: codeData));
    } catch (_) {
      context.showErrorSnackBar('Неверный формат QR кода');
    }
  }
}
