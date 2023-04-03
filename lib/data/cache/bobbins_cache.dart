import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/scanned_entity/local_bobbin.dart';

const _bobbinsBox = 'bobbins_box';

@singleton
class BobbinsCache extends Cache<int, LocalBobbin> {
  const BobbinsCache() : super(_bobbinsBox);
}