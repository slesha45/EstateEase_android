
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
 
 
class SinglePropertyState {
  final PropertyEntity? singleProperty;
  final bool isLoading;
  final String? error;
  final int selectedQuantity;
 
  SinglePropertyState({
    required this.singleProperty,
    required this.isLoading,
    required this.error,
    required this.selectedQuantity,
  });
 
  factory SinglePropertyState.initial() => SinglePropertyState(
        singleProperty: null,
        isLoading: false,
        error: null,
        selectedQuantity: 1,
      );
 
  SinglePropertyState copyWith({
    PropertyEntity? singleProperty,
    bool? isLoading,
    String? error,
    int? selectedQuantity,
  }) {
    return SinglePropertyState(
      singleProperty: singleProperty ?? this.singleProperty,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedQuantity: selectedQuantity ?? this.selectedQuantity,
    );
  }
}