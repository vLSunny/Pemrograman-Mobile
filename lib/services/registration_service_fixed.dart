import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';

class RegistrationService {
  static const String _userKey = 'current_user';
  static const String _isRegisteredKey = 'is_user_registered';

  static Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRegisteredKey) ?? false;
  }

  static Future<UserProfileModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return UserProfileModel.fromJson(
        Map<String, dynamic>.from(json.decode(userJson)),
      );
    }
    return null;
  }

  static Future<void> saveUserProfile(UserProfileModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
    await prefs.setBool(_isRegisteredKey, true);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_isRegisteredKey);
  }
}
