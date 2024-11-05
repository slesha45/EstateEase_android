import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';

class FavoritePropertiesNotifier extends StateNotifier<List<PropertyEntity>> {
  FavoritePropertiesNotifier() : super([]);

  void addProperty(PropertyEntity property) {
    state = [...state, property];
  }

  void removeProperty(PropertyEntity property) {
    state = state.where((p) => p != property).toList();
  }
}

final favoritePropertiesProvider =
    StateNotifierProvider<FavoritePropertiesNotifier, List<PropertyEntity>>(
        (ref) => FavoritePropertiesNotifier());
