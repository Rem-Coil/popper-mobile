import 'package:flutter/foundation.dart';

@immutable
class OperationType {
  const OperationType(this.id, this.name);

  final int id;
  final String name;
}
