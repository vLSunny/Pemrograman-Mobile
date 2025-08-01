class SleepService {
  static double getTodayTotal() {
    // Mock data - replace with actual implementation
    return 8.33; // 8 hours 20 minutes
  }

  static Stream<double> get sleepUpdates {
    return Stream.periodic(Duration(seconds: 1), (_) => getTodayTotal());
  }
}
