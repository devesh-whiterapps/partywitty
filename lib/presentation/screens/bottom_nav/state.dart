import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/bloc.dart';
import '../home/events.dart';
import '../home/view.dart';


enum BottomNavStatus { initial, loading, loaded, error }

class BottomNavState extends Equatable {
  final BottomNavStatus status;
  final String? error;
  final List<Widget>? screenList;
  final int? selectedIndex;

  const BottomNavState({
    required this.status,
    this.error,
    this.screenList,
    this.selectedIndex,
  });

  factory BottomNavState.initial() => BottomNavState(
    status: BottomNavStatus.initial,
    selectedIndex: 0,
    screenList: [
      BlocProvider(
        create: (_) => HomeBloc()..add(HomeInitEvent()),
        child: HomePage(),
      ),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
    ],
  );


  BottomNavState copyWith({
    BottomNavStatus? status,
    String? error,
    List<Widget>? screenList,
    int? selectedIndex,
  }) {
    return BottomNavState(
      status: status ?? this.status,
      error: error ?? this.error,
      screenList: screenList ?? this.screenList,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [status, error, selectedIndex, screenList];
}
