// import 'package:equatable/equatable.dart';
// import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'booking_api_model.g.dart';

// final bookingApiModelProvider = Provider<BookingApiModel>((ref) => BookingApiModel.empty());

// @JsonSerializable()
// class BookingApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   final  userId;
//   final  propertyId;
//   final DateTime date;
//   final String time;
//   final String status;
//   final String paymentMethod;

//   const BookingApiModel({
//      this.id,
//      this.userId,
//      this.propertyId,
//     required this.date,
//     required this.time,
//     this.status = 'pending',
//     this.paymentMethod = 'Cash on arrival',
//   });

//   // Factory constructor for creating an empty instance
//   factory BookingApiModel.empty() {
//     return BookingApiModel(
//       id: '',
//       userId: '',
//       propertyId: '',
//       date: DateTime.now(),
//       time: '',
//       status: 'pending',
//       paymentMethod: 'Cash on arrival',
//     );
//   }

//   @override
//   List<Object?> get props => [id, userId, propertyId, date, time, status, paymentMethod];

//   // Factory method for creating an instance from JSON
//   factory BookingApiModel.fromJson(Map<String, dynamic> json) => _$BookingApiModelFromJson(json);

//   // Method to convert instance to JSON
//   Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

//   // Convert API model to Entity
//   BookingEntity toEntity() {
//     return BookingEntity(
//       userId: userId,
//       propertyId: propertyId,
//       date: date,
//       time: time,
//       status: status,
//       paymentMethod: paymentMethod,
//     );
//   }

//   // Static method to create an API model from an Entity
//   static BookingApiModel fromEntity(BookingEntity entity) {
//     return BookingApiModel(
//       id: entity.userId,
//       userId: entity.userId,
//       propertyId: entity.propertyId,
//       date: entity.date,
//       time: entity.time,
//       status: entity.status,
//       paymentMethod: entity.paymentMethod,
//     );
//   }
// }
import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/auth/data/model/auth_api_model.dart';
import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_api_model.g.dart';

final bookingModelProvider = Provider<BookingApiModel>((ref) {
  return BookingApiModel.empty();
});

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  // @JsonKey(name: 'userId')
  final String? user;
  // @JsonKey(name: 'propertyId')
  final String property;
  final DateTime date;
  final String time;
  final String status;
  final String paymentMethod;
  final AuthApiModel? authEntity;

  const BookingApiModel({
    this.id,
    required this.user,
    required this.property,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.paymentMethod = 'Pay on arrival',
    this.authEntity,
  });

  BookingApiModel.empty()
      : id = '',
        user = '',
        property = '',
        date = DateTime.now(),
        time = '',
        paymentMethod = 'Pay on arrival',
        status = '',
        authEntity = const AuthApiModel.empty();

  // from json
  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

// from entity
  factory BookingApiModel.fromEntity(BookingEntity entity) => BookingApiModel(
        id: entity.id,
        user: entity.user,
        property: entity.property,
        date: entity.date,
        time: entity.time,
        paymentMethod: entity.paymentMethod,
        status: entity.status,
        authEntity: entity.authEntity != null
            ? AuthApiModel.fromEntity(entity.authEntity!)
            : null,
      );

  // to entity
  BookingEntity toEntity() => BookingEntity(
        id: id,
        user: user,
        property: property,
        date: date,
        time: time,
        paymentMethod: paymentMethod,
        status: status,
        authEntity: authEntity?.toEntity(),
      );

  // to entity list
  static List<BookingEntity> toEntities(List<BookingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        user,
        property,
        date,
        time,
        paymentMethod,
        status,
        authEntity,
      ];
}
