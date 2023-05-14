import 'package:flutter/foundation.dart';

@immutable
class Specification {
  const Specification({
    required this.id,
    required this.productType,
  });

  const Specification.unknown({
    required this.id,
  }) : productType = 'Неизвестно';

  final int id;
  final String productType;
}
