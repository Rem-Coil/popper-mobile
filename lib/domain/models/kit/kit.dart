class Kit {
  const Kit({
    required this.id,
    required this.number,
    required this.acceptancePercentage,
    required this.batchesQuantity,
    required this.batchesSize,
    required this.specificationId,
  });

  final int id;
  final String number;
  final int acceptancePercentage;
  final int batchesQuantity;
  final int batchesSize;
  final int specificationId;
}
