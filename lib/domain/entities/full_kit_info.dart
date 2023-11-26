import 'package:popper_mobile/domain/models/kit/batch.dart';
import 'package:popper_mobile/domain/models/kit/kit.dart';

class FullKitInfo {
  FullKitInfo({
    required this.kit,
    required this.batches,
  });

  final Kit kit;
  final List<Batch> batches;
}
