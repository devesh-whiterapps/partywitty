
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;
import 'package:video_player/video_player.dart';


enum ReelStatus { initial, loading, loaded, error }

class ReelState extends Equatable {
  final ReelStatus status;
  final String? error;
VideoPlayerController? controller;

   ReelState({
    required this.status,
    this.error,
    this.controller
  
  });

  factory ReelState.initial() =>  ReelState(
    status: ReelStatus.initial,
   
  );

  ReelState copyWith({
    ReelStatus? status,
    String? error,
    VideoPlayerController? controller
  }) {
    return ReelState(
      status: status ?? this.status,
      error: error ?? this.error,
      controller: controller?? this.controller
   
    );
  }

  @override
  List<Object?> get props => [status, error,controller];
}
