// data/datasources/feed_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:partywitty/core/const/api_const.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import '../../core/error/failures.dart';


abstract class FeedRemoteDataSource {
  Future<HomeResponse> getFeed({
    String lat =  "28.6490624",
    String long = "77.103104",
    int limit = 10,
    required int page
  });
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio dio;

  FeedRemoteDataSourceImpl({required this.dio});

  @override
  Future<HomeResponse> getFeed({
    String lat =  "28.6490624",
    String long = "77.103104",
    int limit = 10,
    required int page
  }) async {
    try {
      final response = await dio.post('${ApiConst.baseUrl}${ApiConst.homeFeed}',data: {  "latitude" : "28.6490624",
"limit" : 10,
"longitude" : "77.103104",
"page" : 1});
        // print(response.data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        // final List<dynamic> rawList = response.data['data'];
        final home = HomeResponse.fromJson(response.data);
        // Map raw JSON items to specific domain entities via the Model factory
        // final feedList =   rawList
        //     .map((item) => FeedItemModel.fromJson(item))
        //     .toList();

            // return feedList;
            return home;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      throw ServerException();
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }
}