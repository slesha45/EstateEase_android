// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';

// class BookingState {
//   final List<BookingEntity> bookings;
//   final bool hasReachedMax;
//   final int page;
//   final bool isLoading;
 
//   BookingState({
//     required this.bookings,
//     required this.hasReachedMax,
//     required this.page,
//     required this.isLoading,
//   });
 
//   factory BookingState.initial () {
//     return BookingState(
//       bookings: [],
//       hasReachedMax: false,
//       page: 0,
//       isLoading: false,
//     );
//   }
 
//   BookingState copyWith({
//     List<BookingEntity>? bookings,
//     bool? hasReachedMax,
//     int? page,
//     bool? isLoading,
//   }) {
//     return BookingState(
//       bookings: bookings ?? this.bookings,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       page: page ?? this.page,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }

class BookingState {
  final String? error;
  final bool isLoading;

  BookingState({required this.error, required this.isLoading});

  factory BookingState.initial() {
    return BookingState(
      error: null,
      isLoading: false,
    );
  }

  BookingState copyWith({
    String? error,
    bool? isLoading,
  }) {
    return BookingState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
