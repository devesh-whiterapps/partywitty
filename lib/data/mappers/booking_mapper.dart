import '../../domain/models/booking_history_model.dart';
import '../../domain/models/event_model.dart';
import '../../domain/models/artist_model.dart';
import '../../domain/models/ticket_model.dart';

/// Helper class to map API booking data to UI models
class BookingMapper {
  /// Convert BookingHistoryModel to EventModel for featured event
  static EventModel toFeaturedEventModel(BookingHistoryModel booking) {
    // Format date
    String formattedDate = _formatDate(booking.partyDate);

    // Format time
    String formattedTime = '${booking.startTime} - ${booking.endTime}';

    // Build image URL
    String imageUrl = booking.carnivalImg.isNotEmpty
        ? 'https://admin.partywitty.com/uploads/carnival/${booking.carnivalImg}'
        : '';

    return EventModel(
      id: booking.id,
      title: booking.carnivalName,
      venue: booking.clubName,
      location: booking.address.trim().replaceAll('\r\n', ' '),
      imageUrl: imageUrl,
      date: formattedDate,
      time: formattedTime,
      type: 'Carnival',
      rating: 4.1, // Default value, not in API
      reviewCount: 3, // Default value, not in API
      eventCategory: booking.categoryType,
      inclusions: _buildInclusions(booking.carnivalInfo),
      advancePaid: _calculateAdvancePaid(booking),
      balanceAmount: _calculateBalanceAmount(booking),
      distance: booking.distanceAsDouble,
    );
  }

  /// Convert BookingHistoryModel to EventModel for featured event, merging with defaults
  static EventModel toFeaturedEventModelWithDefaults(
    BookingHistoryModel booking,
    EventModel defaults,
  ) {
    // Format date - use API if available, otherwise default
    String formattedDate = booking.partyDate.isNotEmpty
        ? _formatDate(booking.partyDate)
        : defaults.date;

    // Format time - use API if available, otherwise default
    String formattedTime =
        (booking.startTime.isNotEmpty && booking.endTime.isNotEmpty)
        ? '${booking.startTime} - ${booking.endTime}'
        : defaults.time;

    // Build image URL - use API if available, otherwise default
    String imageUrl = booking.carnivalImg.isNotEmpty
        ? 'https://admin.partywitty.com/uploads/carnival/${booking.carnivalImg}'
        : defaults.imageUrl;

    return EventModel(
      id: booking.id.isNotEmpty ? booking.id : defaults.id,
      title: booking.carnivalName.isNotEmpty
          ? booking.carnivalName
          : defaults.title,
      venue: booking.clubName.isNotEmpty ? booking.clubName : defaults.venue,
      location: booking.address.trim().isNotEmpty
          ? booking.address.trim().replaceAll('\r\n', ' ')
          : defaults.location,
      imageUrl: imageUrl,
      date: formattedDate,
      time: formattedTime,
      type: defaults.type, // Keep default type
      rating: defaults.rating, // Keep default rating (not in API)
      reviewCount:
          defaults.reviewCount, // Keep default review count (not in API)
      eventCategory: booking.categoryType.isNotEmpty
          ? booking.categoryType
          : defaults.eventCategory,
      // Inclusions are not in API, so always use defaults
      inclusions: defaults.inclusions,
      // Advance paid is not in API, so use default
      // If you want to calculate from total_amount, uncomment the calculation below
      advancePaid: defaults.advancePaid,
      // balanceAmount: defaults.balanceAmount,
      // If you want to calculate balance from total_amount:
      balanceAmount: booking.totalAmountAsDouble > 0
          ? booking.totalAmountAsDouble - defaults.advancePaid
          : defaults.balanceAmount,
      distance: booking.distanceAsDouble > 0
          ? booking.distanceAsDouble
          : defaults.distance,
    );
  }

  /// Convert BookingHistoryModel to EventModel for event details
  static EventModel toEventDetailsModel(BookingHistoryModel booking) {
    String formattedDate = _formatDate(booking.partyDate);
    String formattedTime = '${booking.startTime} - ${booking.endTime}';

    String imageUrl = booking.carnivalImg.isNotEmpty
        ? 'https://admin.partywitty.com/uploads/carnival/${booking.carnivalImg}'
        : '';

    return EventModel(
      id: booking.id,
      title: booking.carnivalName,
      venue: booking.clubName,
      location: booking.address.trim().replaceAll('\r\n', ' '),
      imageUrl: imageUrl,
      date: formattedDate,
      time: formattedTime,
      type: 'Carnival',
      rating: 4.1,
      reviewCount: 3,
      eventCategory: booking.categoryType,
      inclusions: _buildInclusions(booking.carnivalInfo),
      advancePaid: _calculateAdvancePaid(booking),
      balanceAmount: _calculateBalanceAmount(booking),
      distance: booking.distanceAsDouble,
    );
  }

