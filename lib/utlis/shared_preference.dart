import 'dart:convert';

import 'package:to_do_project/data/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String USER_DATA = 'user_data'; 

final sharedPreference = SharedPreferenceHelper();

@injectable
class SharedPreferenceHelper {
  late SharedPreferences _storage;

  static final SharedPreferenceHelper _instance = SharedPreferenceHelper._internal();
  
  factory SharedPreferenceHelper() {
    return _instance;
  }
  
  SharedPreferenceHelper._internal();

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }


  Future<bool> saveUser(UserModel user) {
    final jsonString = jsonEncode(user.toJson());
    return _storage.setString(USER_DATA, jsonString);
  }

  UserModel? getUser() {
    final userData = _storage.getString(USER_DATA);
    if (userData == null) return null;

    try {
      final Map<String, dynamic> json = jsonDecode(userData);
      return UserModel.fromJson(json);
    } catch (e) {
      clearUser();
      return null;
    }
  }

  Future<void> clearUser() async {
    await _storage.remove(USER_DATA);
  }
}