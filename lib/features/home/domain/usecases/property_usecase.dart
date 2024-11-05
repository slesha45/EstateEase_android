import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:final_assignment/features/home/domain/repository/property_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyUsecaseProvider = Provider<PropertyUsecase>((ref) {
  final propertyRepository = ref.watch(propertyRepositoryProvider);
  return PropertyUsecase(propertyRepository: propertyRepository);
});

class PropertyUsecase {
  final IPropertyRepository propertyRepository;

  PropertyUsecase({required this.propertyRepository});

  Future<Either<Failure, List<PropertyEntity>>> pagination(int? page, int? limit)  {
    return propertyRepository.pagination(page??1, limit??6);
  }

  // get single product
  Future<Either<Failure, PropertyEntity>> getPropertyById(String id) {
    return propertyRepository.getPropertyById(id);
  }
}
