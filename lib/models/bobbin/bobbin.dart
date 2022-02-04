import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bobbin_remote.dart';
part 'bobbin.g.dart';


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
