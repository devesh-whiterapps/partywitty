import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/repository/feed_repository.dart';


import 'events.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitEvent>(_onInit);
 
}

  Future<void> _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
         feedList: sampleFeed
        ),
      );
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}
