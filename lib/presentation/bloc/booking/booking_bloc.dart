import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import '../../../data/services/booking_service.dart';

/// BLoC for managing booking state
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingService _bookingService = BookingService();
  String _currentTab = 'Carnival';

  BookingBloc() : super(BookingTabSelected('Carnival')) {
    on<ChangeBookingTabEvent>(_onChangeTab);
    on<FetchBookingHistoryEvent>(_onFetchBookingHistory);
    
    // Trigger API call on initial load since default tab is 'Carnival'
    add(
      const FetchBookingHistoryEvent(
        userId: '14393',
        longitude: '77.0801664',
        latitude: '28.6294016',
        type: 'upcoming',
        sessionCookie: 'ci_session=r635a1dspb8t0mbodajeho1bjttliuv4',
      ),
    );
  }

  void _onChangeTab(ChangeBookingTabEvent event, Emitter<BookingState> emit) {
    _currentTab = event.tabName;
    emit(BookingTabSelected(event.tabName));
    
    // If Carnival tab is selected, fetch booking history
    if (event.tabName == 'Carnival') {
      // Trigger API call with default parameters
      // TODO: Replace with actual user location and ID from app state/storage
      add(
        const FetchBookingHistoryEvent(
          userId: '14393',
          longitude: '77.0801664',
          latitude: '28.6294016',
          type: 'upcoming',
          sessionCookie: 'ci_session=r635a1dspb8t0mbodajeho1bjttliuv4',
        ),
      );
    }
  }

  Future<void> _onFetchBookingHistory(
    FetchBookingHistoryEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingHistoryLoading(_currentTab));
    
    try {
      final response = await _bookingService.getBookingHistory(
        userId: event.userId,
        longitude: event.longitude,
        latitude: event.latitude,
        type: event.type,
        sessionCookie: event.sessionCookie,
      );

      if (response.status && response.data.isNotEmpty) {
        emit(BookingHistoryLoaded(
          selectedTab: _currentTab,
          bookings: response.data,
        ));
      } else {
        emit(BookingHistoryError(
          selectedTab: _currentTab,
          message: response.message.isEmpty ? 'No bookings found' : response.message,
        ));
      }
    } catch (e) {
      emit(BookingHistoryError(
        selectedTab: _currentTab,
        message: e.toString(),
      ));
    }
  }
}

