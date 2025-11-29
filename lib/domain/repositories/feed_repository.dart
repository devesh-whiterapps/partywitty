
import 'package:dartz/dartz.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';

import '../../core/error/failures.dart';

abstract class FeedRepository {
  Future<Either<Failure, HomeResponse>> getFeed({
    String lat =  "28.6490624",
    String long = "77.103104",
    int limit = 10,
    required int page
  });
}