import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';

import 'package:final_assignment/features/home/domain/usecases/property_usecase.dart';

import 'package:final_assignment/features/single_property/presentation/state/single_property_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final singlePropertyViewModelProvider =
    StateNotifierProvider<SinglePropertyViewModel, SinglePropertyState>(
        (ref) => SinglePropertyViewModel(
              propertyUsecase: ref.watch(propertyUsecaseProvider),
              userSharedPrefs: ref.watch(userSharedPrefsProvider),
            ));
 
class SinglePropertyViewModel extends StateNotifier<SinglePropertyState> {
  SinglePropertyViewModel({
    required this.propertyUsecase,
    required this.userSharedPrefs,
  }) : super(SinglePropertyState.initial());
 
  final PropertyUsecase propertyUsecase;
  final UserSharedPrefs userSharedPrefs;
 
  Future<void> getSingleProperty (String propertyId) async {
    state = state.copyWith(isLoading: true);
    final result = await propertyUsecase.getPropertyById(propertyId);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      showMySnackBar(message: failure.error,color: Colors.red);
    }, (data) {
      state = state.copyWith(
        isLoading: false,
        singleProperty: data,
        error: null,
      );
    });
  }
 
  void updateSelectedQuantity(int quantity) {
    if (state.singleProperty != null &&
        quantity > state.singleProperty!.propertyPrice) {
      showMySnackBar(message: 'Out of stock', color: Colors.red);
      return;
    }
    if (quantity < 1) {
      showMySnackBar(
          message: 'Quantity cannot be less 1', color: Colors.red);
      return;
    }
    state = state.copyWith(selectedQuantity: quantity);
  }
}
 