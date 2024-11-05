import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/data_source/remote/property_remote_data_source.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:final_assignment/features/home/domain/repository/property_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyRemoteRepository = Provider<IPropertyRepository>((ref) {
  final propertyRemoteDataSource = ref.watch(propertyRemoteDataSourceProvider);
  return PropertyRemoteRepository(
      propertyRemoteDataSource: propertyRemoteDataSource);
});

class PropertyRemoteRepository implements IPropertyRepository {
  final PropertyRemoteDataSource propertyRemoteDataSource;

  PropertyRemoteRepository({required this.propertyRemoteDataSource});

  @override
  Future<Either<Failure, List<PropertyEntity>>> pagination(int page, int limit) {
    return propertyRemoteDataSource.pagination(page: page, limit: limit);
  }
  
    @override
  Future<Either<Failure, PropertyEntity>> getPropertyById(String id) {
    return propertyRemoteDataSource.getSingleProperty(id);
  }
  
}
