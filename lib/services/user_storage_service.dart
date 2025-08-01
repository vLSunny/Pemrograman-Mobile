import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';
import '../models/user_model.dart';

class UserStorageService {
  static const String _currentUserKey = 'current_user';
  static const String _usersKey = 'users';

  // Save user profile
  static Future<void> saveUserProfile(UserProfileModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  // Get current user profile
  static Future<UserProfileModel?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_currentUserKey);
      if (userJson != null) {
        return UserProfileModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if user profile exists
  static Future<bool> hasUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_currentUserKey);
  }

  // Update user profile
  static Future<void> updateUserProfile(UserProfileModel user) async {
    await saveUserProfile(user);
  }

  // Clear user profile
  static Future<void> clearUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // User authentication methods
  static Future<bool> loginUser(String email, String password) async {
    final users = await getAllUsers();
    return users.any(
      (user) => user.email == email && user.password == password,
    );
  }

  static Future<bool> registerUser(UserModel user) async {
    final users = await getAllUsers();
    if (users.any((u) => u.email == user.email)) {
      return false; // User already exists
    }
    users.add(user);
    await _saveUsers(users);
    return true;
  }

  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('current_user_email');
    if (email != null) {
      final users = await getAllUsers();
      return users.firstWhere((user) => user.email == email);
    }
    return null;
  }

  static Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_email');
  }

  static Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_usersKey);
    if (usersJson != null) {
      final List<dynamic> decoded = jsonDecode(usersJson);
      return decoded.map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> _saveUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _usersKey,
      jsonEncode(users.map((u) => u.toJson()).toList()),
    );
  }

  static Future<bool> hasAnyUser() async {
    final users = await getAllUsers();
    return users.isNotEmpty;
  }
}
