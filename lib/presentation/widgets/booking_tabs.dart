import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/booking/booking_bloc.dart';
import '../bloc/booking/booking_event.dart';
import '../bloc/booking/booking_state.dart';


class BookingTabs extends StatelessWidget {
  final List<String> tabs;

  const BookingTabs({
    super.key,
    this.tabs = const ['Table Booking', 'Events', 'Carnival', 'My Invites'],
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        final selectedTab = state is BookingTabSelected
            ? state.selectedTab
            : 'Carnival';

        return SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: tabs.length,
            itemBuilder: (context, index) {
              final tab = tabs[index];
              final isSelected = tab == selectedTab;

              return Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: _buildTab(tab, isSelected, context),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTab(String tab, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<BookingBloc>().add(ChangeBookingTabEvent(tab));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            tab,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
