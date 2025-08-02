import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';
import '../models/user_model.dart';

class UserStorageService {
  static const String _currentUserKey = 'current_user';
  static const String _isRegisteredKey = 'is_user_registered';

  // Save user profile (new registration system)
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user.toJson()));
    await prefs.setBool(_isRegisteredKey, true);
  }

  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_currentUserKey);
      if (userJson != null) {
        return UserModel.fromJson(jsonDecode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Check if user is registered
  static Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isRegisteredKey) ?? false;
  }

  // Update user profile
  static Future<void> updateUser(UserModel user) async {
    await saveUser(user);
  }

  // Clear user data (for reset/logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
    await prefs.remove(_isRegisteredKey);
  }

  // Add logoutUser method for compatibility
  static Future<void> logoutUser() async {
    await clearUserData();
  }

  // Legacy methods for compatibility with existing code
  static Future<UserProfileModel?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_currentUserKey);
      if (userJson != null) {
        // Try to convert UserModel to UserProfileModel for compatibility
        final user = UserModel.fromJson(jsonDecode(userJson));
        return UserProfileModel(
          id: user.id,
          email: '', // Not used in new system
          password: '', // Not used in new system
          name: user.name,
          age: user.age,
          height: user.height,
          weight: user.weight,
          dateOfBirth: DateTime.now().subtract(
            Duration(days: user.age * 365),
          ), // Approximate
          gender: user.gender,
          healthInfo: '', // Not used in new system
          phone: '', // Not used in new system
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> hasUserProfile() async {
    return await isUserRegistered();
  }

  static Future<void> saveUserProfile(UserProfileModel userProfile) async {
    // Convert UserProfileModel to UserModel for new system
    final user = UserModel(
      id:
          userProfile.id.isNotEmpty
              ? userProfile.id
              : DateTime.now().millisecondsSinceEpoch.toString(),
      name: userProfile.name,
      age: userProfile.age,
      height: userProfile.height,
      weight: userProfile.weight,
      gender: userProfile.gender,
      activityLevel: 'Sedang', // Default value
      fitnessGoal: 'Mempertahankan Berat Badan', // Default value
    );
    await saveUser(user);
  }

  static Future<void> updateUserProfile(UserProfileModel userProfile) async {
    await saveUserProfile(userProfile);
  }

  static Future<void> clearUserProfile() async {
    await clearUserData();
  }
}
