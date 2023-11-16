import 'package:flutter/foundation.dart';

@immutable
class ActionType {
  const ActionType(this.id, this.name);

  final int id;
  final String name;
}
