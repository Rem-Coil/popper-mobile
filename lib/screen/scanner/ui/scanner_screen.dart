import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:popper_mobile/screen/scanner/ui/widgets/camera_view.dart';

class ScannerScreen extends StatefulWidget {
  static const String route = '/scanner';

  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  bool isBusy = false;
  String scanned = '';

  @override
  Widget build(BuildContext context) {
    return CameraView(
      onImage: processImage,
      scannedValue: scanned,
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final barcodes = await barcodeScanner.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.length != 0) {
      setState(() {
        scanned = barcodes[0].value.displayValue ?? '';
      });
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
