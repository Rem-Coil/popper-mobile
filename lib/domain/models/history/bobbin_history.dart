import 'package:popper_mobile/domain/models/bobbin/bobbin.dart';
import 'package:popper_mobile/domain/models/operation/operation.dart';

class BobbinHistory {
  const BobbinHistory({required this.bobbin, required this.operations});

  final Bobbin bobbin;
  final List<Operation> operations;
}
