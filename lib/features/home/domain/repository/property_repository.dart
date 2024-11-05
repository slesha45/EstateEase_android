import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/repository/property_remote_repository.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyRepositoryProvider = Provider<IPropertyRepository>((ref)=>
  ref.read (propertyRemoteRepository));

abstract class IPropertyRepository {
  Future<Either<Failure,List<PropertyEntity>>> pagination(int page, int limit);
  Future<Either<Failure, PropertyEntity>> getPropertyById(String id);
}