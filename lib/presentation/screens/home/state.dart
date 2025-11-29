
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/model/feed_model.dart';


enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final List<HomeItemModel>? feedList;
  PagingController<int, HomeItemModel>? paginationController;


   HomeState({
    required this.status,
    this.error,
      this.feedList,
      this.paginationController
  });

  factory HomeState.initial() =>  HomeState(
    status: HomeStatus.initial,
    
  );

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<HomeItemModel>? feedList,
    PagingController<int, HomeItemModel>? paginationController
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      feedList: feedList ?? this.feedList,
      paginationController: paginationController??this.paginationController
    );
  }

  @override
  List<Object?> get props => [status, error,feedList,paginationController];
}
