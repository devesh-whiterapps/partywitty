import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/data/data_sources/feed_data_resource.dart';
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
      final dataSource = FeedRemoteDataSourceImpl(dio: Dio());
      final repository = FeedRepositoryImpl(remoteDataSource: dataSource);
      final result = await repository.getFeed();
      result.fold(
      (failure) => print(failure.message),
      (data) => emit(state.copyWith(feedList: data.data)),
    );
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
        //  feedList: sampleFeed
        ),
      );
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}
