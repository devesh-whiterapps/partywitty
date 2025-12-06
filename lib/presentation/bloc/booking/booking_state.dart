import 'package:equatable/equatable.dart';

/// States for Booking BLoC
abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class BookingInitial extends BookingState {}

/// State with selected tab
class BookingTabSelected extends BookingState {
  final String selectedTab;

  const BookingTabSelected(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}

