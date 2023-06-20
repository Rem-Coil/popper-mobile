import 'package:flutter/foundation.dart';
import 'package:popper_mobile/domain/models/specification/specification.dart';

@immutable
class ProductInfo {
  const ProductInfo({
    required this.id,
    required this.kitNumber,
    required this.batchNumber,
    required this.productNumber,
    required this.specification,
    required this.isActive,
  });

  const ProductInfo.unknown(
    this.id, {
    this.specification,
  })  : isActive = true,
        kitNumber = null,
        batchNumber = null,
        productNumber = null;

  final int id;
  final String? kitNumber;
  final int? batchNumber;
  final int? productNumber;
  final Specification? specification;
  final bool isActive;

  bool get isLoaded =>
      kitNumber != null && batchNumber != null && productNumber != null;

  String get number {
    if (!isLoaded) return 'Изделие id=$id';
    return '$kitNumber-$batchNumber/$productNumber';
  }
}
