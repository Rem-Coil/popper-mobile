import 'package:flutter/foundation.dart';

@immutable
abstract class QrCodeReadException implements Exception {
  const QrCodeReadException();
}

class CodeNotRecognizedException extends QrCodeReadException {
  const CodeNotRecognizedException();
}

class CodeNotContainDataException extends QrCodeReadException {
  const CodeNotContainDataException();
}
