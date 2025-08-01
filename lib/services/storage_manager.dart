import '../models/user_model.dart';
import '../models/app_settings_model.dart';
import 'local_storage_service.dart';

class StorageManager {
  // User data
  static Future<void> saveUser(UserModel user) async {
    await LocalStorageService.saveUserData(user.toJson());
  }

  static UserModel? getUser() {
    final userData = LocalStorageService.getUserData();
    return userData != null ? UserModel.fromJson(userData) : null;
  }

  static Future<void> clearUser() async {
    await LocalStorageService.clearUserData();
  }

  // App settings
  static Future<void> saveSettings(AppSettingsModel settings) async {
    await LocalStorageService.saveSettings(settings.toJson());
  }

  static AppSettingsModel getSettings() {
    final settingsData = LocalStorageService.getSettings();
    return settingsData != null
        ? AppSettingsModel.fromJson(settingsData)
        : AppSettingsModel();
  }

  // Secure storage for sensitive data
  static Future<void> saveToken(String token) async {
    await LocalStorageService.saveSecureData('auth_token', token);
  }

  static Future<String?> getToken() async {
    return await LocalStorageService.getSecureData('auth_token');
  }

  static Future<void> clearToken() async {
    await LocalStorageService.deleteSecureData('auth_token');
  }

  static Future<void> savePassword(String password) async {
    await LocalStorageService.saveSecureData('user_password', password);
  }

  static Future<String?> getPassword() async {
    return await LocalStorageService.getSecureData('user_password');
  }

  static Future<void> clearPassword() async {
    await LocalStorageService.deleteSecureData('user_password');
  }

  // Workout data
  static Future<void> saveWorkout(Map<String, dynamic> workout) async {
    final workouts = getWorkouts();
    workouts.add(workout);
    await LocalStorageService.saveWorkoutData(workouts);
  }

  static List<Map<String, dynamic>> getWorkouts() {
    return LocalStorageService.getWorkoutData();
  }

  static Future<void> clearWorkouts() async {
    await LocalStorageService.saveWorkoutData([]);
  }

  // Meal data
  static Future<void> saveMeal(Map<String, dynamic> meal) async {
    final meals = getMeals();
    meals.add(meal);
    await LocalStorageService.saveMealData(meals);
  }

  static List<Map<String, dynamic>> getMeals() {
    return LocalStorageService.getMealData();
  }

  static Future<void> clearMeals() async {
    await LocalStorageService.saveMealData([]);
  }

  // Progress tracking
  static Future<void> saveProgress(Map<String, dynamic> progress) async {
    await LocalStorageService.saveProgressData(progress);
  }

  static Map<String, dynamic>? getProgress() {
    return LocalStorageService.getProgressData();
  }

  // First time app launch
  static Future<bool> isFirstLaunch() async {
    return !LocalStorageService.hasData('first_launch_completed');
  }

  static Future<void> setFirstLaunchCompleted() async {
    await LocalStorageService.saveData('first_launch_completed', true);
  }

  // Tutorial completion
  static Future<bool> hasSeenTutorial() async {
    return LocalStorageService.getData('tutorial_completed') ?? false;
  }

  static Future<void> setTutorialCompleted() async {
    await LocalStorageService.saveData('tutorial_completed', true);
  }

  // Onboarding completion
  static Future<bool> hasCompletedOnboarding() async {
    return LocalStorageService.getData('onboarding_completed') ?? false;
  }

  static Future<void> setOnboardingCompleted() async {
    await LocalStorageService.saveData('onboarding_completed', true);
  }

  // Last sync timestamp
  static Future<void> saveLastSync(DateTime timestamp) async {
    await LocalStorageService.saveData(
      'last_sync',
      timestamp.toIso8601String(),
    );
  }

  static DateTime? getLastSync() {
    final syncData = LocalStorageService.getData('last_sync');
    return syncData != null ? DateTime.parse(syncData) : null;
  }

  // Clear all data (for logout)
  static Future<void> clearAllData() async {
    await LocalStorageService.clearAllData();
  }
}
