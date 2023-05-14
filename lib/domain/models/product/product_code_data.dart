import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/exceptions/qr_code_read_exception.dart';

@immutable
class ProductCodeData {
  @protected
  const ProductCodeData({required this.id, required this.specificationId});

  factory ProductCodeData.fromCode(String? code) {
    if (code == null) throw const CodeNotRecognizedException();

    final entries =
        code.split(';').where((e) => e.isNotEmpty).map((e) => e.split(':'));
    final values = {for (var i in entries) i[0]: int.parse(i[1])};

    if (!values.containsKey('p') || !values.containsKey('s')) {
      throw const CodeNotContainDataException();
    }

    return ProductCodeData(id: values['p']!, specificationId: values['s']!);
  }

  final int id;
  final int specificationId;
}

