// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyApiModel _$PropertyApiModelFromJson(Map<String, dynamic> json) =>
    PropertyApiModel(
      id: json['_id'] as String?,
      propertyTitle: json['propertyTitle'] as String,
      propertyPrice: (json['propertyPrice'] as num).toInt(),
      propertyCategory: json['propertyCategory'] as String,
      propertyLocation: json['propertyLocation'] as String,
      propertyImage: json['propertyImage'] as String,
    );

Map<String, dynamic> _$PropertyApiModelToJson(PropertyApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'propertyTitle': instance.propertyTitle,
      'propertyPrice': instance.propertyPrice,
      'propertyCategory': instance.propertyCategory,
      'propertyLocation': instance.propertyLocation,
      'propertyImage': instance.propertyImage,
    };
