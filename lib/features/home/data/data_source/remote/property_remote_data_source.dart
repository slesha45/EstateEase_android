import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/contants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';



import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/data/dto/pagination_dto.dart';
import 'package:final_assignment/features/home/data/model/property_api_model.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';



final propertyRemoteDataSourceProvider = Provider<PropertyRemoteDataSource>((ref) {
  final dio = ref.watch(httpServiceProvider);
  final propertyApiModel = ref.watch(propertyApiModelProvider);
  final userSharedPrefs = ref.watch(userSharedPrefsProvider);
  return PropertyRemoteDataSource(
    dio: dio,
    propertyApiModel: propertyApiModel,
    userSharedPrefs: userSharedPrefs,
  );
});

class PropertyRemoteDataSource {
  final Dio dio;
  final PropertyApiModel propertyApiModel;
  final UserSharedPrefs userSharedPrefs;

  PropertyRemoteDataSource({
    required this.dio,
    required this.propertyApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, List<PropertyEntity>>> pagination(
      {required int page, required int limit}) async {
    try {
      final token = await userSharedPrefs.getUserToken();
      token.fold((l) => throw Failure(error: l.error), (r) => r);
      final response = await dio.get(
        ApiEndpoints.paginationProperty,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final paginationDto = PaginationDto.fromJson(response.data);
        return Right(propertyApiModel.toEntityList(paginationDto.property));
      }
      return Left(Failure(
          error: response.data['message'],
          statusCode: response.statusCode.toString()));
    } on DioException catch (e) {
      return Left(Failure(error: e.error.toString()));
    }
  }

   Future<Either<Failure, PropertyEntity>> getSingleProperty(
      String propertyId) async {
    try {
      final tokenResult = await userSharedPrefs.getUserToken();
      final token = tokenResult.fold(
        (failure) => null,
        (token) => token,
      );
 
      if (token == null) {
        return Left(Failure(error: 'Invalid token'));
      }
 
      final response = await dio.get(
        '${ApiEndpoints.getSingleProperty}/$propertyId',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );
 
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
 
      if (response.statusCode == 200) {
        final property = PropertyApiModel.fromJson(response.data['property']);
        return Right(property.toEntity());
      }
 
      return Left(Failure(
        error: response.data['message'] ?? 'Unexpected error',
        statusCode: response.statusCode.toString(),
      ));
    } on DioException catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
