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

/// State when booking history is loading
class BookingHistoryLoading extends BookingState {
  final String selectedTab;

  const BookingHistoryLoading(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}

/// State when booking history is loaded
class BookingHistoryLoaded extends BookingState {
  final String selectedTab;
  final List<dynamic> bookings; // List of BookingHistoryModel

  const BookingHistoryLoaded({
    required this.selectedTab,
    required this.bookings,
  });

  @override
  List<Object?> get props => [selectedTab, bookings];
}

/// State when booking history fetch fails
class BookingHistoryError extends BookingState {
  final String selectedTab;
  final String message;

  const BookingHistoryError({
    required this.selectedTab,
    required this.message,
  });

  @override
  List<Object?> get props => [selectedTab, message];
}

