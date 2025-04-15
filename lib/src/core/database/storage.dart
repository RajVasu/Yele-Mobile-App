import 'package:hive_flutter/hive_flutter.dart';
import 'package:yele/src/features/auth/login/model/user_model.dart';

abstract class StorageString {
  static const String authenticationBoxName = 'always-outdoor';
  static const String user = 'user';
  static const String accessToken = 'access-token';
}

class Storage {
  Storage._();
  static Storage instance = Storage._();

  Future<void> setToken(String token) async {
    final box = Hive.box(StorageString.authenticationBoxName);
    await box.put(StorageString.accessToken, token);
  }

  String? getToken() {
    final box = Hive.box(StorageString.authenticationBoxName);
    return box.get(StorageString.accessToken, defaultValue: null);
  }

  Future<void> setUser(UserModel user) async {
    final box = Hive.box(StorageString.authenticationBoxName);
    await box.put(StorageString.user, user.toJson());
  }

  UserModel? getUser() {
    final box = Hive.box(StorageString.authenticationBoxName);
    final data = box.get(StorageString.user, defaultValue: null);
    if (data == null) return null;
    return UserModel.fromJson({...data});
  }

  Future<void> clearAuthenticationBox() async {
    final box = Hive.box(StorageString.authenticationBoxName);
    await box.clear();
  }

  Future<void> clear() async {
    final authenticationBox = Hive.box(StorageString.authenticationBoxName);
    await authenticationBox.clear();
  }
}
