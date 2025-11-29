// data/repositories/feed_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/domain/repositories/feed_repository.dart';

import '../../core/error/failures.dart';
import '../../data/data_sources/feed_data_resource.dart';


class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, HomeResponse>> getFeed({
    String lat =  "28.6490624",
    String long = "77.103104",
    int limit = 10,
    required int page
  }) async {
    try {
      final result = await remoteDataSource.getFeed(lat: lat,long: long,limit: limit,page: page);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure("Server Error"));
    }
  }
}