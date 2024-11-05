import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/favourite/data/repository/favourite_repository.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
import 'package:final_assignment/features/favourite/domain/repository/i_favourite_repository.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchFavouriteUseCaseProvider = Provider<FavouriteUseCase>((ref) {
  return FavouriteUseCase(ref.watch(favouriteRepositoryProvider));
});

class FavouriteUseCase {
  final IFavouriteRepository repository;

  FavouriteUseCase(this.repository);

  Future<Either<Failure, List<FavouriteEntity>>> call() {
    return repository.fetchFavourite();
  }

  Future<Either<Failure, bool>> addFavourite(String propertyId) {
    return repository.addFavourite(propertyId);
  }

  Future<Either<Failure, bool>> removeFavourite(String propertyId) {
    return repository.removeFavourite(propertyId);
  }
}
