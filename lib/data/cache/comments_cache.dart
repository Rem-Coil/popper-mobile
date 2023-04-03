import 'package:injectable/injectable.dart';
import 'package:popper_mobile/data/cache/core/cache.dart';
import 'package:popper_mobile/data/models/comment/local_comment.dart';

const _commentsBox = 'comments';

@singleton
class CommentsCache extends Cache<String, LocalComment> {
  const CommentsCache() : super(_commentsBox);
}
