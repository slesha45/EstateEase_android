// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
// import 'package:final_assignment/features/booking/domain/usecases/booking_usecase.dart';
// import 'package:final_assignment/features/booking/presentation/state/booking_state.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
 
// final bookingViewModelProvider =
//     StateNotifierProvider<BookingViewModel, BookingState>(
//         (ref) => BookingViewModel(
//               bookingUseCase: ref.watch(bookingUsecaseProvider),
//             ));
 
// class BookingViewModel extends StateNotifier<BookingState> {
//   BookingViewModel({required this.bookingUseCase})
//       : super(BookingState.initial()) {
//     getBookings();
//   }
 
//   final BookingUsecase bookingUseCase;
 
//   /// Method to fetch the bookings and update the state
//   Future<void> getBookings() async {
//     state = state.copyWith(isLoading: true);
//     final currentState = state;
//     final page = currentState.page + 1;
//     final bookings = currentState.bookings;
//     final hasReachedMax = currentState.hasReachedMax;
 
//     if (!hasReachedMax) {
//       // Call the use case to fetch bookings
//       final result = await bookingUseCase.getBookings();
     
//       // Handle success or failure
//       result.fold(
//         (failure) {
//           state = state.copyWith(hasReachedMax: true, isLoading: false);
//         },
//         (data) {
//           if (data.isEmpty) {
//             state = state.copyWith(hasReachedMax: true);
//           } else {
//             state = state.copyWith(
//               bookings: [...bookings, ...data],
//               page: page,
//               isLoading: false,
//             );
//           }
//         },
//       );
//     }
//   }
 
//   /// Method to create a booking
//   Future<void> createBooking(BookingEntity booking) async {
//     state = state.copyWith(isLoading: true);
 
//     final result = await bookingUseCase.addBooking(booking);
 
//     result.fold(
//       (failure) {
//         // Handle failure case
//         state = state.copyWith(isLoading: false);
//         // Optionally, show an error message or perform other actions
//       },
//       (data) {
//         // Handle success case
//         // Optionally, update the state with the new booking or navigate away
//         state = state.copyWith(isLoading: false);
//         // Optionally, add the new booking to the existing bookings list
//         state = state.copyWith(bookings: [...state.bookings]);
//       },
//     );
//   }
// }
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:final_assignment/features/booking/domain/usecases/booking_usecase.dart';
import 'package:final_assignment/features/booking/presentation/state/booking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingViewmodelProvider =
    StateNotifierProvider<BookingViewmodel, BookingState>((ref) {
  final bookingUsecase = ref.watch(bookingUsecaseProvider);
  return BookingViewmodel(bookingUsecase: bookingUsecase);
});

class BookingViewmodel extends StateNotifier<BookingState> {
  final BookingUsecase bookingUsecase;

  BookingViewmodel({required this.bookingUsecase})
      : super(BookingState.initial());

  Future<void> addBooking(BookingEntity booking) async {
    state = state.copyWith(isLoading: true);
    final result = await bookingUsecase.addBooking(booking);
    result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
        );
        showMySnackBar(message: 'Booking added successfully');
      },
    );
  }
}
