import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';
 
part 'auth_hive_model.g.dart';
 
final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);
 
@HiveType(typeId: 0)
class AuthHiveModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String fName;
 
  @HiveField(2)
  final String lName;
 
  @HiveField(3)
  final String email;
 
  @HiveField(4)
  final String password;

  @HiveField(5)
  final int phone;
  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fName,
    required this.lName,
    required this.email,
    required this.password,
    required this.phone,
  }) : userId = userId ?? const Uuid().v4();
  // Empty Constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fName: '',
          lName: '',
          email: '',
          phone: 0,
          password: '',
        );
 
  AuthEntity toEntity() => AuthEntity(
        userId: userId,
        fName: fName,
        lName: lName,
        email: email,
        phone: phone,
        password: password,
      );
 
  AuthHiveModel fromEntity(AuthEntity entity) => AuthHiveModel(
        userId: const Uuid().v4(),
        fName: entity.fName,
        lName: entity.lName,
        email: entity.email,
        phone: entity.phone,
        password: entity.password,
      );
 
  List<AuthEntity> toEntities(List<AuthHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();
 
  List<AuthHiveModel> fromEntities(List<AuthEntity> entities) =>
      entities.map((entity) => fromEntity(entity)).toList();
 
  @override
  String toString() {
    return 'AuthHiveModel(userId: $userId, fName: $fName, lName: $lName, email: $email, phone: $phone, password: $password)';
  }
}