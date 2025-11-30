import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:partywitty/core/error/failures.dart';
import 'package:partywitty/data/data_sources/feed_data_resource.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/domain/repositories/feed_repository_impl.dart';


import 'events.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitEvent>(_onInit);
 
}

  Future<void> _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      // final dataSource = FeedRemoteDataSourceImpl(dio: Dio());
      // final repository = FeedRepositoryImpl(remoteDataSource: dataSource);
      // final result = await repository.getFeed();
      // result.fold(
      // (failure) => print(failure.message),
      // (data) => emit(state.copyWith(feedList: data.data)),
    // );

    late final _pagingController = PagingController<int, HomeItemModel>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => _fetchPage(pageKey));
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
         paginationController: _pagingController
        ),
      );
      
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}


  Future<List<HomeItemModel>> _fetchPage(int pageKey) async {
     return Isolate.run(() async {
        final dataSource = FeedRemoteDataSourceImpl(dio: Dio());
      final repository = FeedRepositoryImpl(remoteDataSource: dataSource);
      final result = await repository.getFeed(page: pageKey);
      return result.fold(
      (failure) => [],
      (data) => data.data!,
    );
      });
      
        

    // final Uri url = Uri.parse(ApiConstants.BASE_URL).replace(queryParameters: {
    //   "apiKey": "b4ee8644b3f845cc94e93bf9b6db1d62",
    //   "q": "$searchQuery",
    //   "page": pageKey.toString(),
    //   "pageSize": "10",
    // });

    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = json.decode(response.body);
    //   final newsData = NewsListModel.fromJson(data);
    //   int totalPages = (newsData.totalResults ?? 0 / 10).ceil();
    //   final isLastPage = totalPages < 10;

    //   if (isLastPage) {
    //     state.newsListPaginationController!
    //         .appendLastPage(newsData.articles ?? []);
    //   } else {
    //     final nextPageKey = pageKey + 1;
    //     state.newsListPaginationController!
    //         .appendPage(newsData.articles ?? [], nextPageKey);
    //   }
    // } else {
    //   state.newsListPaginationController!.error =
    //       Exception(json.decode(response.body)["message"]);
    //   throw Exception('Failed to load news ${response.body}');
    // }
  }
