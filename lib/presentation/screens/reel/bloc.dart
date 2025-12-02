import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';


import 'events.dart';
import 'state.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  ReelBloc({required String title,required String subtitle,required String since,required String clubLogo,required int id,required int disc}) : super(ReelState.initial()) {
    on<ReelInitEvent>(_onInit);
    emit(state.copyWith(
      clubLogo: clubLogo,
      since: since,
      subTitle: subtitle,
      disc: disc,
      id: id,
      title: title
    ));
 
}

  Future<void> _onInit(ReelInitEvent event, Emitter<ReelState> emit) async {
    try {
      emit(state.copyWith(status: ReelStatus.loading));

    // VideoPlayerController controller = await VideoPlayerController.networkUrl(
    //     Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //     ),
    //   );
      
      // await controller.initialize();
      // controller.setLooping(true);
      emit(
        state.copyWith(
          status: ReelStatus.loaded,
          // controller: controller
        ),
      );
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: ReelStatus.error, error: e.toString()));
    }
  }
}
