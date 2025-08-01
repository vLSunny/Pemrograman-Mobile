import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import 'user_storage_service.dart';

class AuthService {
  static const String _userIdKey = 'current_user_id';
  static const String _isFirstTimeKey = 'is_first_time';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final userId = await _secureStorage.read(key: _userIdKey);
    return userId != null && userId.isNotEmpty;
  }

  // Get current user ID
  static Future<String?> getCurrentUserId() async {
    return await _secureStorage.read(key: _userIdKey);
  }

  // Set current user ID
  static Future<void> setCurrentUserId(String userId) async {
    await _secureStorage.write(key: _userIdKey, value: userId);
    await _secureStorage.write(key: _isFirstTimeKey, value: 'false');
  }

  // Check if it's first time using app
  static Future<bool> isFirstTime() async {
    final isFirst = await _secureStorage.read(key: _isFirstTimeKey);
    return isFirst == null || isFirst == 'true';
  }

  // Login with email and password
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) {
      return {'success': false, 'message': 'Masukan email dan password'};
    }

    final isValid = await UserStorageService.loginUser(email, password);

    if (isValid) {
      final users = await UserStorageService.getAllUsers();
      final user = users.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse:
            () => UserModel(
              id: '',
              email: '',
              password: '',
              name: '',
              age: 0,
              height: 0,
              weight: 0,
            ),
      );

      if (user.id.isNotEmpty) {
        await setCurrentUserId(user.id);
        return {'success': true, 'message': 'Login successful', 'user': user};
      }
    }

    return {
      'success': false,
      'message': 'Email dan password salah/tidak terdaftar',
    };
  }

  // Register new user
  static Future<Map<String, dynamic>> register(UserModel user) async {
    if (user.email.isEmpty || user.password.isEmpty) {
      return {'success': false, 'message': 'Email dan password harus diisi'};
    }

    final success = await UserStorageService.registerUser(user);

    if (success) {
      await setCurrentUserId(user.id);
      return {'success': true, 'message': 'Registration successful'};
    } else {
      return {'success': false, 'message': 'Email sudah terdaftar'};
    }
  }

  // Logout user
  static Future<void> logout() async {
    await _secureStorage.delete(key: _userIdKey);
  }

  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    final userId = await getCurrentUserId();
    if (userId != null) {
      final users = await UserStorageService.getAllUsers();
      return users.firstWhere(
        (user) => user.id == userId,
        orElse:
            () => UserModel(
              id: '',
              email: '',
              password: '',
              name: '',
              age: 0,
              height: 0,
              weight: 0,
            ),
      );
    }
    return null;
  }

  // Social login methods
  static Future<Map<String, dynamic>> loginWithGoogle() async {
    // Implement Google Sign-In
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // For demo purposes, create a mock user
    final mockUser = UserModel(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      email: 'user@gmail.com',
      password: 'google_auth',
      name: 'Google User',
      age: 25,
      height: 170,
      weight: 65,
    );

    await setCurrentUserId(mockUser.id);
    return {
      'success': true,
      'message': 'Google login successful',
      'user': mockUser,
    };
  }

  static Future<Map<String, dynamic>> loginWithFacebook() async {
    // Implement Facebook Sign-In
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    // For demo purposes, create a mock user
    final mockUser = UserModel(
      id: 'facebook_${DateTime.now().millisecondsSinceEpoch}',
      email: 'user@facebook.com',
      password: 'facebook_auth',
      name: 'Facebook User',
      age: 28,
      height: 175,
      weight: 70,
    );

    await setCurrentUserId(mockUser.id);
    return {
      'success': true,
      'message': 'Facebook login successful',
      'user': mockUser,
    };
  }
}
