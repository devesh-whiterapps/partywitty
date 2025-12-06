import 'package:equatable/equatable.dart';

/// Events for Booking BLoC
abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

/// Event to change the selected tab
class ChangeBookingTabEvent extends BookingEvent {
  final String tabName;

  const ChangeBookingTabEvent(this.tabName);

  @override
  List<Object?> get props => [tabName];
}

