import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'user_data';
  static const String _settingsKey = 'app_settings';
  static const String _workoutKey = 'workout_data';
  static const String _mealKey = 'meal_data';
  static const String _progressKey = 'progress_data';

  // Secure storage for sensitive data
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Shared preferences for non-sensitive data
  static late SharedPreferences _prefs;

  // Initialize the service
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User data methods
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString(_userKey, jsonEncode(userData));
  }

  static Map<String, dynamic>? getUserData() {
    final data = _prefs.getString(_userKey);
    return data != null ? jsonDecode(data) : null;
  }

  static Future<void> clearUserData() async {
    await _prefs.remove(_userKey);
  }

  // Secure storage methods for sensitive data
  static Future<void> saveSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  static Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Settings methods
  static Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _prefs.setString(_settingsKey, jsonEncode(settings));
  }

  static Map<String, dynamic>? getSettings() {
    final data = _prefs.getString(_settingsKey);
    return data != null ? jsonDecode(data) : null;
  }

  // Workout data methods
  static Future<void> saveWorkoutData(
    List<Map<String, dynamic>> workouts,
  ) async {
    await _prefs.setString(_workoutKey, jsonEncode(workouts));
  }

  static List<Map<String, dynamic>> getWorkoutData() {
    final data = _prefs.getString(_workoutKey);
    return data != null
        ? List<Map<String, dynamic>>.from(jsonDecode(data))
        : [];
  }

  // Meal data methods
  static Future<void> saveMealData(List<Map<String, dynamic>> meals) async {
    await _prefs.setString(_mealKey, jsonEncode(meals));
  }

  static List<Map<String, dynamic>> getMealData() {
    final data = _prefs.getString(_mealKey);
    return data != null
        ? List<Map<String, dynamic>>.from(jsonDecode(data))
        : [];
  }

  // Progress data methods
  static Future<void> saveProgressData(Map<String, dynamic> progress) async {
    await _prefs.setString(_progressKey, jsonEncode(progress));
  }

  static Map<String, dynamic>? getProgressData() {
    final data = _prefs.getString(_progressKey);
    return data != null ? jsonDecode(data) : null;
  }

  // Alarm data methods
  static const String _alarmKey = 'alarm_data';

  static Future<void> saveAlarmData(List<Map<String, dynamic>> alarms) async {
    await _prefs.setString(_alarmKey, jsonEncode(alarms));
  }

  static List<Map<String, dynamic>> getAlarmData() {
    final data = _prefs.getString(_alarmKey);
    return data != null
        ? List<Map<String, dynamic>>.from(jsonDecode(data))
        : [];
  }

  // Generic methods for any data type
  static Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else {
      await _prefs.setString(key, jsonEncode(value));
    }
  }

  static dynamic getData(String key) {
    return _prefs.get(key);
  }

  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }

  // Clear all data
  static Future<void> clearAllData() async {
    await _prefs.clear();
  }

  // Check if data exists
  static bool hasData(String key) {
    return _prefs.containsKey(key);
  }

  // Get all keys
  static Set<String> getAllKeys() {
    return _prefs.getKeys();
  }
}
