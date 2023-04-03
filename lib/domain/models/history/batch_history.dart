import 'package:popper_mobile/domain/models/batch/batch.dart';
import 'package:popper_mobile/domain/models/history/bobbin_history.dart';
import 'package:popper_mobile/domain/models/history/history.dart';

class BatchHistory implements History {
  const BatchHistory({required this.batch, required this.bobbins});

  final Batch batch;
  final List<BobbinHistory> bobbins;

  @override
  String get number => batch.number;
}
