import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final authLocalDataSourceProvider = Provider((ref) => AuthLocalDataSource(
      hiveService: ref.read(hiveserviceProvider),
      authHiveModel: ref.read(authHiveModelProvider),
    ));
 
class AuthLocalDataSource {
  final HiveService hiveService;
  final AuthHiveModel authHiveModel;
 
  AuthLocalDataSource({
    required this.hiveService,
    required this.authHiveModel,
  });
 
  Future<Either<Failure, bool>> registerUser(AuthEntity user) async {
    try {
      //If already email throw error
      final userByEmail = await hiveService.getUserByEmail(user.email);
      if (userByEmail!.email.isNotEmpty) {
        return Left(Failure(error: 'User already exist'));
      }
 
      // Convert Entity to model
      final hiveUser = authHiveModel.fromEntity(user);
 
      await hiveService.registerUser(hiveUser);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
  // login
 
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try {
      final user = await hiveService.loginUser(email, password);
 
      if (user?.email.isEmpty ?? true) {
        return Left(Failure(error: 'User not found'));
      }
      return const Right(true);
    } catch (error) {
      return Left(Failure(error: error.toString()));
    }
  }
}