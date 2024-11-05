import 'package:final_assignment/features/booking/data/model/booking_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_booking_dto.g.dart';

@JsonSerializable()
class GetBookingDto {
  final bool success;
  final List<BookingApiModel> data;

  GetBookingDto({required this.success, required this.data});

  factory GetBookingDto.fromJson(Map<String, dynamic> json) =>
      _$GetBookingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookingDtoToJson(this);
}
