// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
 
class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String email;
  final int phone;
  final String password;
 
  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.password,
  });
 
  @override
  List<Object?> get props => [
        userId,
        fName,
        lName,
        email,
        phone,
        password,
      ];
}