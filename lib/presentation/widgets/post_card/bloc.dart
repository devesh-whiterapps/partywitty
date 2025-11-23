import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'events.dart';
import 'state.dart';

class PostCardBloc extends Bloc<PostCardEvent, PostCardState> {
  PostCardBloc() : super(PostCardState.initial()) {
    on<PostCardInitEvent>(_onInit);
 
}

  Future<void> _onInit(PostCardInitEvent event, Emitter<PostCardState> emit) async {
    try {
      emit(state.copyWith(status: PostCardStatus.loading));

    

      emit(
        state.copyWith(
          status: PostCardStatus.loaded,
         
        ),
      );
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: PostCardStatus.error, error: e.toString()));
    }
  }
}
