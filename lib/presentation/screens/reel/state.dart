
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;
import 'package:video_player/video_player.dart';


enum ReelStatus { initial, loading, loaded, error }

class ReelState extends Equatable {
  final ReelStatus status;
  final String? error;
  final String? title;
  final String? subTitle;
  final String? clubLogo;
  final String? since;
  final int? disc;
  final int? id;

VideoPlayerController? controller;

   ReelState({
    required this.status,
    this.error,
    this.controller,
    this.clubLogo,
    this.id,
    this.disc,
    this.since,
    this.subTitle,
    this.title
  
  });

  factory ReelState.initial() =>  ReelState(
    status: ReelStatus.initial,
   
  );

  ReelState copyWith({
    ReelStatus? status,
    String? error,
    VideoPlayerController? controller,
       String? title,
   String? subTitle,
   String? clubLogo,
   String? since,
   int? disc,
   int? id,
  }) {
    return ReelState(
      status: status ?? this.status,
      error: error ?? this.error,
      controller: controller?? this.controller,
      id: id?? this.id,
      title: title?? this.title,
      subTitle: subTitle?? this.subTitle,
      clubLogo: clubLogo?? this.clubLogo,
      disc: disc?? this.disc,
      since: since?? this.since,
    );
  }

  @override
  List<Object?> get props => [status, error,controller,disc,since,title,subTitle,id];
}
