import 'package:popper_mobile/domain/models/kit/batch.dart';

class FullKitInfo {
  FullKitInfo({
    required this.kitId,
    required this.kitName,
    required this.batches,
  });

  final int kitId;
  final String kitName;
  final List<Batch> batches;
}
