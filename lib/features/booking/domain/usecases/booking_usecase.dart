// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
// import 'package:final_assignment/features/booking/domain/repository/booking_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
 
// final bookingUsecaseProvider = Provider<BookingUseCase>((ref) {

//   final bookingRepository = ref.watch(bookingRepositoryProvider);

//   return BookingUseCase(bookingRepository: bookingRepository);

// });
 
// class BookingUseCase {
//   final IBookingRepository bookingRepository;
//    BookingUseCase({required this.bookingRepository});
 
//   Future<Either<Failure, BookingEntity>> createBooking(BookingEntity booking) {
//     return bookingRepository.createBooking(booking);
//   }

//   Future<Either<Failure, List<BookingEntity>>> getBookings(int? page, int? limit) {
//     return bookingRepository.getUserBookings(page ?? 1, limit ?? 10);
//   }

//   // Add other use cases as needed, like getAllBookings, getUserBookings, etc.

// }

 import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:final_assignment/features/booking/domain/repository/booking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingUsecaseProvider = Provider<BookingUsecase>((ref) {
  return BookingUsecase(ref.watch(bookingRepositoryProvider));
});

class BookingUsecase {
  final BookingRepository repository;

  BookingUsecase(this.repository);

  Future<Either<Failure, bool>> addBooking(BookingEntity booking) {
    return repository.createBooking(booking);
  }

  Future<Either<Failure, List<BookingEntity>>> getBookings() {
    return repository.getBookings();
  }

}
