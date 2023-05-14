import 'package:flutter/foundation.dart';

@immutable
class Specification {
  const Specification({
    required this.id,
    required this.productType,
  });

  final int id;
  final String productType;
}