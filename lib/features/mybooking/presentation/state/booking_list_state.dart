import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';

class BookingListState {
  final String? error;
  final bool isLoading;
  final List<BookingEntity> bookings;

  BookingListState(
      {required this.error,
      required this.isLoading,
      required this.bookings});

  factory BookingListState.initial() {
    return BookingListState(
      error: null,
      isLoading: false,
      bookings: [],
    );
  }

  BookingListState copyWith({
    String? error,
    bool? isLoading,
    List<BookingEntity>? bookings,
  }) {
    return BookingListState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      bookings: bookings ?? this.bookings,
    );
  }
}
