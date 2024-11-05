
import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'property_api_model.g.dart';

//provider
final propertyApiModelProvider =
    Provider<PropertyApiModel>((ref) => const PropertyApiModel.empty());

@JsonSerializable()
class PropertyApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String propertyTitle;
  final int propertyPrice;
  final String propertyCategory;
  final String propertyLocation;
  final String propertyImage;

  const PropertyApiModel({
    required this.id,
    required this.propertyTitle,
    required this.propertyPrice,
    required this.propertyCategory,
    required this.propertyLocation,
    required this.propertyImage,
  });

  const PropertyApiModel.empty()
      : id = '',
      propertyTitle = '',
      propertyPrice = 0,
      propertyCategory = '',
      propertyLocation = '',
      propertyImage = '';

  factory PropertyApiModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyApiModelToJson(this);

  // To Entity
  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      propertyTitle: propertyTitle,
      propertyPrice: propertyPrice,
      propertyCategory: propertyCategory,
      propertyLocation: propertyLocation,
      propertyImage: propertyImage,
    );
  }

  //Convert Entity to API Object
  factory PropertyApiModel.fromEntity(PropertyEntity entity) {
    return PropertyApiModel(
      id: entity.id,
      propertyTitle: entity.propertyTitle,
      propertyPrice: entity.propertyPrice,
      propertyCategory: entity.propertyCategory,
      propertyLocation: entity.propertyLocation,
      propertyImage: entity.propertyImage,
    );
  }

  //Convert API List to Entity List
  List<PropertyEntity> toEntityList(List<PropertyApiModel> property) {
    return property.map((property) => property.toEntity()).toList();
  }

  List<PropertyApiModel> fromEntityList(List<PropertyEntity> property) {
    return property.map((property) => PropertyApiModel.fromEntity(property)).toList();
  }

  @override
  List<Object?> get props => [
        id,
        propertyTitle,
        propertyPrice,
        propertyCategory,
        propertyLocation,
        propertyImage,
      ];
}
