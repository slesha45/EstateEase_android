

import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';

class FavouriteState {
  final bool isLoading;
  final List<FavouriteEntity> favourite;
  final String? error;

  FavouriteState({
    required this.isLoading,
    required this.favourite,
    this.error,
  });

  factory FavouriteState.initial() => FavouriteState(
        isLoading: false,
        favourite: [],
        error: null,
      );

  FavouriteState copyWith({
    bool? isLoading,
    List<FavouriteEntity>? favourite,
    String? error,
  }) {
    return FavouriteState(
      isLoading: isLoading ?? this.isLoading,
      favourite: favourite ?? this.favourite,
      error: error ?? this.error,
    );
  }
}
