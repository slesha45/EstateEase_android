import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourite/data/data_source/remote/favourite_remote_data_source.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
import 'package:final_assignment/features/favourite/domain/repository/i_favourite_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favouriteRepositoryProvider = Provider<IFavouriteRepository>((ref) {
  return FavouriteRepository(ref.watch(favouriteRemoteDataSourceProvider));
});

class FavouriteRepository implements IFavouriteRepository {
  final FavouriteRemoteDataSource remoteDataSource;

  FavouriteRepository(this.remoteDataSource);

  @override
  Future<Either<Failure, List<FavouriteEntity>>> fetchFavourite() {
    return remoteDataSource.fetchFavourite();
  }

  @override
  Future<Either<Failure, bool>> addFavourite(String propertyId) {
    return remoteDataSource.addFavourite(propertyId);
  }

  @override
  Future<Either<Failure, bool>> removeFavourite(String propertyId) {
    return remoteDataSource.removeFavourite(propertyId);
  }


}
