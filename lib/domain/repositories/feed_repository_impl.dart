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
  Future<Either<Failure, HomeResponse>> getFeed() async {
    try {
      final result = await remoteDataSource.getFeed();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure("Server Error"));
    }
  }
}