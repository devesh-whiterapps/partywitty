
import 'package:dartz/dartz.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';

import '../../core/error/failures.dart';

abstract class FeedRepository {
  Future<Either<Failure, HomeResponse>> getFeed();
}