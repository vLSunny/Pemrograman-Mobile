import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PlatformStorageService {
  static late SharedPreferences _prefs;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Initialize the service
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Universal storage method for sensitive data
  static Future<void> saveSecureData(String key, String value) async {
    if (kIsWeb) {
      // Use SharedPreferences for web (less secure but compatible)
      await _prefs.setString(key, value);
    } else {
      // Use secure storage for mobile
      await _secureStorage.write(key: key, value: value);
    }
  }

  static Future<String?> getSecureData(String key) async {
    if (kIsWeb) {
      return _prefs.getString(key);
    } else {
      return await _secureStorage.read(key: key);
    }
  }

  static Future<void> deleteSecureData(String key) async {
    if (kIsWeb) {
      await _prefs.remove(key);
    } else {
      await _secureStorage.delete(key: key);
    }
  }

  // Regular data storage (non-sensitive)
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

  // Check if data exists
  static bool hasData(String key) {
    return _prefs.containsKey(key);
  }
}
