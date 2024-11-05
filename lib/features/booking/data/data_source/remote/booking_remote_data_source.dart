// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:final_assignment/app/contants/api_endpoint.dart';
// import 'package:final_assignment/core/failure/failure.dart';
// import 'package:final_assignment/core/networking/remote/http_service.dart';
// import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
// import 'package:final_assignment/features/booking/data/model/booking_api_model.dart';
// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// //provider
// final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>(
//   (ref) => BookingRemoteDataSource(
//     dio: ref.read(httpServiceProvider),
//     userSharedPrefs: ref.read(userSharedPrefsProvider),
//   ),

// );
// class BookingRemoteDataSource {
//   final Dio dio;
//   final UserSharedPrefs userSharedPrefs;

//   BookingRemoteDataSource({
//     required this.dio,
//     required this.userSharedPrefs,
//   });

//   Future<Either<Failure, BookingEntity>> createBooking(BookingEntity booking) async {
//     try {
//       final token = await userSharedPrefs.getUserToken();
//       token.fold((l) => throw Failure(error: l.error), (r) => r);

//       // Use the static fromEntity method
//       final response = await dio.post(
//         ApiEndpoints.baseUrl + ApiEndpoints.createBooking,
//         data: BookingApiModel.fromEntity(booking).toJson(),
//         options: Options(
//           headers: {
//             'authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 201) {
//         // Use the factory method fromJson to parse the response
//         return Right(BookingApiModel.fromJson(response.data).toEntity());
//       }
//       return Left(Failure(error: response.data['message']));
//     } on DioException catch (e) {
//       return Left(Failure(error: e.error.toString()));
//     }
//   }

//   Future<Either<Failure, List<BookingEntity>>> getUserBookings() async {
//     try {
//       final token = await userSharedPrefs.getUserToken();
//       token.fold((l) => throw Failure(error: l.error), (r) => r);

//       final response = await dio.get(
//         ApiEndpoints.baseUrl + ApiEndpoints.getUserBookings,
//         options: Options(
//           headers: {
//             'authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final bookings = (response.data as List)
//             .map((booking) => BookingApiModel.fromJson(booking).toEntity())
//             .toList();
//         return Right(bookings);
//       }
//       return Left(Failure(error: response.data['message']));
//     } on DioException catch (e) {
//       return Left(Failure(error: e.error.toString()));
//     }
//   }

//   // Implement other methods for updating booking status, updating payment method, etc.
// }
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/contants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/booking/data/dto/get_booking_dto.dart';
import 'package:final_assignment/features/booking/data/model/booking_api_model.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingRemoteDataSourceProvider =
    Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSource(
      ref.watch(httpServiceProvider), ref.watch(userSharedPrefsProvider));
});

class BookingRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPreferences;

  BookingRemoteDataSource(this.dio, this.userSharedPreferences);

  Future<Either<Failure, bool>> createBooking(BookingEntity booking) async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);
      print('test');
      print("token: $token");
      print(booking);
      print(BookingApiModel.fromEntity(booking).toJson());
      final response = await dio.post(
        ApiEndpoints.createBooking,
        data: BookingApiModel.fromEntity(booking).toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        throw Exception('Error creating booking');
      }
    } catch (e) {
      return Left(Failure(error: 'Error creating booking: $e'));
    }
  }

  Future<Either<Failure, List<BookingEntity>>> fetchBookings() async {
    try {
      String? token;
      final data = await userSharedPreferences.getUserToken();

      data.fold((l) => token = null, (r) => token = r);

      final response = await dio.get(
        ApiEndpoints.getUserBookings,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final bookingDto = GetBookingDto.fromJson(response.data);
        return Right(BookingApiModel.toEntities(bookingDto.data));
      } else {
        throw Exception('Error fetching user bookings');
      }
    } catch (e) {
      throw Exception('Error fetching user bookings: $e');
    }
  }
}
