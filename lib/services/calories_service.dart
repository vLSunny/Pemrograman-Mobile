class CaloriesService {
  static double getTodayTotal() {
    // Mock data - replace with actual implementation
    return 760.0;
  }

  static Stream<double> get caloriesUpdates {
    return Stream.periodic(Duration(seconds: 1), (_) => getTodayTotal());
  }
}
