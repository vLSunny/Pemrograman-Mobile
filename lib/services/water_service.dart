import 'dart:async';
import '../models/water_intake_model.dart';
import 'storage_manager.dart';

class WaterService {
  // Get all water intake records
  static List<WaterIntakeModel> getWaterIntake() {
    final progressData = StorageManager.getProgress();
    if (progressData == null || !progressData.containsKey('water_intake')) {
      return [];
    }

    final List<dynamic> waterList = progressData['water_intake'] ?? [];
    return waterList.map((item) => WaterIntakeModel.fromJson(item)).toList();
  }

  // Add water intake
  static Future<void> addWaterIntake(double amount, {String? note}) async {
    final waterIntake = WaterIntakeModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      timestamp: DateTime.now(),
      note: note,
    );

    final currentWater = getWaterIntake();
    currentWater.add(waterIntake);

    final progressData = StorageManager.getProgress() ?? {};
    progressData['water_intake'] = currentWater.map((e) => e.toJson()).toList();

    await StorageManager.saveProgress(progressData);
  }

  // Get today's total water intake in liters
  static double getTodayTotal() {
    final waterIntake = getWaterIntake();
    final today = DateTime.now();

    final todayWater =
        waterIntake.where((water) {
          return water.timestamp.year == today.year &&
              water.timestamp.month == today.month &&
              water.timestamp.day == today.day;
        }).toList();

    return todayWater.fold(0.0, (double sum, water) => sum + water.amount) /
        1000;
  }

  // Get today's water intake records
  static List<WaterIntakeModel> getTodayWaterIntake() {
    final waterIntake = getWaterIntake();
    final today = DateTime.now();

    return waterIntake.where((water) {
      return water.timestamp.year == today.year &&
          water.timestamp.month == today.month &&
          water.timestamp.day == today.day;
    }).toList();
  }

  // Clear all water data (for testing/debugging)
  static Future<void> clearWaterData() async {
    final progressData = StorageManager.getProgress() ?? {};
    progressData['water_intake'] = [];
    await StorageManager.saveProgress(progressData);
  }

  // Stream for real-time updates
  static StreamController<double> _waterUpdateController =
      StreamController<double>.broadcast();

  static Stream<double> get waterUpdates => _waterUpdateController.stream;

  static void notifyWaterUpdate() {
    _waterUpdateController.add(getTodayTotal());
  }

  static void dispose() {
    _waterUpdateController.close();
  }
}
