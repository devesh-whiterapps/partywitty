
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/model/feed_model.dart';


enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final List<FeedItem>? feedList;


  const HomeState({
    required this.status,
    this.error,
      this.feedList
  });

  factory HomeState.initial() =>  HomeState(
    status: HomeStatus.initial,
   
  );

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<FeedItem>? feedList
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      feedList: feedList ?? this.feedList
    );
  }

  @override
  List<Object?> get props => [status, error,feedList];
}
