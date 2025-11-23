
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;


enum PostCardStatus { initial, loading, loaded, error }

class PostCardState extends Equatable {
  final PostCardStatus status;
  final String? error;


  const PostCardState({
    required this.status,
    this.error,
  
  });

  factory PostCardState.initial() =>  PostCardState(
    status: PostCardStatus.initial,
   
  );

  PostCardState copyWith({
    PostCardStatus? status,
    String? error,
    
  }) {
    return PostCardState(
      status: status ?? this.status,
      error: error ?? this.error,
   
    );
  }

  @override
  List<Object?> get props => [status, error];
}
