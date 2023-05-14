import 'package:injectable/injectable.dart';
import 'package:popper_mobile/core/data/cache.dart';
import 'package:popper_mobile/data/models/specification/local_specification.dart';

const _specificationsBox = 'bobbins_box';

@singleton
class SpecificationsCache extends Cache<int, LocalSpecification> {
  const SpecificationsCache() : super(_specificationsBox);
}
