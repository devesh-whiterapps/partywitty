import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';

/// BLoC for managing booking state
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingTabSelected('Carnival')) {
    on<ChangeBookingTabEvent>(_onChangeTab);
  }

  void _onChangeTab(ChangeBookingTabEvent event, Emitter<BookingState> emit) {
    emit(BookingTabSelected(event.tabName));
  }
}

