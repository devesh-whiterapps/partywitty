import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';

import 'events.dart';
import 'state.dart';

class FeedCardBloc extends Bloc<FeedCardEvent, FeedCardState> {
  FeedCardBloc({required HomeItemModel item}) : super(FeedCardState.initial(item:item )) {
     on<FeedCardInitEvent>(_onInit);
    on<SetDataTypeEvent>(_onSetDataType);
     switch(item.type){
                                  case 'event':
                                  print("Listener Excuted");
                                  add(SetDataTypeEvent(type: item.type??'',eventItem: item.data as EventModel));
                                  case 'package':
                                 add(SetDataTypeEvent(type: item.type??'',packageItem: item.data as List<PackageModel>));
                                  case 'gallery':
                                  add(SetDataTypeEvent(type: item.type??'',galleryItem: item.data as GalleryModel));
                                  case 'teaser':
                                  add(SetDataTypeEvent(type: item.type??'',teaserItem: item.data as TeaserModel));
                                  default:
                                  
                              }

   
  }

  Future<void> _onSetDataType(
    SetDataTypeEvent event,
    Emitter<FeedCardState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          type: event.type,
          eventItem: event.eventItem,
          teaserItem: event.teaserItem,
          packageItem: event.packageItem,
          galleryItem: event.galleryItem,
          status: .loaded
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: FeedCardStatus.error, error: e.toString()));
    }
  }

  Future<void> _onInit(
    FeedCardInitEvent event,
    Emitter<FeedCardState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FeedCardStatus.loading));
      // Iniatial task here
      emit(state.copyWith(status: FeedCardStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: FeedCardStatus.error, error: e.toString()));
    }
  }
}
