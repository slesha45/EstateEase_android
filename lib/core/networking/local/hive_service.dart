import 'package:final_assignment/app/contants/hive_table_constant.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
 
final hiveserviceProvider = Provider((ref) => HiveService());
 
class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
 
    // Register Adapters
 
    Hive.registerAdapter(AuthHiveModelAdapter());
  }
 
  //================ User Query =================
 
  // Register Query
  Future<void> registerUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }
 
  // login Query
  Future<AuthHiveModel?> loginUser(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password,
        orElse: () => AuthHiveModel.empty());
    return user;
  }
 
  // logout Query
  Future<void> logoutUser() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.clear();
  }
 
  // getuser by email
  Future<AuthHiveModel?> getUserByEmail(String email) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
      (element) => element.email == email,
      orElse: () => AuthHiveModel.empty(),
    );
 
    return user;
  }
}