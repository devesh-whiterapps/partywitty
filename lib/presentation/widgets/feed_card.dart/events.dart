import 'package:flutter/widgets.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';

abstract class FeedCardEvent {}

class SetDataTypeEvent extends FeedCardEvent {
  String type;
  EventModel? eventItem;
  PackageModel? packageItem;
  TeaserModel? teaserItem;
  GalleryModel? galleryItem;
  SetDataTypeEvent({
    required this.type,
    this.eventItem,
    this.galleryItem,
    this.packageItem,
    this.teaserItem,
  });
}

class onItemTappedEvent extends FeedCardEvent {
  int selectedIndex;
  onItemTappedEvent({required this.selectedIndex});
}

class FeedCardInitEvent extends FeedCardEvent {}
