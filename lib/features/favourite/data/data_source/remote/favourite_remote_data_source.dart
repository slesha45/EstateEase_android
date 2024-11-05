import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/contants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/favourite/data/dto/favourite_dto.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_prefs/user_shared_prefs.dart';

final favouriteRemoteDataSourceProvider = Provider<FavouriteRemoteDataSource>(
  (ref) => FavouriteRemoteDataSource(
    dio: ref.watch(httpServiceProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  ),
);

class FavouriteRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  FavouriteRemoteDataSource({required this.dio, required this.userSharedPrefs});

  Future<Either<Failure, List<FavouriteEntity>>> fetchFavourite() async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.get(ApiEndpoints.getUserFavorites,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        final favourite = FavouriteDto.fromJson(response.data).data;

        return Right(favourite.map((e) => e.toEntity()).toList());
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

//   add
  Future<Either<Failure, bool>> addFavourite(String propertyId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.post(ApiEndpoints.addFavorite,
          data: {'propertyId': propertyId},
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        final token = response.data['token'];
        await userSharedPrefs.setUserToken(token);
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

//   remove
  Future<Either<Failure, bool>> removeFavourite(String propertyId) async {
    try {
      String? token;
      final data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r,
      );
      Response response = await dio.delete(
          ApiEndpoints.deleteFavorite + propertyId,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return const Right(true);
      }
      return Left(
        Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString(),
        ),
      );
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }
}