  /// Convert BookingHistoryModel to EventModel for event details, merging with defaults
  static EventModel toEventDetailsModelWithDefaults(
    BookingHistoryModel booking,
    EventModel defaults,
  ) {
    // Format date - use API if available, otherwise default
    String formattedDate = booking.partyDate.isNotEmpty
        ? _formatDate(booking.partyDate)
        : defaults.date;

    // Format time - use API if available, otherwise default
    String formattedTime =
        (booking.startTime.isNotEmpty && booking.endTime.isNotEmpty)
        ? '${booking.startTime} - ${booking.endTime}'
        : defaults.time;

    // Build image URL - use API if available, otherwise default
    String imageUrl = booking.carnivalImg.isNotEmpty
        ? 'https://admin.partywitty.com/uploads/carnival/${booking.carnivalImg}'
        : defaults.imageUrl;

    return EventModel(
      id: booking.id.isNotEmpty ? booking.id : defaults.id,
      title: booking.carnivalName.isNotEmpty
          ? booking.carnivalName
          : defaults.title,
      venue: booking.clubName.isNotEmpty ? booking.clubName : defaults.venue,
      location: booking.address.trim().isNotEmpty
          ? booking.address.trim().replaceAll('\r\n', ' ')
          : defaults.location,
      imageUrl: imageUrl,
      date: formattedDate,
      time: formattedTime,
      type: defaults.type, // Keep default type
      rating: defaults.rating, // Keep default rating (not in API)
      reviewCount:
          defaults.reviewCount, // Keep default review count (not in API)
      eventCategory: booking.categoryType.isNotEmpty
          ? booking.categoryType
          : defaults.eventCategory,
      // Inclusions are not in API, so always use defaults
      inclusions: defaults.inclusions,
      // Advance paid is not in API, so use default
      // If you want to calculate from total_amount, uncomment the calculation below
      advancePaid: defaults.advancePaid,
      // balanceAmount: defaults.balanceAmount,
      // If you want to calculate balance from total_amount:
      balanceAmount: booking.totalAmountAsDouble > 0
          ? booking.totalAmountAsDouble - defaults.advancePaid
          : defaults.balanceAmount,
      distance: booking.distanceAsDouble > 0
          ? booking.distanceAsDouble
          : defaults.distance,
    );
  }

  /// Create a default ArtistModel (not in API, using placeholder)
  static ArtistModel toArtistModel(BookingHistoryModel booking) {
    return ArtistModel(
      id: booking.id,
      name: 'Featured Artist', // Not in API
      imageUrl: '',
      role: 'Artist',
    );
  }

  /// Convert BookingHistoryModel to TicketModel list
  static List<TicketModel> toTicketModels(BookingHistoryModel booking) {
    List<TicketModel> tickets = [];
    final info = booking.carnivalInfo;

    // Couple tickets
    if (int.tryParse(info.coupleQty) != null && int.parse(info.coupleQty) > 0) {
      tickets.add(
        TicketModel(
          id: '${booking.id}_couple',
          title: 'Couple Pass',
          type: 'Couple',
          category: 'General',
          price: double.tryParse(info.coupleAmount) ?? 0.0,
          quantity: int.tryParse(info.coupleQty) ?? 0,
          inclusions: _buildInclusions(booking.carnivalInfo),
        ),
      );
    }

    // Male tickets
    if (int.tryParse(info.maleQty) != null && int.parse(info.maleQty) > 0) {
      tickets.add(
        TicketModel(
          id: '${booking.id}_male',
          title: 'Male Pass',
          type: 'Single',
          category: 'General',
          price: double.tryParse(info.maleAmount) ?? 0.0,
          quantity: int.tryParse(info.maleQty) ?? 0,
          inclusions: _buildInclusions(booking.carnivalInfo),
        ),
      );
    }

    // Female tickets
    if (int.tryParse(info.femaleQty) != null && int.parse(info.femaleQty) > 0) {
      tickets.add(
        TicketModel(
          id: '${booking.id}_female',
          title: 'Female Pass',
          type: 'Single',
          category: 'General',
          price: double.tryParse(info.femaleAmount) ?? 0.0,
          quantity: int.tryParse(info.femaleQty) ?? 0,
          inclusions: _buildInclusions(booking.carnivalInfo),
        ),
      );
    }

    return tickets;
  }

  /// Format date string
  static String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final bookingDate = DateTime(date.year, date.month, date.day);

      if (bookingDate == today) {
        return 'Today';
      } else if (bookingDate == today.add(const Duration(days: 1))) {
        return 'Tomorrow';
      } else {
        // Format as "DD MMM YYYY"
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        return '${date.day} ${months[date.month - 1]} ${date.year}';
      }
    } catch (e) {
      return dateStr;
    }
  }

  /// Build inclusions list from carnival info
  static List<String> _buildInclusions(CarnivalInfo info) {
    // Since API doesn't provide specific inclusions, we'll create generic ones
    // In a real app, this would come from the API
    return ['Food & Beverages', 'Entry Pass'];
  }

  /// Calculate advance paid (assuming 30% of total)
  static double _calculateAdvancePaid(BookingHistoryModel booking) {
    final total = booking.totalAmountAsDouble;
    // Assuming advance is 30% of total, adjust as needed
    return total * 0.3;
  }

  /// Calculate balance amount
  static double _calculateBalanceAmount(BookingHistoryModel booking) {
    final total = booking.totalAmountAsDouble;
    final advance = _calculateAdvancePaid(booking);
    return total - advance;
  }
}
