import 'package:final_assignment/features/home/domain/entity/property_entity.dart';

class PropertyState {
  final List<PropertyEntity> property;
  final bool hasReachedMax;
  final int page;
  final bool isLoading;

  PropertyState({
    required this.property,
    required this.hasReachedMax,
    required this.page,
    required this.isLoading,
  });

  factory PropertyState.initial() {
    return PropertyState(
      property: [],
      hasReachedMax: false,
      page: 0,
      isLoading: false,
    );
  }

  PropertyState copyWith({
    List<PropertyEntity>? property,
    bool? hasReachedMax,
    int? page,
    bool? isLoading,
  }) {
    return PropertyState(
      property: property ?? this.property,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
