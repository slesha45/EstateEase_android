import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';


abstract class IFavouriteRepository {
  Future<Either<Failure, List<FavouriteEntity>>> fetchFavourite();

  Future<Either<Failure, bool>> addFavourite(String propertyId);

  Future<Either<Failure, bool>> removeFavourite(String propertyId);
}
