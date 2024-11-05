import 'package:final_assignment/features/home/domain/usecases/property_usecase.dart';
import 'package:final_assignment/features/home/presentation/state/property_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyViewModelProvider =
    StateNotifierProvider<PropertyViewmodel, PropertyState>(
        (ref) => PropertyViewmodel(
              propertyUsecase: ref.watch(propertyUsecaseProvider),
            ));

class PropertyViewmodel extends StateNotifier<PropertyState> {
  PropertyViewmodel({required this.propertyUsecase})
      : super(PropertyState.initial()) {
    getProperty();
  }

  final PropertyUsecase propertyUsecase;

  Future resetState() async {
    state = PropertyState.initial();
     await getProperty();
  }

  Future getProperty() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final property = currentState.property;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await propertyUsecase.pagination(page, 6);
      result.fold(
        (failure) =>
            state = state.copyWith(hasReachedMax: true, isLoading: false),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              property: [...property, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    }
  }
}
