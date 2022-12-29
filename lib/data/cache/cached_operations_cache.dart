import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/operation/cached_operation.dart';

const _cachedOperationsBox = 'cached_operations';

@singleton
class CachedOperationsCache extends Cache<String, CachedOperation> {
  const CachedOperationsCache() : super(_cachedOperationsBox);
}
