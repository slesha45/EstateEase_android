// import 'package:dartz/dartz.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/features/booking/data/data_source/remote/booking_remote_data_source.dart';
// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
// import 'package:final_assignment/features/booking/domain/repository/booking_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
 
// final bookingRemoteRepository = Provider<IBookingRepository>((ref) {
//   final bookingRemoteDataSource = ref.watch(bookingRemoteDataSourceProvider);
//   return BookingRemoteRepository(bookingRemoteDataSource: bookingRemoteDataSource);
// });
 
// class BookingRemoteRepository implements IBookingRepository {
//   final BookingRemoteDataSource bookingRemoteDataSource;
 
//   BookingRemoteRepository({required this.bookingRemoteDataSource});
 
//   @override
//   Future<Either<Failure, BookingEntity>> createBooking(BookingEntity booking) {
//     return bookingRemoteDataSource.createBooking(booking);
//   }

//   @override
//   Future<Either<Failure, List<BookingEntity>>> getUserBookings(int page, int limit) {
//     return bookingRemoteDataSource.getUserBookings();
//   }
//   // Add other methods as needed
// }
import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/booking/data/data_source/remote/booking_remote_data_source.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:final_assignment/features/booking/domain/repository/booking_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteRepositoryProvider =
    Provider<BookingRepository>((ref) {
  return BookingRemoteRepository(
      remoteDataSource: ref.watch(bookingRemoteDataSourceProvider));
});

class BookingRemoteRepository implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> createBooking(
      BookingEntity booking) {
    return remoteDataSource.createBooking(booking);
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() {
    return remoteDataSource.fetchBookings();
  }
}
