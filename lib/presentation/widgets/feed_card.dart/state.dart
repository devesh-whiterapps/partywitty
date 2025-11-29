import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';




enum FeedCardStatus { initial, loading, loaded, error }

class FeedCardState extends Equatable {
  final FeedCardStatus status;
  final String? error;
  final EventModel? eventItem;
  final List<PackageModel>? packageItem;
  final TeaserModel? teaserItem;
  final GalleryModel? galleryItem;
  final String? type;

  const FeedCardState({
    required this.status,
    this.error,
    this.eventItem,
    this.galleryItem,
    this.packageItem,
    this.teaserItem,
    this.type
  });

  factory FeedCardState.initial({required HomeItemModel item}) => FeedCardState(
    status: FeedCardStatus.initial,
  );


  FeedCardState copyWith({
    FeedCardStatus? status,
    String? error,
    
     EventModel? eventItem,
   List<PackageModel>? packageItem,
   TeaserModel? teaserItem,
   GalleryModel? galleryItem,
   String? type
  }) {
    return FeedCardState(
      status: status ?? this.status,
      error: error ?? this.error,
       eventItem: eventItem ?? this.eventItem,
       packageItem: packageItem ?? this.packageItem,
       teaserItem: teaserItem??this.teaserItem,
       galleryItem: galleryItem??this.galleryItem,
        type: type??this.type
    );
  }

  @override
  List<Object?> get props => [status, error, eventItem, galleryItem,packageItem,teaserItem,type];
}
