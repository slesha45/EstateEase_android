import 'package:equatable/equatable.dart';

class PropertyEntity extends Equatable{
  final String ? id;
  final String propertyTitle;
  final int propertyPrice;
  final String propertyCategory;
  final String propertyLocation;
  final String propertyImage;
  
  const PropertyEntity({
    required this.id,
    required this.propertyTitle,
    required this.propertyPrice,
    required this.propertyCategory,
    required this.propertyLocation,
    required this.propertyImage,
  });

  @override
  List<Object?> get props => [ id, propertyTitle, propertyPrice, propertyCategory, propertyLocation, propertyImage];
}