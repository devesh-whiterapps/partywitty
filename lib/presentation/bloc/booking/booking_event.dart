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

/// Event to fetch booking history
class FetchBookingHistoryEvent extends BookingEvent {
  final String userId;
  final String longitude;
  final String latitude;
  final String type; // 'upcoming' or 'past'
  final String? sessionCookie;

  const FetchBookingHistoryEvent({
    required this.userId,
    required this.longitude,
    required this.latitude,
    required this.type,
    this.sessionCookie,
  });

  @override
  List<Object?> get props => [userId, longitude, latitude, type, sessionCookie];
}

