
import 'package:final_assignment/features/favourite/domain/usecases/favourite_usecase.dart';
import 'package:final_assignment/features/favourite/presentation/state/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/common/show_my_snackbar.dart';

final favouriteViewModelProvider =
    StateNotifierProvider<FavouriteViewModel, FavouriteState>((ref) {
  return FavouriteViewModel(ref.watch(fetchFavouriteUseCaseProvider));
});

class FavouriteViewModel extends StateNotifier<FavouriteState> {
  final FavouriteUseCase fetchFavouriteUseCase;

  FavouriteViewModel(this.fetchFavouriteUseCase) : super(FavouriteState.initial());

  Future<void> fetchFavourite() async {
    state = state.copyWith(isLoading: true);
    final result = await fetchFavouriteUseCase();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (favourite) {
        state = state.copyWith(isLoading: false, favourite: favourite);
      },
    );
  }

   removeFavourite(String s) async {
     final result = await fetchFavouriteUseCase.removeFavourite(s);
     result.fold(
       (failure) {
         showMySnackBar(message: failure.error, color: Colors.red);
       },
       (data) {
         fetchFavourite();
         showMySnackBar(message: 'Removed from Favourites', color: Colors.red);
       },
     );
    fetchFavourite();
   }
}
