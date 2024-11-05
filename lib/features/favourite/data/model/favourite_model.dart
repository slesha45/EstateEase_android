import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/favourite/domain/entity/favourite_entity.dart';
import 'package:final_assignment/features/home/data/model/property_api_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_model.g.dart';

final favouriteApiModelProvider = Provider<Favourite>((ref) {
  return const Favourite.empty();
});

@JsonSerializable()
class Favourite extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final PropertyApiModel properties;
  final AuthApiModel user;

  const Favourite({
    required this.id,
    required this.properties,
    required this.user,
  });

  // empty
  const Favourite.empty()
      : id = '',
        properties = const PropertyApiModel.empty(),
        user = const AuthApiModel.empty();

  factory Favourite.fromJson(Map<String, dynamic> json) =>
      _$FavouriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteToJson(this);

  // to entity
  FavouriteEntity toEntity() {
    return FavouriteEntity(
      id: id,
      properties: properties.toEntity(),
      user: user.toEntity(),
    );
  }

  // from entity
  factory Favourite.fromEntity(FavouriteEntity entity) {
    return Favourite(
      id: entity.id,
      properties: PropertyApiModel.fromEntity(entity.properties),
      user: AuthApiModel.fromEntity(entity.user),
    );
  }

  // to entity list
  static List<Favourite> toEntityList(List<FavouriteEntity> favourites) {
    return favourites
        .map((favourite) => Favourite.fromEntity(favourite))
        .toList();
  }

  // from entity list
  static List<FavouriteEntity> fromEntityList(List<Favourite> favourites) {
    return favourites.map((favourite) => favourite.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, properties, user];
}
