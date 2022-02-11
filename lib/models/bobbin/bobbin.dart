import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bobbin.g.dart';

part 'bobbin_remote.dart';

@immutable
class Bobbin {
  final int id;
  final int taskId;
  final String bobbinNumber;

  Bobbin({
    required this.id,
    required this.taskId,
    required this.bobbinNumber,
  });
}

class NotLoadedBobbin implements Bobbin {
  @override
  final int id;

  @override
  int get taskId => throw UnimplementedError();

  @override
  String get bobbinNumber => throw UnimplementedError();

  const NotLoadedBobbin(this.id);
}
