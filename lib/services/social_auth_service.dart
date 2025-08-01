import '../models/user_model.dart';
import 'auth_service.dart';
import 'user_storage_service.dart';

class SocialAuthService {
  // Mock Facebook Login
  static Future<Map<String, dynamic>> loginWithFacebook() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Create mock Facebook user
      final facebookUser = UserModel(
        id: 'facebook_${DateTime.now().millisecondsSinceEpoch}',
        email: 'facebook_user@demo.com',
        password: 'facebook_auth_token',
        name: 'Facebook User',
        age: 28,
        height: 175,
        weight: 70,
      );

      // Register user if not exists
      final existingUsers = await UserStorageService.getAllUsers();
      final existingUser = existingUsers.firstWhere(
        (u) => u.email == facebookUser.email,
        orElse: () => facebookUser,
      );

      if (existingUser.id != facebookUser.id) {
        await UserStorageService.registerUser(facebookUser);
      }

      await AuthService.setCurrentUserId(facebookUser.id);

      return {
        'success': true,
        'message': 'Facebook login successful',
        'user': facebookUser,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Facebook login failed: ${e.toString()}',
      };
    }
  }

  // Mock Google Login
  static Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Create mock Google user
      final googleUser = UserModel(
        id: 'google_${DateTime.now().millisecondsSinceEpoch}',
        email: 'google_user@demo.com',
        password: 'google_auth_token',
        name: 'Google User',
        age: 25,
        height: 170,
        weight: 65,
      );

      // Register user if not exists
      final existingUsers = await UserStorageService.getAllUsers();
      final existingUser = existingUsers.firstWhere(
        (u) => u.email == googleUser.email,
        orElse: () => googleUser,
      );

      if (existingUser.id != googleUser.id) {
        await UserStorageService.registerUser(googleUser);
      }

      await AuthService.setCurrentUserId(googleUser.id);

      return {
        'success': true,
        'message': 'Google login successful',
        'user': googleUser,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Google login failed: ${e.toString()}',
      };
    }
  }

  // Mock Email OAuth Login
  static Future<Map<String, dynamic>> loginWithEmailOAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Create mock Email OAuth user
      final emailUser = UserModel(
        id: 'email_${DateTime.now().millisecondsSinceEpoch}',
        email: 'oauth_user@demo.com',
        password: 'email_auth_token',
        name: 'Email User',
        age: 30,
        height: 180,
        weight: 75,
      );

      // Register user if not exists
      final existingUsers = await UserStorageService.getAllUsers();
      final existingUser = existingUsers.firstWhere(
        (u) => u.email == emailUser.email,
        orElse: () => emailUser,
      );

      if (existingUser.id != emailUser.id) {
        await UserStorageService.registerUser(emailUser);
      }

      await AuthService.setCurrentUserId(emailUser.id);

      return {
        'success': true,
        'message': 'Email login successful',
        'user': emailUser,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Email login failed: ${e.toString()}',
      };
    }
  }
}
