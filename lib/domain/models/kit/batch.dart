class Batch {
  const Batch({
    required this.id,
    required this.number,
    required this.kitId,
  });

  final int id;
  final int number;
  final int kitId;

  @override
  bool operator ==(Object other) {
    if (other is! Batch){
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => id;

}
